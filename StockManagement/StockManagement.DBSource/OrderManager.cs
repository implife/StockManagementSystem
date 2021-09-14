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

            if (order.OrderResponsiblePerson == null)
                throw new ArgumentException("OrderResponsiblePerson should not be null");

            try
            {
                using (ContextModel context = new ContextModel())
                {
                    order.OrderID = Guid.NewGuid();
                    order.OrderDate = DateTime.Now;
                    order.Status = 0;

                    var detailResult = details.Select(d =>
                    {
                        d.OrderID = order.OrderID;
                        d.Type = 0;
                        return d;
                    });

                    // 增加在途庫存
                    //foreach (OrderSalesDetail de in details)
                    //{
                    //    var stockObj = context.CDStocks.Where(item => item.SerialCode == de.SerialCode).FirstOrDefault();
                    //    stockObj.InTransitStock += de.Quantity;
                    //}

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
        /// 新建一筆補貨訂單
        /// </summary>
        /// <param name="originalOrder">原訂單，須填入點貨負責人</param>
        /// <param name="details">新訂單的Detail List</param>
        /// <param name="errorOrder">原訂單中異常的品項List</param>
        /// <returns></returns>
        public static bool CreateReplenishOrder(Order originalOrder, List<OrderSalesDetail> NewDetails, List<OrderError> errorOrder)
        {
            // 檢查傳入值
            if (NewDetails == null)
                throw new ArgumentNullException("Order or Sales Detail can't be null.");
            if (NewDetails.Count == 0)
                throw new ArgumentException("Should have at least one Order or Sales Detail.");
            if (NewDetails.Any(d => d.UnitPrice <= 0))
                throw new ArgumentException("Unit Price must larger than 0.");
            if (NewDetails.Any(d => d.Quantity <= 0))
                throw new ArgumentException("Quanyiyt must larger than 0.");


            if (originalOrder.ArrivalResponsiblePerson == null)
                throw new ArgumentException("ArrivalResponsiblePerson should not be null");

            try
            {
                using (ContextModel context = new ContextModel())
                {
                    // 新訂單
                    Order NewOrder = new Order()
                    {
                        OrderID = Guid.NewGuid(),
                        OrderDate = DateTime.Now,
                        Seller = originalOrder.Seller,
                        Status = 4,
                        MainOrder = originalOrder.MainOrder == null ? originalOrder.OrderID : originalOrder.MainOrder
                    };

                    // 新訂單的Order Detail
                    var detailResult = NewDetails.Select(d =>
                    {
                        d.OrderID = NewOrder.OrderID;
                        d.Type = 0;
                        return d;
                    });

                    // 原訂單的關聯單號&狀態&到貨日期&點貨負責人
                    Order originalObj = context.Orders.Where(item => item.OrderID == originalOrder.OrderID).FirstOrDefault();
                    originalObj.ReplenishID = NewOrder.OrderID;
                    originalObj.Status = 2;
                    originalObj.ArrivalDate = DateTime.Now;
                    originalObj.ArrivalResponsiblePerson = originalOrder.ArrivalResponsiblePerson;
                    if (originalObj.MainOrder == null)
                        originalObj.MainOrder = originalObj.OrderID;

                    // 異常資料
                    var errResult = errorOrder.Select(item =>
                    {
                        item.OrderID = originalOrder.OrderID;
                        return item;
                    });

                    context.Orders.Add(NewOrder);
                    context.OrderSalesDetails.AddRange(detailResult);
                    context.OrderErrors.AddRange(errResult);

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
        /// 將配送中的訂單改為配送完成
        /// </summary>
        /// <param name="order">原配送中的訂單</param>
        /// <returns></returns>
        public static bool UpdateOrderToDeliverComplete(Order order)
        {
            if (order.Status != 1)
                throw new ArgumentException("Status should be Delivering.");
            if (order.ArrivalResponsiblePerson == null)
                throw new ArgumentException("ArrivalResponsiblePerson should not be null");

            try
            {
                using (ContextModel context = new ContextModel())
                {
                    Order orderObj = context.Orders.Where(item => item.OrderID == order.OrderID).FirstOrDefault();
                    orderObj.Status = 3;
                    orderObj.ArrivalDate = DateTime.Now;
                    orderObj.ArrivalResponsiblePerson = order.ArrivalResponsiblePerson;

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
        /// 將未配送的訂單改成配送中
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        public static bool UpdateOrderToDelivering(Order order)
        {
            if (order.Status != 0)
                throw new ArgumentException("Status should be 'Not Delivered'.");

            try
            {
                using (ContextModel context = new ContextModel())
                {
                    Order orderObj = context.Orders.Where(item => item.OrderID == order.OrderID).FirstOrDefault();
                    orderObj.Status = 1;
                    orderObj.PredictedArrivalDate = order.PredictedArrivalDate;

                    // 增加在途庫存
                    List<OrderSalesDetail> details = OrderManager.GetDetailByOrder(order);
                    foreach (OrderSalesDetail de in details)
                    {
                        var stockObj = context.CDStocks.Where(item => item.SerialCode == de.SerialCode).FirstOrDefault();
                        stockObj.InTransitStock += de.Quantity;
                    }

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
        /// 利用OrderID取得對應的Order
        /// </summary>
        /// <param name="guid"></param>
        /// <returns></returns>
        public static Order GetOrderByOrderID(Guid guid)
        {
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    return context.Orders.Where(item => item.OrderID.Equals(guid)).FirstOrDefault();
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


        public static bool UpdateDeliverCompleteToComplete(Order order)
        {
            if (order.Status != 3)
                throw new ArgumentException("Status Should Be DeliverComplete!!");
            try
            {
                using (ContextModel context = new ContextModel())
                {

                    if (order.MainOrder != null)
                    {
                        List<Order> MainOrderList =  context.Orders.Where(obj => obj.MainOrder == order.MainOrder).ToList();
                        
                        foreach(var mainList in MainOrderList)
                        {
                            mainList.ArchiveResponsiblePerson = order.ArchiveResponsiblePerson;
                            mainList.Status = 5;
                        }
                    }
                    else
                    {
                        Order orderObj = context.Orders.Where(item => item.OrderID == order.OrderID).FirstOrDefault();
                        orderObj.ArchiveResponsiblePerson = order.ArchiveResponsiblePerson;
                        orderObj.Status = 5;
                    }


                    context.SaveChanges();
                    return true;
                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }


        public static bool UpdateoWaitForReviewedToNotDeliver(Order order)
        {
            if (order.Status != 4)
                throw new ArgumentException("Status Should Be DeliverComplete!!");
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    Order orderObj = context.Orders.Where(item => item.OrderID == order.OrderID).FirstOrDefault();
                    orderObj.Status = 0;
                    orderObj.OrderResponsiblePerson = order.OrderResponsiblePerson;

                    context.SaveChanges();
                    return true;
                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }



    }
}
