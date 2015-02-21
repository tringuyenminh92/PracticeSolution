// ***********************************************************************
// Assembly         : B2B.DAL
// Author           : Ga9286
// Created          : 23-01-2015
//
// Last Modified By : Ga9286
// Last Modified On : 23-01-2015
// ***********************************************************************
using B2B.DAL.IRepository;
using log4net;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{

    /// <summary>
    /// Class QuoteRepository.
    /// </summary>
    public class QuoteRepository:IQuoteRepository
    {
        //Create instance of logger for using log4net methods
        private static readonly ILog logger = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        //Flag to check if error level was enabled.
        private static readonly bool isErrorEnabled = logger.IsErrorEnabled;

        QuoteSystemEntities _QSE = new QuoteSystemEntities();
        /// <summary>
        /// Gets the quotes.
        /// </summary>
        /// <param name="loggedUser">The logged user.</param>
        /// <param name="showAll">if set to <c>true</c> [show all].</param>
        /// <returns>List{SP_SelectQuotes_Result}.</returns>
        public IQueryable<SP_SelectQuotes_Result> GetQuotes(string loggedUser, bool showAll)
        {
            //try
            //{
                    if (showAll) loggedUser = "%%";
                    return _QSE.SP_SelectQuotes(" ").AsQueryable();
            //}
            //catch (Exception)
            //{
            //    logger.Error("");
            //    throw;
            //}
        }

    }
}
