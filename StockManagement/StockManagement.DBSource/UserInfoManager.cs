using StockManagement.ORM.DBModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StockManagement.DBSource
{
    public class UserInfoManager
    {
        /// <summary>
        /// 取得UserInfo資料表裡的所有使用者
        /// </summary>
        /// <returns>型別為UserInfo的List</returns>
        public static List<UserInfo> GetUserInfoList()
        {
            using (ContextModel context = new ContextModel())
            {
                return context.UserInfoes.Select(item => item).ToList();
            }
        }

        /// <summary>
        /// 根據特定使用者帳戶取得該使用者資料
        /// </summary>
        /// <param name="account"></param>
        /// <param name="pwd"></param>
        /// <returns></returns>
        public static UserInfo GetUserInfoByAccountPWD(string account, string pwd)
        {
            using (ContextModel context = new ContextModel())
            {
                return context.UserInfoes.Where(user => user.Account == account && user.PWD == pwd).FirstOrDefault();
            }
        }

        public static UserInfo GetUserInfoByUserID(Guid guid)
        {
            using (ContextModel context = new ContextModel())
            {
                return context.UserInfoes.Where(user => user.UserID == guid).FirstOrDefault();
            }
        }

        public static bool isManager(Guid gid)
        {
            UserInfo user = GetUserInfoByUserID(gid);

            if (user.UserLevel != 0)
                return false;
            else
                return true;
        }

        public static void CreateOrder(Order order, List<OrderSalesDetail> details)
        {
            // 檢查傳入值
            if (details == null)
                throw new ArgumentNullException("Order or Sales Detail can't be null.");
            if (details.Count == 0)
                throw new ArgumentException("Shound have at least one Order or Sales Detail.");
            if(details.Any(d => d.UnitPrice <= 0))
                throw new ArgumentException("Unit Price must larger than 0.");
            if(details.Any(d => d.Quantity <= 0))
                throw new ArgumentException("Quanyiyt must larger than 0.");


            try
            {
                using (ContextModel context = new ContextModel())
                {
                    order.OrderID = Guid.NewGuid();
                    order.OrderDate = DateTime.Now;
                    order.Status = 0;

                    var result = details.Select(d => new OrderSalesDetail(){ 
                        OrderID = order.OrderID,
                        SerialCode = d.SerialCode,
                        UnitPrice = d.UnitPrice,
                        Quantity = d.Quantity,
                        Type = 0
                    });

                    context.Orders.Add(order);
                    context.OrderSalesDetails.AddRange(result);

                    context.SaveChanges();
                }
            }
            catch (Exception ex)
            {

            }
           
        }


    }
}
