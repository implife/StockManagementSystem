﻿using StockManagement.DBSource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace StockManagement
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            // 某些特定頁面須檢查是否為Manager
            string[] pages = {
                "/SystemBackEnd/Order/NewOrder.aspx"};

            var request = HttpContext.Current.Request;
            var response = HttpContext.Current.Response;
            string path = request.Url.PathAndQuery;

            // SystemBackEnd下的頁面都要經過登入檢查
            if (path.StartsWith("/SystemBackEnd", StringComparison.InvariantCultureIgnoreCase))
            {
                var user = HttpContext.Current.User;
                if (!request.IsAuthenticated || user == null)
                {
                    response.StatusCode = 403;
                    response.End();
                    return;
                }

                // request是否為須檢查Manager權限的頁面
                foreach (string item in pages)
                {
                    if (path.StartsWith(item))
                    {
                        string id = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
                        Guid gid = Guid.Parse(id);
                        if (!UserInfoManager.isManager(gid))
                        {
                            response.StatusCode = 403;
                            response.End();
                            return;
                        }

                    }
                }

                FormsIdentity identity = user.Identity as FormsIdentity;

                if (identity == null)
                {
                    return;
                }
            }
        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}