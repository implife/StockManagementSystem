using StockManagement.DBSource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StockManagement.SystemBackEnd
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string id = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
            Guid logInUserGuid = Guid.Parse(id);

            this.ltlLogInUser.Text = UserInfoManager.GetUserInfoByUserID(logInUserGuid).Name;



            string SB = "/SystemBackEnd/";

            string[] StockSearch = { "庫存查詢", $"{SB}Search/StockSearch.aspx"};
            string[] RecordSearch = { "單據查詢", $"{SB}Search/RecordSearch.aspx"};
            string[] OrderList = { "訂單管理", $"{SB}Order/OrderList.aspx", $"{SB}Order/CheckGoods.aspx", $"{SB}Order/NewOrder.aspx", $"{SB}Order/NewProduct.aspx" };
            
            
            string[] ApproveList = { "核銷待審", $"{SB}Approve/ApproveList.aspx" };
            string[] StuffInfo = { "員工資訊", $"{SB}UserInfo/StaffInfo.aspx", $"{SB}UserInfo/NewStaff.aspx", $"{SB}UserInfo/StaffEditor.aspx" };
            string[] UserInfo = { "使用者資訊", $"{SB}UserInfo/UserInfo.aspx", $"{SB}UserInfo/UserEditor.aspx" };

            string url = HttpContext.Current.Request.Path;
            string[][] AllList = { StockSearch, RecordSearch, OrderList, ApproveList, StuffInfo, UserInfo };

            // 判斷屬於哪個類別並把類別名稱設給Category
            string Catagory = "";
            foreach (string[] List in AllList)
            {
                if (Array.IndexOf(List, url) != -1)
                {
                    Catagory = List[0];
                    break;
                }
            }


            // Render功能列表
            foreach (var ML in AllList)
            {
                if(ML[0] == "核銷待審" && !UserInfoManager.isManager(logInUserGuid))
                    continue;
                if (ML[0] == Catagory)
                {
                    this.ltlMainList.Text += $"<div class='DefDiv1' style='background-color: #EDBE87' ><a href='{ML[1]}'>{ML[0]}</a></div>";
                }
                else
                {
                    this.ltlMainList.Text += $"<div class='DefDiv1'><a href='{ML[1]}'>{ML[0]}</a></div>";
                }
            }
        }
        private static void Logout()
        {
            FormsAuthentication.SignOut();
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Logout();
            Response.Redirect("/Login.aspx");
        }
        
    }

}


