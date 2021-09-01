using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace StockManagement.SystemBackEnd.Handler
{
    /// <summary>
    /// Summary description for CDDataHandler
    /// </summary>
    public class CDDataHandler : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string action = context.Request.QueryString["Action"];

            if (string.Compare(action, "NewOrderTempList") == 0)
            {
                string type = context.Request.Form["TempListType"];

                if (type == null)
                {
                    context.Response.StatusCode = 401;
                    context.Response.End();
                }


                TempListCD[] result = null;
                if (type == "Add")
                {
                    string tempListJson = context.Request.Form["TempListJSON"];
                    string AddCDJSON = context.Request.Form["AddCD"];

                    TempListCD[] tempCDs = Newtonsoft.Json.JsonConvert.DeserializeObject<TempListCD[]>(tempListJson);
                    TempListCD addCD = Newtonsoft.Json.JsonConvert.DeserializeObject<TempListCD>(AddCDJSON);

                    result = tempCDs.Concat(new TempListCD[] { addCD }).ToArray();
                    

                }
                else if (type == "ChangeQuantity")
                {
                    string tempListJson = context.Request.Form["TempListJSON"];
                    string CgangeCDJSON = context.Request.Form["ChangeCD"];

                    TempListCD[] tempCDs = Newtonsoft.Json.JsonConvert.DeserializeObject<TempListCD[]>(tempListJson);
                    TempListCD changeCD = Newtonsoft.Json.JsonConvert.DeserializeObject<TempListCD>(CgangeCDJSON);

                    result = tempCDs.Select(item => {
                        if (item.Name == changeCD.Name)
                            return changeCD;
                        return item;
                    }).ToArray();
                    
                }
                else if (type == "Delete")
                {
                    string tempListJson = context.Request.Form["TempListJSON"];
                    string DeleteCDJSON = context.Request.Form["DeleteCD"];

                    TempListCD[] tempCDs = Newtonsoft.Json.JsonConvert.DeserializeObject<TempListCD[]>(tempListJson);
                    TempListCD deleteCD = Newtonsoft.Json.JsonConvert.DeserializeObject<TempListCD>(DeleteCDJSON);

                    result = tempCDs.Where(item => item.Name != deleteCD.Name).ToArray();
                }
                else
                {
                    context.Response.StatusCode = 401;
                    context.Response.End();
                }

                string resultJSON = Newtonsoft.Json.JsonConvert.SerializeObject(result);
                context.Session["TempList"] = resultJSON;

                context.Response.ContentType = "text/json";
                context.Response.Write(resultJSON);
            }
            else
            {
                context.Response.StatusCode = 401;
                context.Response.End();
            }


        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        public class TempListCD
        {
            public string Name { get; set; }
            public string Quantity { get; set; }
        }

    }
}