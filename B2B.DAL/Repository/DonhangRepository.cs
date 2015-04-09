using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class DonhangRepository
    {
          B2BSystemEntities _BSE;
          public DonhangRepository()
        {
            _BSE = new B2BSystemEntities();
        }
        public IQueryable<Tri_GetDonhangTheoThang_Result> GetDonhangsByMonth(DateTime ngaylap,int loaiDonhang)
        {
            return _BSE.Tri_GetDonhangTheoThang(ngaylap,loaiDonhang).AsQueryable();
        }


    }
}
