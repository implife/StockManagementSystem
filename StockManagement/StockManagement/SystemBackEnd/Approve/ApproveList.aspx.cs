using StockManagement.DBSource;
using StockManagement.ORM.DBModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StockManagement.SystemBackEnd.Approve
{
    public partial class ApproveList : System.Web.UI.Page
    {

        private bool ReplenishIsAllowedInList(ORM.DBModels.Order order)
        {
            if (order.ReplenishID == null)
            {
                if (order.Status == 4 || order.Status == 3)
                    return true;
                else
                    return false;
            }
            else
                return ReplenishIsAllowedInList(OrderManager.GetOrderByOrderID((Guid)order.ReplenishID));
        }
        private void RenewOrderList(List<ORM.DBModels.Order> result, List<ORM.DBModels.Order> origin)
        {
            if (origin.Count() == 0)
            {
                return;
            }
            else
            {
                FindReplenishID(result, origin, origin[0]);
                RenewOrderList(result, origin);
            }
        }


        private void FindReplenishID(List<ORM.DBModels.Order> result, List<ORM.DBModels.Order> origin, ORM.DBModels.Order item)
        {
            result.Add(item);
            origin.Remove(item);

            if (item.ReplenishID != null)
            {
                ORM.DBModels.Order next = origin.Where(i => i.OrderID == item.ReplenishID).FirstOrDefault();
                FindReplenishID(result, origin, next);
            }
            else
            {
                return;
            }
        }

        private string ArrowOrNot(ORM.DBModels.Order orders)
        {
            if (orders.ReplenishID == null)
            {
                return "";
            }
            else
            {
                return $"<div class='center-con'>" +
                               $"<div class='round'>" +
                                   $"<div id='cta'>" +
                                       $"<span class='arrow primera next'></span>" +
                                       $"<span class='arrow segunda next'></span>" +
                                   $"</div>" +
                               $"</div>" +
                           $"</div>";
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (HD_Btn.Value != null)
                {
                    string id = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
                    Guid guid = Guid.Parse(id);

                    Guid btn_Order_ID = Guid.Parse(HD_Btn.Value.Split(',')[0]);
                    string btn_Order_behavior = HD_Btn.Value.Split(',')[1];

                    ORM.DBModels.Order order = DBSource.OrderManager.GetOrderByOrderID(btn_Order_ID);


                    switch (btn_Order_behavior)
                    {
                        case "Review":
                            order.ArchiveResponsiblePerson = guid;
                            DBSource.OrderManager.UpdateDeliverCompleteToComplete(order);
                            break;
                        case "Modify":
                            order.OrderResponsiblePerson = guid;
                            this.Response.Redirect($"/SystemBackEnd/Order/OrderModify.aspx?OrderID={order.OrderID}");
                            break;
                        case "Approve":
                            order.OrderResponsiblePerson = guid;
                            DBSource.OrderManager.UpdateoWaitForReviewedToNotDeliver(order);
                            break;
                    }
                }
            }

            var AllOderList = OrderManager.GetOrderList();
            List<ORM.DBModels.Order> OrderList = AllOderList.Where(obj => 
            {
                bool isAllow = false;
                if (obj.Status == 2)
                    isAllow = this.ReplenishIsAllowedInList(obj);
                return obj.Status == 3 || obj.Status == 4 || isAllow;
            }).OrderBy(obj => obj.OrderDate).ToList();

            if(OrderList.Count == 0)
            {
                this.ltlOrderList.Text = "<h4 class='NoApproveData'>無需要審核項目</h4>";
                return;
            }



            List<ORM.DBModels.Order> result = new List<ORM.DBModels.Order>();
            RenewOrderList(result, OrderList);

            bool ColoredOrNot = false;


            foreach (ORM.DBModels.Order orders in result)
            {
                string RID = orders.ReplenishID == null ? " - " : orders.ReplenishID.ToString();
                string ARP;
                string RP;
                ORM.DBModels.UserInfo ArrivaluserInfo = DBSource.UserInfoManager.GetUserInfoByUserID(orders.ArrivalResponsiblePerson);
                if (ArrivaluserInfo == null)
                {
                    ARP = " - ";
                }
                else
                {
                    ARP = ArrivaluserInfo.Name;
                }
                ORM.DBModels.UserInfo OrderUserInfo = DBSource.UserInfoManager.GetUserInfoByUserID(orders.OrderResponsiblePerson);
                if (OrderUserInfo == null)
                {
                    RP = " - ";
                }
                else
                {
                    RP = OrderUserInfo.Name;
                }

                string OrderHead = "";
                if (orders.ReplenishID != null)
                {
                    ColoredOrNot = true;
                    OrderHead = $"<th scope='row' style='color:#dd7b5c'>編號：{orders.OrderID.ToString().Split('-')[0]}</th>";
                }
                else
                {
                    if (ColoredOrNot)
                        OrderHead = $"<th scope='row' style='color:#dd7b5c'>編號：{orders.OrderID.ToString().Split('-')[0]}</th>";
                    else
                        OrderHead = $"<th scope='row'>編號：{orders.OrderID.ToString().Split('-')[0]}</th>";
                    ColoredOrNot = false;

                }
                ltlOrderList.Text +=
                    $"<div class='accordion-item'>" +
                        $"<h2 class='accordion-header' id='Heading_{orders.OrderID}'>" +
                            $"<button class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-target='#collapse_{orders.OrderID}' aria-expanded='true' aria-controls='collapseOne'>" +
                                $"<table class='table' style='margin-bottom:0%;'>" +
                                    $"<tbody class='ContentTbody'>" +
                                        $"<tr>" +

                                                OrderHead +

                                                $"<td>訂貨日期：{orders.OrderDate.ToString("yyyy/MM/dd HH:mm")}</td>" +
                                                $"<td>點貨員：{ARP}</td>" +
                                                $"<td>負責人：{RP}</td>" +
                                        $"</tr>" +
                                     $"</tbody>" +
                                 $"</table>" +
                               $"</button>" +
                           $"</h2>";
                /*以上為待審核單據的Title(需單號,訂貨日期,點貨員,負責人)*/
                ltlOrderList.Text +=
                          ArrowOrNot(orders) +
                    /*以上是箭頭動畫*/
                    $"<div id='collapse_{orders.OrderID}' class='accordion-collapse collapse' aria-labelledby='headingOne' data-bs-parent='#accordionExample'>" +
                        $"<div class='Accordion_Body_{orders.OrderID}'>" +
                             $"<div class='accordion-body'>" +
                                $"<div id='List_Group_{orders.OrderID}' class='list-group'>" +
                                    $"<a class='list-group-item disabled'>" +
                                        $"<div class='row'>" +
                                            $"<div class='col-4'>" +
                                                $"<small>專輯名稱</small>" +
                                                $"</div>" +
                                                $"<div class='col-2'>" +
                                                $"<samll>數量</samll>" +
                                                $"</div>" +
                                                $"<div class='col-2'>" +
                                                $"<samll>異常</samll>" +
                                                $"</div>" +
                                                $"<div class='col-2'>" +
                                                $"<samll>備註</samll>" +
                                                $"</div>" +
                                                $"<div class='col-2'>" +
                                                $"<samll>單類</samll>" +
                                                $"</div>" +
                                           $"</div>" +
                                     $"</a>";

                var ErrorList = OrderManager.GetOrderErrorListByOrderID(orders.OrderID);
                var OrderSalesDetail = OrderManager.GetDetailByOrder(orders);
                /*以下為待審核單據的細項(需訂購商品,數量,缺少數量,備註,單類)*/
                foreach (ORM.DBModels.OrderSalesDetail OSD in OrderSalesDetail)
                {
                    Guid SerialCode = (Guid)OSD.SerialCode;
                    CompactDisc CD = DBSource.CDManager.GetCDBySerialCode(SerialCode);

                    var err = ErrorList?.Where(s => s.SerialCode == OSD.SerialCode).FirstOrDefault();
                    string ERR;
                    string DES;
                    string Type;
                    if (err == null)
                    {
                        ERR = " - ";
                        DES = " - ";
                        Type = " - ";
                    }
                    else
                    {
                        ERR = err.Quantity.ToString();
                        DES = err.Remark;
                        Type = "補貨";
                    }

                    ltlOrderList.Text +=
                                    $"<a class='list-group-item list-group-item-action ToolTip_Item'>" +
                                         $"<div class='row'>" +
                                             $"<div class='col-4'>{CD.Name}</div>" +
                                             $"<div class='col-2'>{OSD.Quantity}</div>" +
                                             $"<div class='col-2'>{ERR}</div>" +
                                             $"<div class='col-2'>{DES}</div>" +
                                             $"<div class='col-2'>{Type}</div>" +
                                         $"</div>" +
                                         $"<div class='MyToolTip'>" +
                                             $"<h5>{CD.Name}</h5>" +
                                             $"<p>音樂家：{CD.Artist}</p>" +
                                             $"<p>發行公司：{CD.Brand}</p>" +
                                             $"<p>發行日期：{CD.PublicationDate}</p>" +
                                             $"<p>地區：{CD.Region}</p>" +
                                             $"<p>單價：{OSD.UnitPrice}</p>" +
                                         $"</div>" +
                                    $"</a>";
                }

                var BottonShow = "";
                if (orders.Status == 2)
                {
                    BottonShow = "";


                }
                else if (orders.Status == 3)
                {
                    BottonShow =
                      $"<input type = 'submit' value='歸檔' class='btn btn-outline-primary btn_Review' style='width:3rem; height:2rem;' />";


                }
                else if (orders.Status == 4)
                {
                    BottonShow =
                      $"<input type = 'submit' value='核可' class='btn btn-outline-primary btn_Approve' style='width:3rem; height:2rem;' />";
                      //$"<input type = 'submit' value='修改' class='btn btn-outline-primary btn_Modify' style='width:3rem; height:2rem;' />";
                }



                ltlOrderList.Text +=    /*以上為待審核單據的細項(需訂購商品,數量,缺少數量,備註,單類)*/

                                    $"<div class='col-12' style='text-align:center; padding-top:1rem;'>" +
                                        BottonShow +
                                         $"<br/>" +
                                    $"</div>" +
                                 $"</div>" +
                             $"</div>" +
                         $"</div>" +
                     $"</div>" +
                   $"</div>";


                //$/*('input[class$=btn_Review]').click*/


            }
        }
    }
}