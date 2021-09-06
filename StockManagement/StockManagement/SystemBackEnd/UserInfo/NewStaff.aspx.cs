using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StockManagement.DBSource;
using StockManagement.ORM.DBModels;

namespace StockManagement.SystemBackEnd.UserInfo
{
    public partial class NewStaff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            #region 動態產生Placeholder給各個TextBox
            this.txtInputName.Attributes.Add("placeholder", "請輸入名字");
            this.txtInputAccount.Attributes.Add("placeholder", "請輸入帳號");
            this.txtInputPassword.Attributes.Add("placeholder", "請輸入密碼");
            this.txtInputMail.Attributes.Add("placeholder", "請輸入電子郵件");
            this.txtInputTel.Attributes.Add("placeholder", "請輸入電話號碼");
            #endregion

           

        }

        protected void btnNewStaff_Click(object sender, EventArgs e)
        {
            string[] Time = this.HD_StartDate.Value.Split('-');
            int Y = Convert.ToInt32(Time[0]);
            int M = Convert.ToInt32(Time[1]);
            int D = Convert.ToInt32(Time[2]);
            DateTime startDate = new DateTime(Y, M, D);

            string title = "";
            if(Convert.ToInt32(HD_LVAndBlood.Value.Split(',')[0]) == 0)
            {
                title = "StockManager";

            }
            else
            {
                title = "StockKeeper";
            }

            ORM.DBModels.UserInfo userInfo = new ORM.DBModels.UserInfo();

            userInfo.Name = txtInputName.Text;
            userInfo.Account = txtInputAccount.Text;
            userInfo.PWD = txtInputPassword.Text;
            userInfo.Email = txtInputMail.Text;
            userInfo.Tel = txtInputTel.Text;
            userInfo.EmploymentDate = startDate;
            userInfo.UserLevel = Convert.ToInt32(HD_LVAndBlood.Value.Split(',')[0]);
            userInfo.Status = 0;
            userInfo.Title = title;
            userInfo.BloodType = HD_LVAndBlood.Value.Split(',')[1];
            

            bool result = UserInfoManager.CreateNewStaff(userInfo);
            if(result == true)
            {
                this.Response.Redirect("/SystemBackEnd/UserInfo/Staffinfo.aspx");
            }
            else
            {
                this.lblMsg.Text = "新進員工資料創建失敗,請稍後再試.";
                this.Response.Redirect("/SystemBackEnd/UserInfo/Staffinfo.aspx");
            }
            
            
        }


                
      
    }
}