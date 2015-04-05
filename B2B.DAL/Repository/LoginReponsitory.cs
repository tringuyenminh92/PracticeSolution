using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using B2B.DAL;
using B2B.DAL.IRepository;
using log4net;
using System.Data.Objects;

namespace B2B.DAL.Repository
{
    public class LoginReponsitory
    {
        //Create instance of logger for using log4net methods
        private static readonly ILog logger = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        //Flag to check if error level was enabled.
        private static readonly bool isErrorEnabled = logger.IsErrorEnabled;

        B2BSystemEntities _BSE;
        public LoginReponsitory()
        {
            _BSE = new B2BSystemEntities();
        }
        /// <summary>
        /// Check Login.
        /// </summary>
        /// <param name="loggedUser">The logged user.</param>
        /// <param name="showAll">if set to <c>true</c> [show all].</param>
        /// <returns>List{Tin_CheckLogin_Result}.</returns>
        public Tin_CheckLogin_Result CheckLogin(string accountname, string accountpassword)
        {
            //try
            //{
            //if (showAll) loggedUser = "%%";
            //return _BSE.SP_SelectQuotes(" ").AsQueryable();
            return _BSE.Tin_CheckLogin(accountname, accountpassword).AsQueryable().FirstOrDefault();
            //}
            //catch (Exception)
            //{
            //    logger.Error("");
            //    throw;
            //}
        }
    }
}
