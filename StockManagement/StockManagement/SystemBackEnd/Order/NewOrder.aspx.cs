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
    public partial class NewOrder : System.Web.UI.Page
    {
        public string stringObj { get; set; }
        public string NameObj { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            // 為一些asp.net控制項加上HTML Attribute
            this.txtSearch.Attributes.Add("data-bs-toggle", "dropdown");
            this.txtSearch.Attributes.Add("autocomplete", "off");


            this.Seller.Attributes.Add("placeholder", "賣家");

            List<CompactDisc> CDs = new List<CompactDisc>();

            // 如果是PostBack
            if (IsPostBack)
            {
                // 處理搜尋欄
                if (string.IsNullOrWhiteSpace(this.txtSearch.Text))
                {
                    this.txtSearch.Text = "";
                    this.Session["SearchWord"] = "";
                }
                else
                {
                    this.Session["SearchWord"] = this.txtSearch.Text;
                }

                // 處理搜尋結果列表
                string strResult = this.HFSearchResult.Value;
                if(strResult == "" || strResult == "[]")
                {
                    // 搜尋結果列表為乾淨的資料庫前幾筆
                    this.Session["SearchObject"] = null;

                    CDs = NewPageLoad(this.searchListPager);
                }
                else
                {
                    Rootobject[] objResult = Newtonsoft.Json.JsonConvert.DeserializeObject<Rootobject[]>(strResult);

                    // 將前台JavaScript的FuzzySearch結果存至Session
                    this.Session["SearchObject"] = objResult;

                    int itemSizeInPage = this.searchListPager.ItemSizeInPage;

                    // CDs的大小會是ItemSizeInPage
                    int j = 0;
                    foreach (Rootobject i in objResult)
                    {
                        if (j == itemSizeInPage)
                            break;

                        CDs.Add(new CompactDisc()
                        {
                            SerialCode = new Guid(i.item.SerialCode),
                            Name = i.item.Name,
                            Brand = i.item.Brand,
                            Artist = i.item.Artist,
                            Region = i.item.Region,
                            PublicationDate = i.item.PublicationDate
                        });
                        j++;
                    }

                    // 設定ucPager並計算產生Pagination(Bind)
                    this.searchListPager.isSearch = true;
                    this.searchListPager.TotalItemSize = objResult.Length;
                    this.searchListPager.CurrentPage = 1;
                    this.searchListPager.Bind();
                }
                
            }
            // 不是PostBack，可能是剛進頁面或顯示所有資料的情況下換頁，或是搜尋的情況下換頁
            else
            {
                // 如果是搜尋模式
                if (this.Request.QueryString["Action"] == "Search")
                {
                    this.txtSearch.Text = this.Session["SearchWord"] as string;
                    Rootobject[] searchObj = this.Session["SearchObject"] as Rootobject[];

                    int itemSizeInPage = this.searchListPager.ItemSizeInPage;
                    this.searchListPager.TotalItemSize = searchObj.Length;
                    int currentPage = this.searchListPager.GetCurrentPage();

                    // CDs的大小會是ItemSizeInPage
                    int startIndex = itemSizeInPage * (currentPage - 1);
                    int endIndex = startIndex + itemSizeInPage - 1;
                    endIndex = endIndex > searchObj.GetUpperBound(0) ? searchObj.GetUpperBound(0) : endIndex;

                    for (int i = startIndex; i <= endIndex; i++)
                    {
                        CDs.Add(new CompactDisc()
                        {
                            SerialCode = new Guid(searchObj[i].item.SerialCode),
                            Name = searchObj[i].item.Name,
                            Brand = searchObj[i].item.Brand,
                            Artist = searchObj[i].item.Artist,
                            Region = searchObj[i].item.Region,
                            PublicationDate = searchObj[i].item.PublicationDate
                        });
                    }

                    this.searchListPager.isSearch = true;
                    this.searchListPager.Bind();
                }
                // 如果是從新增產品跳回這個頁面
                else if (this.Session["NewProduct"] != null)
                {
                    CompactDisc cd = this.Session["NewProduct"] as CompactDisc;
                    this.Session["NewProduct"] = null;

                    this.txtSearch.Text = cd.Name;
                    CDs.Add(cd);

                    this.searchListPager.TotalItemSize = 1;
                    this.searchListPager.Bind();
                }
                // 不是搜尋模式(顯示所有資料)
                else
                {
                    this.Session["SearchObject"] = null;
                    this.Session["SearchWord"] = null;

                    CDs = NewPageLoad(this.searchListPager);
                }
            }

            // 結果列表
            foreach (var cd in CDs)
            {
                CDStock cdstock = CDStockManager.GetStockBySerialCode(cd.SerialCode);
                int available = 0;
                if (cdstock == null)
                    throw new Exception("No Data in CDStock.");
                else
                {
                    available = cdstock.TotalStock - cdstock.InTransitStock - cdstock.UnreviewedStock;
                }

                this.ltlCDList.Text +=
                    $"<a class=\"list-group-item list-group-item-action\" data-bs-toggle=\"list\" href=\"#ID{cd.SerialCode}\">" +
                    $"<div class=\"row\">" +
                    $"<div class=\"col-6\"> <h6>{cd.Name}</h6> </div>" +
                    $"<div class=\"col-3\"> <small>{cd.Artist}</small> </div>" +
                    $"<div class=\"col-3\"><small>{available}</small></div>" +
                    $"</div> </a>";
            }

            // 結果列表的細目
            string disabled = "";
            foreach (var cd in CDs)
            {
                CDStock cdstock = CDStockManager.GetStockBySerialCode(cd.SerialCode);
                int available = 0;
                if (cdstock == null)
                    throw new Exception("No Data in CDStock.");
                else
                {
                    available = cdstock.TotalStock - cdstock.InTransitStock - cdstock.UnreviewedStock;
                }
                this.ltlCDListTabContent.Text +=
                    $"<div class=\"tab-pane fade\" id=\"ID{cd.SerialCode}\">" +
                    $"<h6>專輯名稱: {cd.Name}</h6>" +
                    $"<small>歌手: {cd.Artist}</small><br />" +
                    $"<small>發行公司: {cd.Brand}</small><br />" +
                    $"<small>發行日期: {cd.PublicationDate.ToString("yyyy-MM-dd")}</small><br />" +
                    $"<small>地區: {cd.Region}</small><br />" +
                    $"<small>可用庫存: {available}</small><br />" +
                    $"<small>在途庫存: {cdstock.InTransitStock}</small><br />" +
                    $"<small>待審核庫存: {cdstock.UnreviewedStock}</small><br />" +
                    $"<button type='button' class='btn btn-outline-success' id='btnID{cd.SerialCode}' onclick='btnAddTemp(this)' {disabled}>新增</button>" +
                    $"</div>";
            }

            // 將所有CD資料利用JSON傳至Client端，做為FuzzySearch用
            var cdList = CDManager.GetCDList();
            stringObj = Newtonsoft.Json.JsonConvert.SerializeObject(cdList.Select(cd => cd));

            // 若session中暫存列表有值，將他放進HiddenField讓前台處理
            var sessionTempList = this.Session["TempList"];
            if(sessionTempList != null)
            {
                this.HFTempList.Value = sessionTempList as string;
            }
        }

        private static List<CompactDisc> NewPageLoad(StockManagement.UserControls.ucPager pager)
        {
            int totalItemSize = CDManager.GetSize();
            pager.TotalItemSize = totalItemSize;

            int itemSizeInPage = pager.ItemSizeInPage;
            int currentPage = pager.GetCurrentPage();

            // 從資料庫抓取相對應的資料，數量會是ItemSizeInPage
            List<CompactDisc> CDs = CDManager.GetCDByIndex(itemSizeInPage * (currentPage - 1), itemSizeInPage);

            // 設定ucPager並計算產生Pagination(Bind)
            pager.Bind();
            return CDs;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string tempListStr = this.Session["TempList"] as string;
            TempListCD[] sessionTempList = Newtonsoft.Json.JsonConvert.DeserializeObject<TempListCD[]>(tempListStr);
            
            List<CompactDisc> cdList = CDManager.GetCDList();
            List<OrderSalesDetail> orderDetailList = new List<OrderSalesDetail>();

            string id = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
            Guid gid = Guid.Parse(id);

            ORM.DBModels.Order newOrder = new ORM.DBModels.Order()
            {
                Seller = this.Seller.Text,
                OrderResponsiblePerson = gid
            };


            foreach (TempListCD temp in sessionTempList)
            {
                if (temp.Name.IndexOf("&amp;") != -1)
                {
                    temp.Name = temp.Name.Replace("&amp;", "&");
                }
                CompactDisc tempCD = cdList.Where(item => item.Name == temp.Name).FirstOrDefault();
                

                OrderSalesDetail d = new OrderSalesDetail()
                {
                    SerialCode = tempCD.SerialCode,
                    Quantity = Convert.ToInt32(temp.Quantity),
                    UnitPrice = 500
                };
                orderDetailList.Add(d);
            }

            bool isSuccess = OrderManager.CreateOrder(newOrder, orderDetailList);
            if (isSuccess)
            {
                this.Session["SearchObject"] = null;
                this.Session["SearchWord"] = null;
                this.Session["TempList"] = null;
                this.Response.Redirect("OrderList.aspx");
            }
            else
            {
                this.ltlFailedModal.Text += "<script>$(function(){" +
                    "var CRFailedModal = new bootstrap.Modal(document.getElementById('CreateOrderFailedModal'), {keyboard: false});" +
                    "CRFailedModal.show();})</script>";
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            this.Session["SearchObject"] = null;
            this.Session["SearchWord"] = null;
            this.Session["TempList"] = null;

            this.Response.Redirect("OrderList.aspx");
        }

        // 從前端傳來的搜尋結果的JSON格式
        class Rootobject
        {
            public Item item { get; set; }
            public int refIndex { get; set; }
            public float score { get; set; }
        }

        class Item
        {
            public string SerialCode { get; set; }
            public string Name { get; set; }
            public string Brand { get; set; }
            public string Artist { get; set; }
            public string Region { get; set; }
            public DateTime PublicationDate { get; set; }
        }

        class TempListCD
        {
            public string Name { get; set; }
            public string Quantity { get; set; }
        }

    }

    
}