using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StockManagement.SystemBackEnd
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string SB = "SystemBackEnd";

            string[] StockSearch = { "庫存查詢", $"/{SB}/Search/StockSearch.aspx", $"/{SB}/Search/StockDetail.aspx" };
            string[] RecordSearch = { "單據查詢",  $"/{SB}/Search/RecordSearch.aspx", "RecordList.aspx", "RecordDetail" };
            string[] OrderList = { "訂單管理", $"/{SB}/Order/OrderList.aspx", "NewOrder.aspx", "OrderDetail" };
            string[] SalesList = { "銷貨管理", $"/{SB}/Reimbursment/SalesList.aspx" };
            string[] Reimbursment = { "報銷管理", $"/{SB}/Sales/SalesList.aspx" };
            string[] ApproveList = { "核銷待審", $"/{SB}/Approve/ApproveList.aspx" };
            string[] StuffInfo = { "員工資訊", $"/{SB}/UserInfo/StaffInfo.aspx" };
            string[] UserInfo = { "使用者資訊",  $"/{SB}/UserInfo/UserInfo.aspx" };

            string url = HttpContext.Current.Request.RawUrl;
            string[][] AllList = { StockSearch, RecordSearch, OrderList, SalesList, Reimbursment, ApproveList, StuffInfo, UserInfo };

            string Catagory = "";
            foreach (string[] List in AllList)
            {

                if (Array.IndexOf(List, url) != -1)
                {
                    Catagory = List[0];
                }
            }

            // 結果列表的細目
            foreach (var ML in AllList)
            {
                if (ML[0] == Catagory)
                {
                    this.ltlMainList.Text += $"<div class='DefDiv1' style=' background-color: #EDBE87' ><a href='{ML[1]}'>{ML[0]}</a></div>";
                }
                else
                {
                    this.ltlMainList.Text += $"<div class='DefDiv1'><a href='{ML[1]}'>{ML[0]}</a></div>";
                }


            }
        }
    }
}


            //string[] Title = { "庫存查詢", "單據查詢", "訂單管理", "銷貨管理", "報銷管理", "核銷待審", "員工資訊", "使用者資訊",  };
            //string[] Web = { "StockSearch.aspx", "RecordSearch.aspx", "OrderList.aspx", "SalesList.aspx", "Reimbursment.aspx", "ApproveList.aspx", "StuffInfo.aspx", "UserInfo.aspx", };



//<div class="DefDiv1"><a href="#">庫存查詢</a></div>
//<div class="DefDiv2"><a href="#">單據查詢</a></div>
//<div class="DefDiv3"><a href="/SystemBackEnd/Order/OrderList.aspx">訂單管理</a></div>
//<div class="DefDiv4"><a href="#">銷貨管理</a></div>
//<div class="DefDiv5"><a href="#">報銷管理</a></div>
//<div class="DefDiv6"><a href="#">核銷待審</a></div>
//<div class="DefDiv7"><a href="#">員工資訊</a></div>
//<div class="DefDiv8"><a href="#">使用者資訊</a></div>
//<div class="DefDiv9"><a href="#">單據查詢</a></div>


