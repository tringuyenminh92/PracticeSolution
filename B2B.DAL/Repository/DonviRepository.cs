using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class DonviRepository
    {
        B2BSystemEntities dbContext;
        public DonviRepository()
        {
            dbContext = new B2BSystemEntities();
        }

        public IQueryable<Donvi> GetDonvi()
        {
            return dbContext.Donvis.AsQueryable<Donvi>();
            //return dbContext.NhomHanghoas.AsQueryable<NhomHanghoa>();
        }
    }
}
