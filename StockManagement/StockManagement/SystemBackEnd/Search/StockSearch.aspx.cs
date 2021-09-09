using StockManagement.DBSource;
using StockManagement.ORM.DBModels;
using StockManagement.SystemBackEnd.Order;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StockManagement.SystemBackEnd.Search
{
    public partial class StockSearch : System.Web.UI.Page
    {

        public string Searchjson { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            List<CompactDisc> searchlist = CDManager.GetCDList();

            this.Searchjson = Newtonsoft.Json.JsonConvert.SerializeObject(searchlist);



            this.txtSearch.Attributes.Add("data-bs-toggle", "dropdown");
            this.txtSearch.Attributes.Add("autocomplete", "off");
           

            string query = this.Request.QueryString["Page"];
            int pagenb = Convert.ToInt32(query);

            //List<CDStock> CDSList = new List<CDStock>();

            List<CompactDisc> CDSList = new List<CompactDisc>();
           

            if (query == null)
            {
             
                CDSList=CDManager.GetCDByIndex(0, 10);
               
                
            }
            else
            {
                CDSList= CDManager.GetCDByIndex(pagenb*10-10, 10);
               
            }
           

            //List<CompactDisc> CDs = new List<CompactDisc>();
            foreach (var nub in CDSList)
            {


                CompactDisc CD = CDManager.GetCDBySerialCode(nub.SerialCode);
                CDStock CDss= CDStockManager.GetStockBySerialCode(nub.SerialCode);
                int canused = CDss.TotalStock - CDss.InTransitStock - CDss.UnreviewedStock;



                if (CD.Region == null)
                {

                    CD.Region = "－－";
                }

                this.ltlCDStock.Text +=
                    
                            $"<tr>" +
                            $"<th scope = \"row\" id=\"CDN\"class=\"thdsize\" >{CD.Name}</ th >" +
                            $"<td id=\"tdlist\" >{canused}</td>" +
                            $"<td id=\"tdlist\">{CDss.TotalStock}</td>" +
                            $"<td id=\"tdlist\">{CDss.InTransitStock }</td>" +
                            $"<td id=\"tdlist\">{ CDss.UnreviewedStock}</td>" +
                            $"<td >{CD.Artist }</td>" +
                            $"<td>{ CD.Brand}</td>" +
                            $"<td >{ CD.Region}</td>" +
                            $"<td class=\"tdlist\">{CD.PublicationDate.Year }</td>" +
                            $"</tr>";

               


            }
          


            this.ucPager.TotalItemSize = CDStockManager.GetStockSize();
            this.ucPager.Bind();
        }
      


    }
}