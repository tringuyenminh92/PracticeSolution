using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL
{
    public class TinhtrangRepository
    {
        B2BSystemEntities dbContext;
        public TinhtrangRepository()
        {
            dbContext = new B2BSystemEntities();
        }
        public Tinhtrang GetTinhtrangTheoCode(string code)
        {
            return dbContext.Tinhtrangs.AsQueryable().Where(tt => tt.Code == code).FirstOrDefault<Tinhtrang>();
        }
    }
}