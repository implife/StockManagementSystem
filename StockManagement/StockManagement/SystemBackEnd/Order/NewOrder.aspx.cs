using StockManagement.DBSource;
using StockManagement.ORM.DBModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
            this.btnSearch.Attributes.Add("onclick", "btnSearchClick()");

            List<CompactDisc> CDs = new List<CompactDisc>();

            // 如果是PostBack必然是Search的情況
            if (IsPostBack)
            {
                // 如果搜尋欄為空白，就導回乾淨頁面
                string[] keys = this.Request.Form.AllKeys;
                string searchText = "";
                foreach (string key in keys)
                {
                    if (key.IndexOf("txtSearch") != -1)
                    {
                        searchText = this.Request.Form[key];
                        break;
                    }
                }
                if (string.IsNullOrWhiteSpace(searchText))
                    this.Response.Redirect("NewOrder.aspx");




                string strResult = this.HFSearchResult.Value;
                Rootobject[] objResult = Newtonsoft.Json.JsonConvert.DeserializeObject<Rootobject[]>(strResult);

                // 將前台JavaScript的FuzzySearch結果存至Session
                this.Session["SearchObject"] = objResult;
                this.Session["SearchWord"] = searchText;


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
                // 不是搜尋模式(顯示所有資料)
                else
                {
                    this.Session["SearchObject"] = null;
                    this.Session["SearchWord"] = null;
                    int totalItemSize = CDManager.GetSize();
                    this.searchListPager.TotalItemSize = totalItemSize;

                    int itemSizeInPage = this.searchListPager.ItemSizeInPage;
                    int currentPage = this.searchListPager.GetCurrentPage();

                    // 從資料庫抓取相對應的資料，數量會是ItemSizeInPage
                    CDs = CDManager.GetCDByIndex(itemSizeInPage * (currentPage - 1), itemSizeInPage);

                    // 設定ucPager並計算產生Pagination(Bind)
                    this.searchListPager.Bind();
                }

            }

            // 結果列表
            foreach (var cd in CDs)
            {
                this.ltlCDList.Text +=
                    $"<a class=\"list-group-item list-group-item-action\" data-bs-toggle=\"list\" href=\"#ID{cd.SerialCode}\">" +
                    $"<div class=\"row\">" +
                    $"<div class=\"col-6\"> <h6>{cd.Name}</h6> </div>" +
                    $"<div class=\"col-3\"> <small>{cd.Artist}</small> </div>" +
                    $"<div class=\"col-3\"><small>50</small></div>" +
                    $"</div> </a>";
            }

            // 結果列表的細目
            foreach (var cd in CDs)
            {
                this.ltlCDListTabContent.Text +=
                    $"<div class=\"tab-pane fade\" id=\"ID{cd.SerialCode}\">" +
                    $"<h6>專輯名稱: {cd.Name}</h6>" +
                    $"<small>歌手: {cd.Artist}</small><br />" +
                    $"<small>發行公司: {cd.Brand}</small><br />" +
                    $"<small>發行日期: {cd.PublicationDate.ToString("yyyy-MM-dd")}</small><br />" +
                    $"<small>地區: {cd.Region}</small><br />" +
                    $"<small>可用庫存: 50</small><br />" +
                    $"<small>在途庫存: 10</small><br />" +
                    $"<small>待審核庫存: 2</small><br />" +
                    $"</div>";
            }

            // 將所有CD資料利用JSON傳至Client端，做為FuzzySearch用
            var cdList = CDManager.GetCDList();
            stringObj = Newtonsoft.Json.JsonConvert.SerializeObject(cdList.Select(cd => cd));
        }

    }

    // 從前端傳來的搜尋結果的JSON格式
    public class Rootobject
    {
        public Item item { get; set; }
        public int refIndex { get; set; }
        public float score { get; set; }
    }

    public class Item
    {
        public string SerialCode { get; set; }
        public string Name { get; set; }
        public string Brand { get; set; }
        public string Artist { get; set; }
        public string Region { get; set; }
        public DateTime PublicationDate { get; set; }
    }
}