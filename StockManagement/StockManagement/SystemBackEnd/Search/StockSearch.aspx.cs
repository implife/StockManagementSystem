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

			

			this.txtSearch.Attributes.Add("data-bs-toggle", "dropdown"); //asp控制項沒有這些功能 要後臺手動加
			this.txtSearch.Attributes.Add("autocomplete", "off");


			string query = this.Request.QueryString["Page"];
			//int pagenb = Convert.ToInt32(query);

			//List<CDStock> CDSList = new List<CDStock>();

			List<CompactDisc> CDSList = new List<CompactDisc>();

			if (IsPostBack)//如果送表單回來
			{
				
				string JAresult = this.btnhappenhf.Value; //將取得的結果值，用string變數去接
				Rootobject[] Searchresultary = Newtonsoft.Json.JsonConvert.DeserializeObject<Rootobject[]>(JAresult); //反序列化變成Class
				this.Session["StockSearchObject"] = Searchresultary;

				CDSList = Searchresultary.Take(10).Select(re => new CompactDisc() //用CDSList去接陣列(要先轉成Llist)一頁10筆(take)
				{
					SerialCode = Guid.Parse(re.item.SerialCode),
					Name = re.item.Name,
					Artist = re.item.Artist,
					Brand = re.item.Brand,
					Region = re.item.Region,
					PublicationDate = re.item.PublicationDate
				}).ToList();

				this.ucPager.TotalItemSize = Searchresultary.Length;
				int pagenb = this.ucPager.GetCurrentPage();

				this.ucPager.isSearch = true;
				this.ucPager.Bind();
			}

			else 
			{

				

				if (this.Request.QueryString["Action"] == "Search")
				{
					Rootobject[] sessionSearchResult = this.Session["StockSearchObject"] as Rootobject[];

					CDSList = sessionSearchResult.Select(resultItem => new CompactDisc() { 
						SerialCode = Guid.Parse(resultItem.item.SerialCode),
						Name = resultItem.item.Name,
						Brand = resultItem.item.Brand,
						Artist = resultItem.item.Artist,
						Region = resultItem.item.Region,
						PublicationDate = resultItem.item.PublicationDate
	                }).ToList();
					this.ucPager.TotalItemSize = CDSList.Count; //.count 取得這個List 比數的總數
					int pagenb = this.ucPager.GetCurrentPage();
					if (pagenb == this.ucPager.GetTotalPage())
						CDSList = CDSList.GetRange(pagenb * 10 - 10, CDSList.Count - (pagenb * 10 - 10));
					else 
						CDSList = CDSList.GetRange(pagenb * 10 - 10, this.ucPager.ItemSizeInPage);

					this.ucPager.isSearch = true;

				}
				else 
				{
                  
			      this.ucPager.TotalItemSize = CDStockManager.GetStockSize();
					int pagenb = this.ucPager.GetCurrentPage();
					CDSList = CDManager.GetCDByIndex(pagenb * 10 - 10, this.ucPager.ItemSizeInPage) ;


				}
				
				
				this.ucPager.Bind();
			}





			//List<CompactDisc> CDs = new List<CompactDisc>();
			foreach (var nub in CDSList)
			{


				CompactDisc CD = CDManager.GetCDBySerialCode(nub.SerialCode);
				CDStock CDss = CDStockManager.GetStockBySerialCode(nub.SerialCode);
				int canused = CDss.TotalStock - CDss.InTransitStock - CDss.UnreviewedStock;



				if (CD.Region == null)
				{

					CD.Region = "－－";
				}

				this.ltlCDStock.Text +=

							$"<tr class=\"trlist\" >" +
							$"<th scope = \"row\" id=\"CDN\"class=\"thdsize\" >{CD.Name}</ th >" +
							$"<td id=\"tdlist\" >{canused}</td>" +
							$"<td id=\"tdlist\">{CDss.TotalStock}</td>" +
							$"<td id=\"tdlist\">{CDss.InTransitStock }</td>" +
							$"<td >{CD.Artist }</td>" +
							$"<td>{ CD.Brand}</td>" +
							$"<td >{ CD.Region}</td>" +
							$"<td class=\"tdlist\">{CD.PublicationDate.Year }</td>" +
							$"</tr>";




			}



			
		}

		public class Rootobject
		{
			//fuzzysearch 的結果格式
			public Item item { get; set; }
			public int refIndex { get; set; }
			public float score { get; set; }
		}

		public class Item
		{
			//fuzzysearch 的結果格式
			public string SerialCode { get; set; }
			public string Name { get; set; }
			public string Brand { get; set; }
			public string Artist { get; set; }
			public string Region { get; set; }
			public DateTime PublicationDate { get; set; }
		}



	}
}