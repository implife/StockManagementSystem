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
        
        public static int GetSize()
        {
            using (ContextModel context = new ContextModel())
            {
                return context.CompactDiscs.Count();
            }
        }

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
