using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.IRepository
{
    public interface IQuoteRepository
    {
        IQueryable<SP_SelectQuotes_Result> GetQuotes(string loggedUser, bool showAll);
    }
}
