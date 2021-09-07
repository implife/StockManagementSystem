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
    public partial class StockSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           

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
                CDStock CDs= CDStockManager.GetStockBySerialCode(nub.SerialCode);
                int canused = CDs.TotalStock - CDs.InTransitStock - CDs.UnreviewedStock;
          




                this.ltlCDStock.Text +=
                    
                            $"<tr>" +
                            $"<th scope = \"row\" >{CD.Name}</ th >" +
                            $"<td>{canused}</td>" +
                            $"<td>{CDs.TotalStock}</td>" +
                            $"<td>{CDs.InTransitStock }</td>" +
                            $"<td>{ CDs.UnreviewedStock}</td>" +
                            $"<td>{CD.Artist }</td>" +
                            $"<td>{ CD.Brand}</td>" +
                            $"<td>{CD.PublicationDate.Year }</td>" +
                            $"<td>{ CD.Region}</td>" +
                            $"</tr>";




            }
          


            this.ucPager.TotalItemSize = CDStockManager.GetStockSize();
            this.ucPager.Bind();
        }
        


    }
}