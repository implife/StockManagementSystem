using StockManagement.DBSource;
using StockManagement.ORM.DBModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StockManagement.SystemBackEnd.Search
{
    public partial class RecordSearch : System.Web.UI.Page
    {
        public string OrderJSON { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            List<ORM.DBModels.Order> originalOrder = OrderManager.GetOrderList();

            this.OrderJSON = Newtonsoft.Json.JsonConvert.SerializeObject(originalOrder);





            // 只選取已完成(status=5)
            originalOrder = originalOrder.Where(item => item.Status == 5)
                .OrderBy(o => o.OrderDate).ToList();

            // 排序
            List<ORM.DBModels.Order> result = new List<ORM.DBModels.Order>();
            RecursiveSortOrder(originalOrder, result);

            
            //int sizeInPage = this.ucPager.ItemSizeInPage;
            //if (result.Count() > sizeInPage)
            //    result = result.Take(sizeInPage).ToList();

            this.ltlResultList.Text = "";
            this.ltlSearchTabPane.Text = "";
            bool allowTextStyle = false;
            foreach (ORM.DBModels.Order orderItem in result)
            {
                // ---------------左邊的Search列表-------------
                string arrowAndFirst = "";
                if (orderItem.ReplenishID != null)
                {
                    allowTextStyle = true;
                    arrowAndFirst = RenderArrowAndFirstCol(orderItem, allowTextStyle);
                }
                else
                {
                    arrowAndFirst = RenderArrowAndFirstCol(orderItem, allowTextStyle);
                    allowTextStyle = false;
                }

                this.ltlResultList.Text +=
                    $"<a class='list-group-item list-group-item-action myActive' data-bs-toggle='list' href='#ID{orderItem.OrderID}'>" +
                    $"<div class='row'>" +
                    arrowAndFirst +
                    $"<div class='col-2'> <small>{orderItem.OrderDate.ToString("yyyy-MM-dd")}</small> </div>" +
                    $"<div class='col-2'><small>{orderItem.ArrivalDate?.ToString("yyyy-MM-dd")}</small></div>" +
                    $"<div class='col-2'><small>{GetTotalPrice(orderItem)}</small></div>" +
                    $"<div class='col-3'><small>{UserInfoManager.GetUserInfoByUserID(orderItem.OrderResponsiblePerson).Name}</small></div>" +
                    $"</div></a>";

                // ---------------右邊的細目Tab Pane-------------
                this.ltlSearchTabPane.Text +=
                    $"<div class='tab-pane fade' id='ID{orderItem.OrderID}'>" +
                        $"<div class='d-flex w-100 justify-content-between'>" +
                        $"<h5 class='mb-1'>{orderItem.OrderID.ToString().Split('-')[0]}</h5>" +
                    $"</div>" +
                    $"<p class='mb-1'>訂貨日期：{orderItem.OrderDate.ToString("yyyy-MM-dd")}</p>" +
                    $"<p class='mb-1'>預計到貨日：{orderItem.PredictedArrivalDate?.ToString("yyyy-MM-dd")}</p>" +
                    $"<p class='mb-1'>到貨日期：{orderItem.ArrivalDate?.ToString("yyyy - MM - dd")}</p>" +
                    $"<p class='mb-1'>總金額：{GetTotalPrice(orderItem)}</p>" +
                    $"<p class='mb-1'>負責主管：{UserInfoManager.GetUserInfoByUserID(orderItem.OrderResponsiblePerson).Name}</p>" +
                    $"<div class='accordion accordion-flush' id='accordion{orderItem.OrderID}'>" +
                    $"<div class='accordion-item'>" +
                    $"<h2 class='accordion-header'>" +
                        $"<button class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-target='#accItemBody{orderItem.OrderID}'>品項</button>" +
                    $"</h2>" +
                    $"<div id='accItemBody{orderItem.OrderID}' class='accordion-collapse collapse' data-bs-parent='#accordion{orderItem.OrderID}'>" +
                    $"<div class='accordion-body'>" +
                    $"<div class='list-group'>" +
                    $"<a class='list-group-item' href='#'>" +
                    $"<div class='row'>" +
                    $"<div class='col-6'><small>專輯名稱</small></div>" +
                    $"<div class='col-3'><small>單價</small></div>" +
                    $"<div class='col-3'><small>數量</small></div>" +
                    $"</div></a>";

                // ---------------Tab Pane > ItemAccordion下的Item-------------
                List<OrderSalesDetail> details = OrderManager.GetDetailByOrder(orderItem);
                foreach (OrderSalesDetail detailItem in details)
                {
                    this.ltlSearchTabPane.Text +=
                        $"<a href='#' class='list-group-item list-group-item-action'>" +
                            $"<div class='row'>" +
                            $"<div class='col-6'>{CDManager.GetCDBySerialCode(detailItem.SerialCode).Name}</div>" +
                            $"<div class='col-3'>{detailItem.UnitPrice}</div>" +
                            $"<div class='col-3'>{detailItem.Quantity}</div>" +
                        $"</div></a>";
                }

                this.ltlSearchTabPane.Text += $"</div></div></div></div>";

                // ---------------Tab Pane > 到貨狀況Accordion-------------
                string RID = orderItem.ReplenishID == null ? "--" : orderItem.ReplenishID.ToString();
                this.ltlSearchTabPane.Text +=
                    $"<div class='accordion-item'>" +
                    $"<h2 class='accordion-header'>" +
                    $"<button class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-target='#accArrivalBody{orderItem.OrderID}'>" +
                    $"到貨狀況</button></h2>" +
                    $"<div id='accArrivalBody{orderItem.OrderID}' class='accordion-collapse collapse' data-bs-parent='#accordion{orderItem.OrderID}'>" +
                    $"<div class='accordion-body'>" +
                    $"<p class='mb-1'>到貨日期：{orderItem.ArrivalDate?.ToString("yyyy - MM - dd")}</p>" +
                    $"<p class='mb-1'>點貨人員：{UserInfoManager.GetUserInfoByUserID(orderItem.ArrivalResponsiblePerson).Name}</p>" +
                    $"<p class='mb-1'>關連訂單：{RID}</p>" +
                    this.RenderDeliverListUL(OrderManager.GetDetailByOrder(orderItem)) +
                    $"</div></div></div></div></div>";
            }

            this.ucPager.TotalItemSize = result.Count;
            this.ucPager.Bind();
        }

        // 到貨狀況的商品列表
        private string RenderDeliverListUL(List<OrderSalesDetail> details)
        {
            string str = "";
            List<OrderSalesDetail> frontThree = details.Take(3).ToList();
            str += "<ul class='list-group list-group-horizontal'>";

            List<OrderError> errorList = OrderManager.GetOrderErrorListByOrderID(details[0].OrderID);
            foreach (OrderSalesDetail detailItem in frontThree)
            {
                var err = errorList?.Where(e => e.SerialCode == detailItem.SerialCode).FirstOrDefault();
                if(err == null)
                {
                    str += $"<li class='list-group-item list-group-item-success deliverCheckListItem'>" +
                        $"<span class='myCheck'></span>{CDManager.GetCDBySerialCode(detailItem.SerialCode).Name}</li>";
                }
                else
                {
                    // 多送不處理
                    if (err.ErrorCode == 0)
                    {
                        str += $"<li class='list-group-item list-group-item-success deliverCheckListItem'>" +
                        $"<span class='myCheck'></span>{CDManager.GetCDBySerialCode(detailItem.SerialCode).Name}</li>";
                    }
                    // 少送和損壞
                    else
                    {
                        string errType = err.ErrorCode == 1 ? "少送" : "損毀";
                        string errNum = $"-{err.Quantity}";

                        // 是否有備註
                        string errRemark = "</li>";
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
                            CDManager.GetCDBySerialCode(detailItem.SerialCode).Name +
                            errRemark;
                    }
                }
            }
            str += "</ul>";

            // 一列最多三項商品，用遞迴方式
            var result = details.Skip(3).ToList();
            if (result.Count() > 0)
                str += RenderDeliverListUL(result);
            else
                return str;
            return str;
        }

        // SearchList中的箭頭和第一個欄位(單號)
        private string RenderArrowAndFirstCol(ORM.DBModels.Order order, bool allowTextStyle = false)
        {
            string textStyle = allowTextStyle ? " style='color:#dd7b5c'" : "";
            if (order.ReplenishID == null)
            {
                return $"<div class='col-3'{textStyle}>{order.OrderID.ToString().Split('-')[0]}</div>";
            }
            else
            {
                string arrow =
                    $"<div class='center-con'>" +
                    $"<div class='round'>" +
                    $"<div id='cta'>" +
                    $"<span class='arrow primera next'></span>" +
                    $"<span class='arrow segunda next'></span>" +
                    $"</div></div></div>";

                return arrow + $"<div class='col-3'{textStyle}>{order.OrderID.ToString().Split('-')[0]}</div>";
            }
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

        // 利用遞迴對Order List做排序，包括處理補貨單
        private void RecursiveSortOrder(List<ORM.DBModels.Order> original, List<ORM.DBModels.Order> result)
        {
            if(original.Count() != 0)
            {
                RecursiveSortReplenish(original, result, original[0]);
                RecursiveSortOrder(original, result);
            }
        }

        private void RecursiveSortReplenish(List<ORM.DBModels.Order> original, List<ORM.DBModels.Order> result, ORM.DBModels.Order item)
        {
            result.Add(item);
            original.Remove(item);
            if(item.ReplenishID != null)
            {
                ORM.DBModels.Order next = original.Where(o => o.OrderID == item.ReplenishID).FirstOrDefault();
                if (next == null)
                    throw new Exception("Can't find ReplenishID.");
                RecursiveSortReplenish(original, result, next);
            }
        }
    }
}