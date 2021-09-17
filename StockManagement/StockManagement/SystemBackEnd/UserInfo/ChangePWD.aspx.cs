using StockManagement.DBSource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StockManagement.SystemBackEnd.UserInfo
{
    public partial class ChangePWD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            ORM.DBModels.UserInfo userInfo = new ORM.DBModels.UserInfo();
            string id = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
            Guid guid = Guid.Parse(id);
            ORM.DBModels.UserInfo OldUserinfo = UserInfoManager.GetUserInfoByUserID(guid);

            var NewPWD = txtInputNewPWD.Text;

            if (txtInputOldPWD.Text != OldUserinfo.PWD)
            {
                this.ltlModal.Text = "<script>var myModal2 = new bootstrap.Modal(document.getElementById('resultModal2'), {keyboard: false});myModal.show()</script>";
            }
            userInfo.PWD = NewPWD;
            bool result = UserInfoManager.UpdateUserPWD(guid,NewPWD);
            if (result == true)
            {

                this.Response.Redirect("/SystemBackEnd/UserInfo/UserInfo.aspx");
            }
            else
            {
                this.ltlModal.Text = "<script>var myModal = new bootstrap.Modal(document.getElementById('resultModal'), {keyboard: false});myModal.show()</script>";
            }
        }

    }
}