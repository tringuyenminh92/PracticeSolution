// ***********************************************************************
// Assembly         : B2B.BL
// Author           : hoangtin
// Created          : 22-03-2015
//
// Last Modified By : hoangtin
// Last Modified On : 22-03-2015
// ***********************************************************************
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using B2B.DAL;
using B2B.BL;
using B2B.Model;
using B2B.BL.IService;
using B2B.DAL.IRepository;
using log4net;
using B2B.DAL.Repository;


namespace B2B.BL.Service
{
    public class LoginService 
    {
        //Create instance of logger for using log4net methods
        private static readonly ILog logger = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        //Flag to check if error level was enabled.
        private static readonly bool isErrorEnabled = logger.IsErrorEnabled;

        //ILoginRepository _loginRepository;
        LoginReponsitory _loginRepository;
        public LoginService()
        {
            _loginRepository = new LoginReponsitory();
        }

        public Model.AccountModel CheckLogin(string accountname, string accountpassword)
        {
            //try
            //{
            //Automapper for converting the source entity to destination entity
            Mapper.CreateMap<Tin_CheckLogin_Result, AccountModel>();

            var userList = _loginRepository.CheckLogin(accountname, accountpassword);
            return Mapper.Map<Tin_CheckLogin_Result, AccountModel>(userList);
            //}
            //catch (Exception)
            //{
            //    logger.Error("");
            //    throw;
            //}
        }
    }
}
