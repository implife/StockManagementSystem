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
    public partial class OrderList : System.Web.UI.Page
    {
        enum OrderStatus
        {
            NotDelivered = 0,
            Delivering = 1,
            Replenish = 2,
            DeliverComplete = 3,
            WaitForReview = 4,
            Complete = 5
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // 驗證是否是主管，主管才能新增訂單
            string id = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
            Guid gid = Guid.Parse(id);
            if (!UserInfoManager.isManager(gid))
                this.btnNewOrder.Enabled = false;

            // 剔除已歸檔，按日期排序，再利用RefreshAndSort排序
            List<ORM.DBModels.Order> orderList = OrderManager.GetOrderList();
            orderList = orderList.Where(item => item.Status != (int)OrderStatus.Complete)
                .OrderBy(d => d.OrderDate).ToList();

            List<ORM.DBModels.Order> sortedOrderList = new List<ORM.DBModels.Order>();
            this.RefreshAndSort(sortedOrderList, orderList);


            this.ltlOrderListItem.Text = "";
            this.ltlOrderListTabPane.Text = "";
            int statusCode = -1;
            foreach (ORM.DBModels.Order orderItem in sortedOrderList)
            {

                /*------------------------------訂單List---------------------------*/
                bool IsAllow = false;
                if (orderItem.Status == (int)OrderStatus.Replenish)
                    statusCode = 1;
                else if (statusCode == 1)
                {
                    IsAllow = true;
                    statusCode = -1;
                }
                else
                    statusCode = -1;

                this.ltlOrderListItem.Text += RenderOrderListItem(orderItem, IsAllow) + "\n";

                /*------------------------------訂單細目的TabPane---------------------------*/
                string predictedDate = orderItem.PredictedArrivalDate == null
                    ? "--"
                    : orderItem.PredictedArrivalDate?.ToString("yyyy-MM-dd");
                string arrivalDate = orderItem.ArrivalDate == null
                    ? "--"
                    : orderItem.ArrivalDate?.ToString("yyyy-MM-dd");
                string checkGoodsBtn = orderItem.Status == (int)OrderStatus.Delivering
                    ? $"<a class='btn btn-outline-info mb-1 ms-1' href='CheckGoods.aspx?OID={orderItem.OrderID}' role='button'>點貨</a>"
                    : "";

                this.ltlOrderListTabPane.Text +=
                    $"<div class='tab-pane fade' id='ID{orderItem.OrderID}'>" +
                    $"<div class='d-flex w-100 justify-content-between'>" +
                    $"<h5 class='mb-1'>{orderItem.OrderID.ToString().Split('-')[0]}</h5>" +
                    this.RenderTabPaneH5(orderItem) +
                    $"</div>" +
                    $"<p class='mb-1'>訂貨日期：{orderItem.OrderDate.ToString("yyyy-MM-dd")}</p>" +
                    $"<p class='mb-1'>預計到貨日：{predictedDate}</p>" +
                    $"<p class='mb-1'>到貨日：{arrivalDate}</p>" +
                    $"<p class='mb-1'>總金額：{this.GetTotalPrice(orderItem)}</p>" +
                    $"<p class='mb-1'>負責主管：{UserInfoManager.GetUserInfoByUserID(orderItem.OrderResponsiblePerson).Name}</p>" +
                    checkGoodsBtn +
                    $"<div class='accordion accordion-flush' id='accordion{orderItem.OrderID}'>" +
                    $"<div class='accordion-item'>" +
                    $"<h2 class='accordion-header'>" +
                    $"<button class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-target='#accItemBody{orderItem.OrderID}'>品項</button>" +
                    $"</h2>" +
                    $"<div id='accItemBody{orderItem.OrderID}' class='accordion-collapse collapse' data-bs-parent='#accordion{orderItem.OrderID}'>" +
                    $"<div class='accordion-body'>" +
                    $"<div class='list-group'>" +
                    $"<a class='list-group-item disabled' href='#'>" +
                    $"<div class='row'>" +
                    $"<div class='col-6'><small>專輯名稱</small></div>" +
                    $"<div class='col-3'><small>單價</small></div>" +
                    $"<div class='col-3'><small>數量</small></div>" +
                    $"</div></a>";

                /*------------------------------TabPane > 商品細目-------------------------------*/
                List<OrderSalesDetail> details = OrderManager.GetDetailByOrder(orderItem);
                foreach (OrderSalesDetail detailItem in details)
                {
                    this.ltlOrderListTabPane.Text += this.RenderProductListItem(detailItem);
                }
                this.ltlOrderListTabPane.Text += "</div></div></div></div>";

                /*------------------------------TabPane > 到貨狀態的Accordion-----------------------*/
                this.ltlOrderListTabPane.Text +=
                    $"<div class='accordion-item'>" +
                    $"<h2 class='accordion-header'>" +
                    this.RenderDeliverStatusBtn(orderItem) +
                    $"</h2>";

                if (orderItem.Status == (int)OrderStatus.NotDelivered ||
                    orderItem.Status == (int)OrderStatus.Delivering ||
                    orderItem.Status == (int)OrderStatus.WaitForReview)
                {
                    this.ltlOrderListTabPane.Text +=
                        $"<div id='accArrivalBody{orderItem.OrderID}' class='accordion-collapse collapse' data-bs-parent='#accordion{orderItem.OrderID}'>" +
                        $"<div class='accordion-body'>" +
                        $"<p class='mb-1'>到貨日期：--</p>" +
                        $"<p class='mb-1'>點貨人員：--</p>" +
                        $"<p class='mb-1'>關連訂單：--</p>";
                }
                else
                {
                    string associatedOrder = (orderItem.ReplenishID == null) ? "" : $"<p class='mb-1'>關連訂單：{orderItem.ReplenishID.ToString().Split('-')[0]}</p>";

                    string responsibleCheck = orderItem.ArrivalResponsiblePerson == null ? "--" : UserInfoManager.GetUserInfoByUserID(orderItem.ArrivalResponsiblePerson).Name;
                    this.ltlOrderListTabPane.Text += 
                        $"<div id='accArrivalBody{orderItem.OrderID}' class='accordion-collapse collapse' data-bs-parent='#accordion{orderItem.OrderID}'>" +
                        $"<div class='accordion-body'>" +
                        $"<p class='mb-1'>到貨日期：{orderItem.ArrivalDate?.ToString("yyyy-MM-dd HH:mm")}</p>" +
                        $"<p class='mb-1'>點貨人員：{responsibleCheck}</p>" +
                        associatedOrder;

                    string ulStr = "";
                    if (orderItem.Status == (int)OrderStatus.DeliverComplete)
                        ulStr = this.RenderDeliverListUL(OrderManager.GetDetailByOrder(orderItem));
                    else
                        ulStr = this.RenderDeliverListUL(OrderManager.GetDetailByOrder(orderItem), orderItem.OrderID);

                    this.ltlOrderListTabPane.Text += ulStr;
                }
                this.ltlOrderListTabPane.Text += "</div></div>";

                this.ltlOrderListTabPane.Text += "</div>"; // accordion-Item

                this.ltlOrderListTabPane.Text += "</div></div>\n"; // tab-pane
            }
        }

        // 左邊的列表Item
        private string RenderOrderListItem(ORM.DBModels.Order order, bool allowTextStyle = false)
        {
            string responsibleName = UserInfoManager.GetUserInfoByUserID(order.OrderResponsiblePerson).Name;
            string arrow = "";
            if (order.ReplenishID != null)
            {
                arrow =
                    $"<div class='center-con'>" +
                        $"<div class='round'>" +
                        $"<div id='cta'>" +
                            $"<span class='arrow primera next'></span>" +
                            $"<span class='arrow segunda next'></span>" +
                    $"</div></div></div>";
            }
            string textStyle = (order.ReplenishID != null || allowTextStyle) ? " style='color:#dd7b5c'" : "";

            string result =
                $"<a class='list-group-item list-group-item-action myActive' data-bs-toggle='list' href='#ID{order.OrderID}'>" +
                    $"<div class='row'>" +
                        arrow +
                        $"<div class='col-3'{textStyle}>{order.OrderID.ToString().Split('-')[0]}</div>" +
                        $"<div class='col-3'><small>{order.OrderDate.ToString("yyyy-MM-dd")}</small> </div>" +
                        $"<div class='col-2'><small>{GetTotalPrice(order)}</small></div>" +
                        $"<div class='col-2'><small>{GetStatusChinese(order.Status)}</small></div>" +
                        $"<div class='col-2'><small>{responsibleName}</small></div>" +
                $"</div></a>";

            return result;
        }

        // TabPane的標題<h5>
        private string RenderTabPaneH5(ORM.DBModels.Order order)
        {
            switch (order.Status)
            {
                case (int)OrderStatus.NotDelivered:
                    return $"<span class='badge bg-secondary tabpane-tilte-badge'>{GetStatusChinese(order.Status)}</span>";
                case (int)OrderStatus.Delivering:
                    return $"<span class='badge bg-primary tabpane-tilte-badge'>{GetStatusChinese(order.Status)}</span>";
                case (int)OrderStatus.Replenish:
                    return $"<span class='badge bg-warning tabpane-tilte-badge'>{GetStatusChinese(order.Status)}</span>";
                case (int)OrderStatus.DeliverComplete:
                    return $"<span class='badge bg-success tabpane-tilte-badge'>{GetStatusChinese(order.Status)}</span>";
                case (int)OrderStatus.WaitForReview:
                    return $"<span class='badge bg-danger tabpane-tilte-badge'>{GetStatusChinese(order.Status)}</span>";
                case (int)OrderStatus.Complete:
                    return $"<span class='badge bg-success tabpane-tilte-badge'>{GetStatusChinese(order.Status)}</span>";
                default:
                    return "";
            }
        }

        // TabPane的商品列表
        private string RenderProductListItem(OrderSalesDetail detail)
        {
            CompactDisc cd = CDManager.GetCDBySerialCode(detail.SerialCode);
            string listItem =
                $"<a href='#' class='list-group-item list-group-item-action cdListItem'>" +
                $"<div class='row'>" +
                $"<div class='col-6'>{cd.Name}</div>" +
                $"<div class='col-3'>{detail.UnitPrice}</div>" +
                $"<div class='col-3'>{detail.Quantity}</div>" +
                $"</div>" +
                $"<div class='CdDetailPopup'>" +
                $"<h6>{cd.Name}</h6>" +
                $"<p><b>發行公司:</b>{cd.Brand}</p>" +
                $"<p><b>音樂家:</b>{cd.Artist}</p>" +
                $"<p><b>地區:</b>{cd.Region}</p>" +
                $"<p><b>發行日:</b>{cd.PublicationDate.ToString("yyyy-MM-dd")}</p>" +
                $"</div></a>";

            return listItem;
        }

        // TabPane的到貨狀況的按鈕
        private string RenderDeliverStatusBtn(ORM.DBModels.Order order)
        {
            string isToggle = "";
            string textStyle = "";
            switch (order.Status)
            {
                case (int)OrderStatus.NotDelivered:
                    {
                        isToggle = " disabled";
                        textStyle = "secondary";
                        break;
                    }
                case (int)OrderStatus.Delivering:
                    {
                        isToggle = " disabled";
                        textStyle = "primary";
                        break;
                    }
                case (int)OrderStatus.Replenish:
                    {
                        isToggle = " data-bs-toggle='collapse'";
                        textStyle = "warning";
                        break;
                    }
                case (int)OrderStatus.DeliverComplete:
                    {
                        isToggle = " data-bs-toggle='collapse'";
                        textStyle = "success";
                        break;
                    }
                case (int)OrderStatus.WaitForReview:
                    {
                        isToggle = " disabled";
                        textStyle = "danger";
                        break;
                    }
                case (int)OrderStatus.Complete:
                    {
                        isToggle = " data-bs-toggle='collapse'";
                        textStyle = "success";
                        break;
                    }
                default:
                    return "";
            }

            string result = $"<button class='accordion-button collapsed' type='button'{isToggle} data-bs-target='#accArrivalBody{order.OrderID}'>" +
                $"到貨狀況<span class='badge bg-{textStyle} arrival-status-span'>{this.GetStatusChinese(order.Status)}</span>" +
                $"</button>";

            return result;
        }

        // 到貨狀況的商品列表
        private string RenderDeliverListUL(List<OrderSalesDetail> detailList, Guid? orderID = null)
        {
            string str = "";
            // null表示是配送完成
            if (orderID == null)
            {
                List<OrderSalesDetail> frontThree = detailList.Take(3).ToList();
                str += "<ul class='list-group list-group-horizontal'>";
                foreach (OrderSalesDetail item in frontThree)
                {
                    str += $"<li class='list-group-item list-group-item-success deliverCheckListItem'>" +
                        $"<span class='myCheck'></span>{CDManager.GetCDBySerialCode(item.SerialCode).Name}</li>";
                }
                str += "</ul>";

                // 一列最多三項商品，用遞迴方式
                var result = detailList.Skip(3).ToList();
                if (result.Count() > 0)
                    str += RenderDeliverListUL(result);
                else
                    return str;
            }
            // 不是null表示是補貨中
            else
            {
                List<OrderSalesDetail> frontThree = detailList.Take(3).ToList();
                str += "<ul class='list-group list-group-horizontal'>";

                List<OrderError> errorList = OrderManager.GetOrderErrorListByOrderID(orderID);
                foreach (OrderSalesDetail item in frontThree)
                {
                    // 判斷每一項商品是否有Error
                    var err = errorList?.Where(e => e.SerialCode == item.SerialCode).FirstOrDefault();
                    if(err == null)
                    {
                        str += $"<li class='list-group-item list-group-item-success deliverCheckListItem'>" +
                            $"<span class='myCheck'></span>{CDManager.GetCDBySerialCode(item.SerialCode).Name}</li>";
                    }
                    else
                    {
                        // 多送不處理
                        if (err.ErrorCode == 0)
                        {
                            str += $"<li class='list-group-item list-group-item-success deliverCheckListItem'>" +
                            $"<span class='myCheck'></span>{CDManager.GetCDBySerialCode(item.SerialCode).Name}</li>";
                        }
                        // 少送和損壞
                        else
                        {
                            string errType = err.ErrorCode == 1 ? "少送" : "損毀";
                            string errNum = $"-{err.Quantity}";

                            // 是否有備註
                            string errRemark = "";
                            if (err.Remark != null)
                            {
                                errRemark =
                                    $"<div class='RemarkPopup'>" +
                                    $"<h6>備註</h6>" +
                                    $"<p>{err.Remark}</p>" +
                                    $"</div></li>";
                            }

                            str += $"<li class='list-group-item list-group-item-danger deliverCheckListItem'>" +
                                $"<span class='badge bg-danger arrival-cross-badge'>{errNum}{errType}</span>" +
                                CDManager.GetCDBySerialCode(item.SerialCode).Name +
                                errRemark;
                        }
                    }
                    
                }
                str += "</ul>";

                // 一列最多三項商品，用遞迴方式
                var result = detailList.Skip(3).ToList();
                if (result.Count() > 0)
                    str += RenderDeliverListUL(result, orderID);
                else
                    return str;
            }
            return str;
        }

        // 取得訂單的總價
        private int GetTotalPrice(ORM.DBModels.Order order)
        {
            List<OrderSalesDetail> detail = OrderManager.GetDetailByOrder(order);
            int sum = 0;
            foreach (OrderSalesDetail item in detail)
            {
                int price = item.UnitPrice * item.Quantity;
                sum += price;
            }
            return sum;
        }

        // 取得狀態的中文
        private string GetStatusChinese(int status)
        {
            switch (status)
            {
                case (int)OrderStatus.NotDelivered:
                    return "未配送";
                case (int)OrderStatus.Delivering:
                    return "配送中";
                case (int)OrderStatus.Replenish:
                    return "補貨";
                case (int)OrderStatus.DeliverComplete:
                    return "配送完成";
                case (int)OrderStatus.WaitForReview:
                    return "待審核";
                case (int)OrderStatus.Complete:
                    return "已完成";
                default:
                    return "";
            }
        }

        // 將案日期排序完的Order List再案補貨關聯排序，利用以下兩個方法遞迴
        private void RefreshAndSort(List<ORM.DBModels.Order> result, List<ORM.DBModels.Order> original)
        {
            if (original.Count() == 0)
                return;
            else
            {
                ORM.DBModels.Order item = original[0];
                RecursiveOrderSort(result, original, item);
                RefreshAndSort(result, original);
            }
        }

        private void RecursiveOrderSort(List<ORM.DBModels.Order> result, List<ORM.DBModels.Order> original, ORM.DBModels.Order item)
        {
            result.Add(item);
            original.Remove(item);
            if (item.ReplenishID == null)
            {
                return;
            }
            else
            {
                ORM.DBModels.Order next = original.Where(i => i.OrderID == item.ReplenishID).FirstOrDefault();
                RecursiveOrderSort(result, original, next);
            }
            return;
        }

        protected void btnNewOrder_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("/SystemBackEnd/Order/NewOrder.aspx");
        }
    }
}