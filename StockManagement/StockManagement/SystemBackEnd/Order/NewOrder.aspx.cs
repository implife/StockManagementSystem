using StockManagement.DBSource;
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
            this.txtSearch.Attributes.Add("data-bs-toggle", "dropdown");
            this.txtSearch.Attributes.Add("autocomplete", "off");



            int totalItemSize = CDManager.GetSize();
            int itemSizeInPage = this.searchListPager.ItemSizeInPage;
            int currentPage = this.searchListPager.GetCurrentPage();

            this.searchListPager.TotalItemSize = totalItemSize;
            this.searchListPager.Bind();


            var CDs = CDManager.GetCDByIndex(itemSizeInPage * (currentPage - 1), itemSizeInPage);

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


            var cdList = CDManager.GetCDList();

            stringObj = Newtonsoft.Json.JsonConvert.SerializeObject(cdList.Select(cd => cd));
        }
    }
}