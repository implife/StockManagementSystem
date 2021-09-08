using StockManagement.DBSource;
using StockManagement.ORM.DBModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StockManagement.SystemBackEnd.Order
{
    public partial class CheckGoods : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string OID = this.Request.QueryString["OID"];
            if (OID == null)
            {
                this.Response.StatusCode = 400;
                this.Response.End();
                return;
            }
            else
            {
                Guid gid = Guid.Parse(OID);
                List<OrderSalesDetail> details = OrderManager.GetDetailByOrder(new ORM.DBModels.Order() { OrderID = gid });

                if (details == null)
                {
                    this.Response.StatusCode = 400;
                    this.Response.End();
                    return;
                }
                else
                {
                    this.ltlTitleID.Text = $"<h4>{gid.ToString().Split('-')[0]}</h4>";
                    foreach (OrderSalesDetail orderDetail in details)
                    {
                        CompactDisc cdItem = CDManager.GetCDBySerialCode(orderDetail.SerialCode);

                        // 左邊的ItemList
                        this.ltlItemList.Text +=
                            $"<div class='GoodsOkCheckContainer row'>" +
                                $"<div class='GoodsOkCheckbox col-1'>" +
                                    $"<input type='checkbox' id='ItemCB{cdItem.SerialCode}' class='GoodsOkCheckInput'>" +
                                    $"<label for='ItemCB{cdItem.SerialCode}' class='GoodsOkCheckLabel'>" +
                                        $"<div class='tick'></div>" +
                                    $"</label></div>" +
                            $"<div class='col-11'>" +
                                $"<a class='list-group-item list-group-item-action myActive' href='#ID{cdItem.SerialCode}'>" +
                                $"<div class='row'>" +
                                    $"<div class='col-6'>{cdItem.Name}</div>" +
                                    $"<div class='col-2'><small>{orderDetail.Quantity}</small></div>" +
                                    $"<div class='col-2'><small>{orderDetail.UnitPrice}</small></div>" +
                                    $"<div class='col-2'><small>--</small></div>" +
                            $"</div></a></div></div>";

                        // 右邊隱藏的細項Tab Pane
                        this.ltlTabPane.Text +=
                            $"<div class='mytab-pane' id='ID{cdItem.SerialCode}'>" +
                                $"<h5>{cdItem.Name}</h5>" +
                                $"<p><b>發行公司:</b>{cdItem.Brand}</p>" +
                                $"<p><b>音樂家:</b>{cdItem.Artist}</p>" +
                                $"<p><b>地區:</b>{cdItem.Region}</p>" +
                                $"<p><b>發行日:</b>{cdItem.PublicationDate.ToString("yyyy-MM-dd")}</p>" +
                                $"<div class='form-check form-switch'>" +
                                    $"<input class='form-check-input' type='checkbox' id='GSwitch{cdItem.SerialCode}'>" +
                                    $"<label class='form-check-label' for='GSwitch{cdItem.SerialCode}'>訂單異常</label>" +
                                $"</div>" +
                                $"<div class='ErrorSwitchField'>" +
                                    $"<div class='row'>" +
                                        $"<div class='ErrorRadioContainer'>" +
                                            $"<label for='ErrRadioMinus{cdItem.SerialCode}'>少送</label>" +
                                            $"<input id='ErrRadioMinus{cdItem.SerialCode}' type='radio' name='err{cdItem.SerialCode}' value='1'>" +
                                            $"<label for='ErrRadioBroken{cdItem.SerialCode}'>損毀</label>" +
                                            $"<input id='ErrRadioBroken{cdItem.SerialCode}' type='radio' name='err{cdItem.SerialCode}' value='2'>" +
                                        $"</div>" +
                                        $"<div class='col-6 offset-md-1'>" +
                                            $"<label for='ErrQuantity{cdItem.SerialCode}'>數量</label>" +
                                            $"<input class='form-control' id='ErrQuantity{cdItem.SerialCode}' type='number' name='ErrQua' value='1' min='1' max='999' style='width: auto'>" +
                                            $"<label for='ErrRemark{cdItem.SerialCode}'>備註</label>" +
                                            $"<input class='form-control' id='ErrRemark{cdItem.SerialCode}' type='text' name='ErrRemark'>" +
                                         $"</div>" +
                                    $"</div>" +
                                    $"<button type='button' class='btn btn-outline-primary' style='margin-left: 70%; margin-top: 15px;'>確定</button>" +
                            $"</div></div>";
                    }
                }
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            string checkedStr = this.HFCheckedGoods.Value;
            string ErrorStr = this.HFErrorGoods.Value;

            CheckedGoods[] checkedGoods = Newtonsoft.Json.JsonConvert.DeserializeObject<CheckedGoods[]>(checkedStr);
            ErrorGoods[] errorGoods = Newtonsoft.Json.JsonConvert.DeserializeObject<ErrorGoods[]>(ErrorStr);

            List<bool> updateStockIsSuccess = new List<bool>();
            foreach (CheckedGoods item in checkedGoods)
            {
                bool isSuccess = CDStockManager.UpdateTotalStock(Guid.Parse(item.ItemID), item.ActualQuantity);
                updateStockIsSuccess.Add(isSuccess);
            }

            // 更新庫存是否成功
            if (updateStockIsSuccess.Contains(false))
            {
                throw new Exception("Update Stock Failed.");
            }

            // 資料庫中的該筆Order
            string OID = this.Request.QueryString["OID"];
            ORM.DBModels.Order order = OrderManager.GetOrderByOrderID(Guid.Parse(OID));

            // 點貨負責人
            string UID = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
            Guid gid = Guid.Parse(UID);
            ORM.DBModels.UserInfo ARPerson = UserInfoManager.GetUserInfoByUserID(gid);

            order.ArrivalResponsiblePerson = ARPerson.UserID;

            bool updateIsSuccess;
            if (errorGoods.Length == 0)
            {
                updateIsSuccess = OrderManager.UpdateOrderToDeliverComplete(order);
            }
            else
            {
                // 新的OrderError的List
                List<OrderError> orderError = errorGoods.Select(item => new OrderError()
                {
                    ErrorCode = item.ErrorCode,
                    SerialCode = Guid.Parse(item.ItemID),
                    Quantity = item.Quantity,
                    Remark = item.Remark
                }).ToList();

                // 新的Order的Detail
                List<OrderSalesDetail> newDetails = errorGoods.Select(item => 
                {
                    int uPrice = OrderManager.GetDetailByOrder(order)
                        .Where(d => d.SerialCode.ToString() == item.ItemID).FirstOrDefault().UnitPrice;

                    return new OrderSalesDetail()
                    {
                        SerialCode = Guid.Parse(item.ItemID),
                        UnitPrice = uPrice,
                        Quantity = item.Quantity,
                        Type = 0
                    };
                }).ToList();

                updateIsSuccess = OrderManager.CreateReplenishOrder(order, newDetails, orderError);
            }

            // 更新訂單是否成功
            if (updateIsSuccess)
            {
                this.Response.Redirect("OrderList.aspx");
            }
            else
            {
                throw new Exception("Update Order Failed.");
            }
        }


        class CheckedGoods
        {
            public string ItemID { get; set; }
            public string Name { get; set; }
            public int TotalQuantity { get; set; }
            public int ActualQuantity { get; set; }
        }


        class ErrorGoods
        {
            public string ItemID { get; set; }
            public string Name { get; set; }
            public int ErrorCode { get; set; }
            public int Quantity { get; set; }
            public string Remark { get; set; }
        }


    }
}