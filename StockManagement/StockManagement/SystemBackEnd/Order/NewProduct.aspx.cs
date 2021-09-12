using StockManagement.DBSource;
using StockManagement.ORM.DBModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StockManagement.SystemBackEnd.Order
{
    public partial class NewProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.EpisodeName.Attributes.Add("placeholder", "專輯名稱");
            this.Brand.Attributes.Add("placeholder", "發行公司");
            this.Artist.Attributes.Add("placeholder", "表演者");
            this.Region.Attributes.Add("placeholder", "地區");


        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            var formData = this.Request.Form;
            string name = "", brand = "", artist = "", region = "";
            DateTime date = new DateTime();
            foreach (string key in formData.Keys)
            {
                if (key.EndsWith("EpisodeName"))
                    name = formData[key];
                if (key.EndsWith("Brand"))
                    brand = formData[key];
                if (key.EndsWith("Artist"))
                    artist = formData[key];
                if (key.EndsWith("Region"))
                    region = formData[key];
                if (key.EndsWith("PubDate"))
                {
                    string[] temp = formData[key].Split('-');
                    int y = Convert.ToInt32(temp[0]);
                    int m = Convert.ToInt32(temp[1]);
                    int d = Convert.ToInt32(temp[2]);
                    date = new DateTime(y, m, d);
                }
            }

            CompactDisc cd = new CompactDisc() {
                Name = name,
                Brand = brand,
                Artist = artist,
                Region = region,
                PublicationDate = date
            };

            CompactDisc result = CDManager.CreateCompactDisc(cd);

            if (result != null)
            {

                this.Session["NewProduct"] = result;
                this.Response.Redirect("NewOrder.aspx");
            }
            else
            {
                this.ltlFailedModal.Text = "" +
                    "<div class='modal fade' id='CreateFailedModal' tabindex='-1' aria-hidden='true'>" +
                        "<div class='modal-dialog'>" +
                            "<div class='modal-content'>" +
                                "<div class='modal-body'>" +
                                    "<div class='alert alert-danger' role='alert'>新增失敗!</div>" +
                                "</div>" +
                                "<div class='modal-footer'>" +
                                    "<button type'button' class='btn btn-secondary' data-bs-dismiss='modal'>關閉</button>" +
                                "</div>" +
                            "</div>" +
                        "</div>" +
                    "</div>";
                this.ltlFailedModal.Text += "<script>$(function(){" +
                    "var myModal = new bootstrap.Modal(document.getElementById('CreateFailedModal'), {keyboard: false});" +
                    "myModal.show();})</script>";
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("NewOrder.aspx");
        }
    }
}