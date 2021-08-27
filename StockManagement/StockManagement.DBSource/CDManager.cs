using StockManagement.ORM.DBModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StockManagement.DBSource
{
    public class CDManager
    {
        /// <summary>
        /// 取得資料庫裡CD的總數
        /// </summary>
        /// <returns></returns>
        public static int GetSize()
        {
            using (ContextModel context = new ContextModel())
            {
                return context.CompactDiscs.Count();
            }
        }

        /// <summary>
        /// 取得資料庫裡所有的CD資料
        /// </summary>
        /// <returns></returns>
        public static List<CompactDisc> GetCDList()
        {
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    return context.CompactDiscs.ToList();
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        /// <summary>
        /// 取得特定位置(案專輯名稱排序過後)開始特定數量的CD資料
        /// </summary>
        /// <param name="startIndex">起始所引值</param>
        /// <param name="size">要取得的資料筆數(超過最後一筆所引值則取到最後一筆)</param>
        /// <returns></returns>
        public static List<CompactDisc> GetCDByIndex(int startIndex, int size)
        {
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    if (startIndex < 0 || startIndex >= context.CompactDiscs.Count())
                        throw new IndexOutOfRangeException("startIndex is out of range.");

                    return context.CompactDiscs.OrderBy(cd => cd.Name).Skip(startIndex).Take(size).ToList();
                }
            }
            catch (Exception ex)
            {
                return null;
            }

        }
    }
}
