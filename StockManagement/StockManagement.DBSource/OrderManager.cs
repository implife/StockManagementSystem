using StockManagement.ORM.DBModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StockManagement.DBSource
{
    class OrderManager
    {
        public static void CreateOrder(Order order, List<OrderSalesDetail> details)
        {
            // 檢查傳入值
            if (details == null)
                throw new ArgumentNullException("Order or Sales Detail can't be null.");
            if (details.Count == 0)
                throw new ArgumentException("Shound have at least one Order or Sales Detail.");
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

                    var result = details.Select(d => new OrderSalesDetail()
                    {
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
