using StockManagement.DBSource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StockManagement.SystemBackEnd.UserInfo
{
    public partial class StaffEditor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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

            //string Editor = UserInfoManager.isManager(guid) ? $"<a href='/SystemBackend/UserInfo/Staffeditor.aspx?ID={user.UserID}'><span class='badge'>編輯</span></a>" : "";


            this.ltlStaffEditor.Text +=
                $"<tr>" +
                $"<td>{user.Name}</td>" +
                $"<td>{user.BloodType}</td>" +
                $"<td>{user.Tel}</td>" +
                $"<td>{Level}</td>" +
                $"<td>{user.Title}</td>" +
                $"<td>{Status}</td>" +
                $"<td>{user.Email}</td>" +
                $"<td>{user.EmploymentDate}</td>" +
                $"<td>{Editor}</td>" +
                $"</tr>";

        }
    }
}