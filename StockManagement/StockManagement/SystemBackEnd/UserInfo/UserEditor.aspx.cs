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
    public partial class WebForm1 : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
                Guid guid = Guid.Parse(id);

                ORM.DBModels.UserInfo userData = DBSource.UserInfoManager.GetUserInfoByUserID(guid);

                #region 動態產生Placeholder給各個TextBox
                this.txtInputName.Attributes.Add("placeholder", "請輸入名字");
                this.txtInputName.Text = userData.Name;
                this.txtInputAccount.Attributes.Add("placeholder", "請輸入帳號");
                this.txtInputAccount.Text = userData.Account;
                this.txtInputMail.Attributes.Add("placeholder", "請輸入電子郵件");
                this.txtInputMail.Text = userData.Email;
                this.txtInputTel.Attributes.Add("placeholder", "請輸入電話號碼");
                this.txtInputTel.Text = userData.Tel;


                this.ltlBlood.Text = $"<button id='btnBlood' type='button' class='btn btn-success dropdown-toggle btn-Blood' data-bs-" +
                 $"toggle='dropdown'>{userData.BloodType}</button>";
                #endregion
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            ORM.DBModels.UserInfo userInfo = new ORM.DBModels.UserInfo();
            string id = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
            Guid guid = Guid.Parse(id);

            userInfo.UserID = guid;
            userInfo.Name = txtInputName.Text;
            userInfo.Account = txtInputAccount.Text;
            userInfo.Email = txtInputMail.Text;
            userInfo.Tel = txtInputTel.Text;
            userInfo.BloodType = HD_Blood.Value;


            bool result = UserInfoManager.UpdateUserInfo(userInfo);
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