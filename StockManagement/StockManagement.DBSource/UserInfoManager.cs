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
    }
}
