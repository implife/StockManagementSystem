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