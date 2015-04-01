// ***********************************************************************
// Assembly         : B2B.DAL
// Author           : hoangtintg93
// Created          : 01-04-2015
//
// Last Modified By : hoangtintg93
// Last Modified On : 01-04-2015
// ***********************************************************************
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class UserReponsitory
    {
        //Create instance of logger for using log4net methods
        private static readonly ILog logger = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        //Flag to check if error level was enabled.
        private static readonly bool isErrorEnabled = logger.IsErrorEnabled;
        B2BSystemEntities _BSE;
        public UserReponsitory()
        {
            _BSE = new B2BSystemEntities();
        }
        //Get List User
        public IQueryable<User> GetUser()
        {
            return _BSE.Users.AsQueryable();
        }
    }
}
