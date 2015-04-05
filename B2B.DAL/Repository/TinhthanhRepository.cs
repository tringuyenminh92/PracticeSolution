using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class TinhthanhRepository
    {
        B2BSystemEntities dbContext;
        public TinhthanhRepository() { dbContext = new B2BSystemEntities(); }

        public IQueryable<Tri_GetTinhthanhActive_Result> GetTinhthanhActive()
        {
            return dbContext.Tri_GetTinhthanhActive().OrderBy(t=>t.TenTinhthanh).AsQueryable();
        }

    }
}
