using StockManagement.ORM.DBModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StockManagement.DBSource
{
    public class CDStockManager
    {
        public static int GetStockSize()
        {
            using (ContextModel context = new ContextModel())
            {
                return context.CDStocks.Count();
            }
        }

        public static List<CDStock> GetStockList()
        {
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    return context.CDStocks.ToList();
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public static List<CDStock> GetStockByIndex(int startIndex, int size)
        {
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    if (startIndex < 0 || startIndex >= context.CompactDiscs.Count())
                        throw new IndexOutOfRangeException("startIndex is out of range.");

                    return context.CDStocks.OrderBy(Code => Code.SerialCode).Skip(startIndex).Take(size).ToList();
                }
            }
            catch (Exception ex)
            {
                return null;
            }

        }

        public static CDStock GetStockBySerialCode(Guid serialCode)
        {
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    return context.CDStocks.Where(item => item.SerialCode.ToString() == serialCode.ToString()).FirstOrDefault();
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        /// <summary>
        /// 增加總庫存
        /// </summary>
        /// <param name="serialCode">要增加的目標CD條碼號</param>
        /// <param name="AddSize">要增加的數量</param>
        /// <param name="isCheckGoods">是否為點貨</param>
        /// <param name="isReimburse">是否為報銷</param>
        /// <returns>成功回傳true，反之false</returns>
        public static bool UpdateStock(Guid serialCode, int AddSize, bool isCheckGoods = false, bool isReimburse = false)
        {
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    CDStock stockObj = context.CDStocks.Where(item => item.SerialCode == serialCode).FirstOrDefault();

                    if(isCheckGoods)
                        stockObj.InTransitStock -= AddSize;

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
