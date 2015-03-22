using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class QuanhuyenRepository
    {
        B2BSystemEntities dbContext;
        public QuanhuyenRepository()
        {
            dbContext = new B2BSystemEntities();
        }
        public IQueryable<Tri_GetQuanhuyenActive_Result> GetQuanhuyen()
        {
            return dbContext.Tri_GetQuanhuyenActive().AsQueryable();
        }
    }
}
