using StockManagement.DBSource;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StockManagement.SystemBackEnd.Order
{
    public partial class OrderList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = (HttpContext.Current.User.Identity as FormsIdentity).Ticket.UserData;
            Guid gid = Guid.Parse(id);

            if (!UserInfoManager.isManager(gid))
                this.btnNewOrder.Enabled = false;
        }

        protected void btnNewOrder_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("/SystemBackEnd/Order/NewOrder.aspx");
        }
    }
}