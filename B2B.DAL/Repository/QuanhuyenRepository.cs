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
        public IQueryable<Tri_GetQuanhuyenActive_Result> GetQuanhuyenActive()
        {
            return dbContext.Tri_GetQuanhuyenActive().OrderBy(q => q.TenQuanhuyen).AsQueryable();
        }

        public IQueryable<Tri_GetQuanhuyenActiveTheoTinhthanh_Result> GetQuanhuyenActiveTheoTinhthanh(string tinhthanhId)
        {
            return dbContext.Tri_GetQuanhuyenActiveTheoTinhthanh(new Guid(tinhthanhId)).OrderBy(q => q.TenQuanhuyen).AsQueryable();
        }
    }
}
