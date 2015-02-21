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

        IQuoteRepository _quoteRepository;
        /// <summary>
        /// Initializes a new instance of the <see cref="QuoteService"/> class.
        /// </summary>
        /// <param name="quoteRepository">The quote repository.</param>
        public QuoteService(IQuoteRepository quoteRepository)
        {
            _quoteRepository = quoteRepository;
        }

        /// <summary>
        /// Gets the quotes.
        /// </summary>
        /// <param name="loggedUser">The logged user.</param>
        /// <param name="showAll">if set to <c>true</c> [show all].</param>
        /// <returns>List{QuotesModel}.</returns>
        public IEnumerable<QuotesModel> GetQuotes(string loggedUser, bool showAll = false)
        {
            //try
            //{
            //Automapper for converting the source entity to destination entity
            Mapper.CreateMap<SP_SelectQuotes_Result, QuotesModel>();

            var quoteList = _quoteRepository.GetQuotes(loggedUser, showAll).AsEnumerable();
            return Mapper.Map<IEnumerable<SP_SelectQuotes_Result>, IEnumerable<QuotesModel>>(quoteList);
            //}
            //catch (Exception)
            //{
            //    logger.Error("");
            //    throw;
            //}

        }
    }
}
