using StockManagement.ORM.DBModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StockManagement.DBSource
{
    public class OrderManager
    {
        /// <summary>
        /// 建立一筆新訂單
        /// </summary>
        /// <param name="order">新訂單</param>
        /// <param name="details">新訂單中各個品項(OrderSalesDetail)的List</param>
        /// <returns>成功回傳true,失敗回傳false</returns>
        public static bool CreateOrder(Order order, List<OrderSalesDetail> details)
        {
            // 檢查傳入值
            if (details == null)
                throw new ArgumentNullException("Order or Sales Detail can't be null.");
            if (details.Count == 0)
                throw new ArgumentException("Should have at least one Order or Sales Detail.");
            if (details.Any(d => d.UnitPrice <= 0))
                throw new ArgumentException("Unit Price must larger than 0.");
            if (details.Any(d => d.Quantity <= 0))
                throw new ArgumentException("Quanyiyt must larger than 0.");


            try
            {
                using (ContextModel context = new ContextModel())
                {
                    order.OrderID = Guid.NewGuid();
                    order.OrderDate = DateTime.Now;
                    order.Status = 0;

                    var detailResult = details.Select(d => {
                        d.OrderID = order.OrderID;
                        d.Type = 0;
                        return d;
                    });

                    context.Orders.Add(order);
                    context.OrderSalesDetails.AddRange(detailResult);

                    context.SaveChanges();
                    return true;
                }
            }
            catch (Exception ex)
            {
                return false;
            }

        }

        /// <summary>
        /// 取得所有訂單的List
        /// </summary>
        /// <returns></returns>
        public static List<Order> GetOrderList()
        {
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    return context.Orders.ToList();
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        /// <summary>
        /// 取得訂單的商品細目(OrderSalesDetail)
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        public static List<OrderSalesDetail> GetDetailByOrder(Order order)
        {
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    return context.OrderSalesDetails.Where(od => od.OrderID == order.OrderID).ToList();
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        /// <summary>
        /// 利用OrderID取得ErrorList
        /// </summary>
        /// <param name="guid"></param>
        /// <returns></returns>
        public static List<OrderError> GetOrderErrorListByOrderID(Guid? guid)
        {
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    return context.OrderErrors.Where(item => item.OrderID.ToString() == guid.ToString()).ToList();
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}
