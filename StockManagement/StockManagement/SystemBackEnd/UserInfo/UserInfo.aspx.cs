using StockManagement.DBSource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StockManagement.ORM;
using System.Web.Security;

namespace StockManagement.SystemBackEnd.UserInfo
{
    public partial class UserInfo : System.Web.UI.Page
    {

        #region Get Set使用者資訊傳去aspx檔
        public string tel { get; set; }
        public string address { get; set; }

        public string name { get; set; }
        public string title { get; set; }
        public string email { get; set; }

        public string status { get; set; }

        public string pwd { get; set; }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            var UInfo = new List<StockManagement.ORM.DBModels.UserInfo>();
            UInfo = UserInfoManager.GetUserInfoList();
            // 結果列表的細目
            string id = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
            Guid guid = Guid.Parse(id);

            ORM.DBModels.UserInfo user = UInfo.Where(n => n.UserID == guid).FirstOrDefault();

            string Level = "";
            if (user.UserLevel == 0)
            {
                Level = "主管";
            }
            else if (user.UserLevel == 1)
            {
                Level = "正職員工";
            }
            else
            {
                Level = "兼職員工";
            }

            String Status = "";
            if (user.Status == 0)
            {
                Status = "在職";
            }
            else if (user.Status == 1)
            {
                Status = "離職";
            }
            else
            {
                Status = "調店";
            }

            this.tel = user.Tel;
            this.address = user.Account;
            this.name = user.Name;
            this.pwd = user.PWD;
            this.status = Status;
            this.email = user.Email;
            this.title = Level;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string id = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
            Guid guid = Guid.Parse(id);
            this.Response.Redirect($"/SystemBackEnd/UserInfo/UserEditor.aspx?UID={guid}");
            
        }
        
    }
}


//< h2 > 薛丁格庫存管理 三上悠亞 <%= %></ h2 >

//       < p > 狀態：在職 </ p >

//          < p > 職稱：主管 </ p >

//             < p > 電子信箱：sad0043138856 @gmail.com</p>
//                <p>密碼：11111</p>

//    <p>座右銘：服務至上，永不懈怠</p>