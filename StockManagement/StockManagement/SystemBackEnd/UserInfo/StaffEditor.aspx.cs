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
            if(IsPostBack)
            {
                string LV = this.HDField.Value;
                
            }
            string UserID = this.Request.QueryString["ID"];
            ORM.DBModels.UserInfo userinfo = UserInfoManager.GetUserInfoByUserID(Guid.Parse(UserID));


            string Level = "";
            if (userinfo.UserLevel == 0)
            {
                Level = "主管";
            }
            else if (userinfo.UserLevel == 1)
            {
                Level = "正職員工";
            }
            else
            {
                Level = "兼職員工";
            }

            String Status = "";
            if (userinfo.Status == 0)
            {
                Status = "在職";
            }
            else if (userinfo.Status == 1)
            {
                Status = "離職";
            }
            else
            {
                Status = "調店";
            }

            //string Editor = UserInfoManager.isManager(guid) ? $"<a href='/SystemBackend/UserInfo/Staffeditor.aspx?ID={user.UserID}'><span class='badge'>編輯</span></a>" : "";
            string level =
                 $"<div class='btn-group'>" +
                 $" <button id='btnLevel' type='button' class='btn btn-danger dropdown-toggle' data-bs-toggle='dropdown' aria-expanded='false' > {Level}</button>" +
                 $" <ul class='dropdown-menu Choice' >" +
                 $" <li><a class='dropdown-item' href='#' Data-type='0' >主管</a></li>" +
                 $"<li><a class='dropdown-item' href='#' Data-type='1'> 全職</a></li>" +
                 $" <li><a class='dropdown-item' href='#' Data-type='2'>兼職</a></li>" +
                 $"</ul>" +
                 $"</div>";


            string status =
                $"<div class='btn-group'>" +
                $"<button id='btnStatus' type='button' class='btn btn-danger dropdown-toggle' data-bs-toggle='dropdown' aria-expanded='false'>{Status}</button>" +
                $"<ul class='dropdown-menu Choice'>" +
                $"<li><a class='dropdown-item' href='#' Data-Fucking-type='0'>在職</a></li>" +
                $"<li><a class='dropdown-item' href='#' Data-Fucking-type='1'>離職</a></li>" +
                $"<li><a class='dropdown-item' href='#' Data-Fucking-type='2'>調店</a></li>" +
                $"</ul>" +
                $"</div>";
                

            this.ltlStaffEditor.Text +=
                $"<tr>" +
                $"<td>{userinfo.Name}</td>" +
                $"<td>{userinfo.BloodType}</td>" +
                $"<td>{userinfo.Tel}</td>" +
                $"<td>{level}</td>" +
                $"<td>{userinfo.Title}</td>" +
                $"<td>{status}</td>" +
                $"<td>{userinfo.Email}</td>" +
                $"<td>{userinfo.EmploymentDate}</td>" +
                $"</tr>";

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string[] result = this.HDField.Value.Split(',');
            int level = Convert.ToInt32(result[0]);
            int status = Convert.ToInt32(result[1]);
            string UserID = this.Request.QueryString["ID"];

            DBSource.UserInfoManager.UpdateStaffInfo(level, status, UserID);

        }
    }
}