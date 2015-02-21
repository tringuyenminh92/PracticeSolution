// ***********************************************************************
// Assembly         : B2B.BL
// Author           : Ga9286
// Created          : 24-01-2015
//
// Last Modified By : Ga9286
// Last Modified On : 24-01-2015
// ***********************************************************************
using AutoMapper;
using B2B.BL.IService;
using B2B.DAL;
using B2B.DAL.IRepository;
using B2B.Model;
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.BL.Service
{
    /// <summary>
    /// Class QuoteSerivce.
    /// </summary>
    public class QuoteService : IQuoteService
    {
        //Create instance of logger for using log4net methods
        private static readonly ILog logger = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        //Flag to check if error level was enabled.
        private static readonly bool isErrorEnabled = logger.IsErrorEnabled;

    }
}
