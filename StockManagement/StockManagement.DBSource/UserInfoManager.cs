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

        public static bool isManager(object guid)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// 根據UserID取得該使用者資料
        /// </summary>
        /// <param name="guid"></param>
        /// <returns></returns>
        public static UserInfo GetUserInfoByUserID(Guid guid)
        {
            using (ContextModel context = new ContextModel())
            {
                return context.UserInfoes.Where(user => user.UserID == guid).FirstOrDefault();
            }
        }

        /// <summary>
        /// 判斷該id的使用者是否為主管
        /// </summary>
        /// <param name="gid"></param>
        /// <returns>是主管回傳true，反之false</returns>
        public static bool isManager(Guid guid)
        {
            UserInfo user = GetUserInfoByUserID(guid);

            if (user.UserLevel != 0)
                return false;
            else
                return true;
        }


        public static bool UpdateStaffInfo(int level,int status,string UserID)
        {
            try
            {
                using (ContextModel context = new ContextModel())
                {
                    var dbObject = context.UserInfoes.Where(obj => obj.UserID.ToString() == UserID).FirstOrDefault();

                    if (dbObject != null)
                    {
                        dbObject.UserLevel = level;
                        dbObject.Status = status;

                        context.SaveChanges();
                    }
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
