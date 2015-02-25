using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.BL.IService
{
    public interface IQuoteService
    {
       IEnumerable<QuotesModel> GetQuotes(string loggedUser, bool showAll = false);
    }
}
