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
            this.txtOrderIdSearch.Attributes.Add("placeholder", "輸入單號查詢");
            this.txtOrderIdSearch.Attributes.Add("autocomplete", "off");
            this.All.InputAttributes.Add("MyLabel", "顯示全部");
            this.Week.InputAttributes.Add("MyLabel", "一周內");
            this.Month.InputAttributes.Add("MyLabel", "一個月內");


            List<ORM.DBModels.Order> originalOrder = OrderManager.GetOrderList();

            // 只選取已完成(status=5)並按日期排序
            originalOrder = originalOrder.Where(item => item.Status == 5)
                    .OrderBy(o => o.OrderDate).ToList();

            List<ORM.DBModels.Order> result = new List<ORM.DBModels.Order>();
            int sizeInPage = this.ucPager.ItemSizeInPage;

            // 將訂單資料傳至前端以利查詢
            var toClient = originalOrder.Select(item => new { OrderID = item.OrderID });
            this.OrderJSON = Newtonsoft.Json.JsonConvert.SerializeObject(toClient);

            // PostBack必為搜尋
            if (IsPostBack)
            {
                string searchResultJSON = this.HFSearchResult.Value;
                SearchRoot[] searchResultAry = Newtonsoft.Json.JsonConvert.DeserializeObject<SearchRoot[]>(searchResultJSON);

                if(searchResultAry == null)
                {
                    string radioBehavior = this.HFRangeRdioBtn.Value;
                    if (radioBehavior == "All")
                    {
                        this.Response.Redirect(this.Request.Path);
                    }
                    else if (radioBehavior == "Month")
                    {
                        this.Response.Redirect(this.Request.Path + "?Action=Month");
                    }
                    else if (radioBehavior == "Week")
                    {
                        this.Response.Redirect(this.Request.Path + "?Action=Week");
                    }
                    else
                    {
                        return;
                        //this.Response.Redirect(this.Request.Path);
                    }
                }

                // 沒有搜尋結果
                if(searchResultAry.Length == 0)
                {
                    this.ltlResultList.Text = "<h5 class='NoData'>查無搜尋結果!</h5>";
                    return;
                }

                result = searchResultAry.Select(re =>
                {
                    return OrderManager.GetOrderByOrderID(Guid.Parse(re.item.OrderID));
                }).ToList();

                // 將不在List裡的關聯單加入
                result = this.SearchReplenishNotInList(result);

                // 排序
                result = result.OrderBy(o => o.OrderDate).ToList();

                List<ORM.DBModels.Order> temp = new List<ORM.DBModels.Order>();
                this.RecursiveSortOrder(result, temp);
                result = temp;

                // 搜尋結果(加入聯單並排序後)放進Session
                this.Session["OrderSearchObject"] = result;
                this.Session["OrderSearchText"] = this.txtOrderIdSearch.Text;

                // 重新導頁，避免Page參數問題
                this.Response.Redirect(this.Request.Path + "?Action=Search");
            }
            else
            {
                // 搜尋模式
                if (this.Request.QueryString["Action"] == "Search")
                {
                    result = this.Session["OrderSearchObject"] as List<ORM.DBModels.Order>;
                    this.txtOrderIdSearch.Text = this.Session["OrderSearchText"] as string;

                    this.ucPager.TotalItemSize = result.Count;
                    this.ucPager.isSearch = true;

                }
                else if(this.Request.QueryString["Action"] == "Month")
                {
                    List<ORM.DBModels.Order> temp = originalOrder.Where(item => item.OrderDate >= DateTime.Now.AddMonths(-1)).ToList();
                    temp = this.SearchReplenishNotInList(temp).OrderBy(o => o.OrderDate).ToList();

                    this.RecursiveSortOrder(temp, result);

                    this.Month.Checked = true;
                    this.ucPager.TotalItemSize = result.Count;
                }
                else if(this.Request.QueryString["Action"] == "Week")
                {
                    List<ORM.DBModels.Order> temp = originalOrder.Where(item => item.OrderDate >= DateTime.Now.AddDays(-7)).ToList();
                    temp = this.SearchReplenishNotInList(temp).OrderBy(o => o.OrderDate).ToList();

                    this.RecursiveSortOrder(temp, result);

                    this.Week.Checked = true;
                    this.ucPager.TotalItemSize = result.Count;
                }
                // 剛進頁面或顯示全部情況下跳頁
                else
                {
                    // 排序
                    this.RecursiveSortOrder(originalOrder, result);
                    this.ucPager.TotalItemSize = result.Count;

                    this.Session["OrderSearchObject"] = null;
                    this.Session["OrderSearchText"] = null;

                    this.All.Checked = true;
                }
            }

            // 切割出特定頁的資料，並去頭加尾
            int currentPage = this.ucPager.GetCurrentPage();
            result = this.FindItemsInPage((currentPage - 1) * 10, sizeInPage, result);

            // Render HTML
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
                    $"<p class='mb-1'>到貨日期：{orderItem.ArrivalDate?.ToString("yyyy-MM-dd")}</p>" +
                    $"<p class='mb-1'>總金額：{GetTotalPrice(orderItem)}</p>" +
                    $"<p class='mb-1'>負責主管：{UserInfoManager.GetUserInfoByUserID(orderItem.OrderResponsiblePerson).Name}</p>" +
                    $"<p class='mb-1'>歸檔主管：{UserInfoManager.GetUserInfoByUserID(orderItem.ArchiveResponsiblePerson).Name}</p>" +
                    this.RenderMainOrder(orderItem) +
                    $"<div class='accordion accordion-flush' id='accordion{orderItem.OrderID}'>" +
                    $"<div class='accordion-item'>" +
                    $"<h2 class='accordion-header'>" +
                        $"<button class='accordion-button collapsed Accordion_button' type='button' data-bs-toggle='collapse' data-bs-target='#accItemBody{orderItem.OrderID}'>品項</button>" +
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
                    $"<button class='accordion-button collapsed Accordion_button' type='button' data-bs-toggle='collapse' data-bs-target='#accArrivalBody{orderItem.OrderID}'>" +
                    $"到貨狀況</button></h2>" +
                    $"<div id='accArrivalBody{orderItem.OrderID}' class='accordion-collapse collapse' data-bs-parent='#accordion{orderItem.OrderID}'>" +
                    $"<div class='accordion-body'>" +
                    $"<p class='mb-1'>到貨日期：{orderItem.ArrivalDate?.ToString("yyyy - MM - dd")}</p>" +
                    $"<p class='mb-1'>點貨人員：{UserInfoManager.GetUserInfoByUserID(orderItem.ArrivalResponsiblePerson).Name}</p>" +
                    $"<p class='mb-1'>關連訂單：{RID.Split('-')[0]}</p>" +
                    this.RenderDeliverListUL(OrderManager.GetDetailByOrder(orderItem)) +
                    $"</div></div></div></div></div>";
            }


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
                if (err == null)
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

        // TabPane資訊列的主單資訊
        private string RenderMainOrder(ORM.DBModels.Order order)
        {
            string result = "";
            if (order.MainOrder != null && order.MainOrder != order.OrderID)
                result = $"<p class='mb-1'>主單：{order.MainOrder.ToString().Split('-')[0]}</p>";

            return result;
        }

        // 利用遞迴對Order List做排序，包括處理補貨單
        private void RecursiveSortOrder(List<ORM.DBModels.Order> original, List<ORM.DBModels.Order> result)
        {
            if (original.Count() != 0)
            {
                RecursiveSortReplenish(original, result, original[0]);
                RecursiveSortOrder(original, result);
            }
        }

        private void RecursiveSortReplenish(List<ORM.DBModels.Order> original, List<ORM.DBModels.Order> result, ORM.DBModels.Order item)
        {
            result.Add(item);
            original.Remove(item);
            if (item.ReplenishID != null)
            {
                ORM.DBModels.Order next = original.Where(o => o.OrderID == item.ReplenishID).FirstOrDefault();
                if (next == null)
                    throw new Exception("Can't find ReplenishID.");
                RecursiveSortReplenish(original, result, next);
            }
        }

        // 尋找不在List裡的關連訂單
        private List<ORM.DBModels.Order> SearchReplenishNotInList(List<ORM.DBModels.Order> original)
        {
            List<ORM.DBModels.Order> result = new List<ORM.DBModels.Order>();
            List<Guid> temp = new List<Guid>();

            foreach (ORM.DBModels.Order item in original)
            {
                if (item.MainOrder == null)
                    result.Add(item);
                else
                {
                    if (!temp.Contains((Guid)item.MainOrder))
                        temp.Add((Guid)item.MainOrder);
                }
            }

            List<ORM.DBModels.Order> AllList = OrderManager.GetOrderList();
            foreach (Guid item in temp)
            {
                result.AddRange(AllList.Where(i => i.MainOrder == item).ToList());
            }

            return result;


            //foreach (ORM.DBModels.Order orderItem in original)
            //{
            //    if(orderItem.ReplenishID != null)
            //    {
            //        if(!original.Any(item => item.OrderID == orderItem.ReplenishID))
            //        {
            //            if (!result.Any(item => item.OrderID == orderItem.ReplenishID))
            //            {
            //                List<ORM.DBModels.Order> add = SearchRecursive(orderItem);
            //                result.AddRange(add);
            //            }
            //        }
            //    }
            //}
            //return result;
        }

        // 尋找不在List裡的關連訂單Recursive
        private List<ORM.DBModels.Order> SearchRecursive(ORM.DBModels.Order test)
        {
            List<ORM.DBModels.Order> result = new List<ORM.DBModels.Order>();

            if (test.ReplenishID != null)
            {
                result.AddRange(SearchRecursive(OrderManager.GetOrderByOrderID((Guid)test.ReplenishID)));
            }
            else
            {
                result.Add(test);
            }
            return result;
        }

        // 切割出特定頁的資料，並去頭加尾
        private List<ORM.DBModels.Order> FindItemsInPage(int startIndex, int sizeInPage, List<ORM.DBModels.Order> original)
        {
            List<ORM.DBModels.Order> result = new List<ORM.DBModels.Order>();
            if (original.Count() == 0)
                return result;
            if (startIndex >= original.Count())
                startIndex = 1;

            result = original.Skip(startIndex).Take(sizeInPage).ToList();
            this.DeleteHeadAssociation(result);
            this.AddTailAssociation(result);

            return result;
        }

        // 不完整的頭都去掉
        private void DeleteHeadAssociation(List<ORM.DBModels.Order> list)
        {
            if (list[0].MainOrder != null && list[0].MainOrder != list[0].OrderID)
            {
                list.RemoveAt(0);
                DeleteHeadAssociation(list);
            }
        }

        // 不完整的尾加上來
        private void AddTailAssociation(List<ORM.DBModels.Order> list)
        {
            if (list[list.Count - 1].ReplenishID != null)
            {
                list.Add(OrderManager.GetOrderByOrderID((Guid)list[list.Count - 1].ReplenishID));
                AddTailAssociation(list);
            }
        }

        class SearchRoot
        {
            public Item item { get; set; }
            public int refIndex { get; set; }
            public float score { get; set; }
        }

        class Item
        {
            public string OrderID { get; set; }
        }

    }
}