using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class HanghoaRepository
    {
        B2BSystemEntities dbContext;
        public HanghoaRepository()
        {
            dbContext = new B2BSystemEntities();
        }
        public IQueryable<Hanghoa> GetAllHanghoa()
        {
            return dbContext.Hanghoas.AsQueryable<Hanghoa>();
        }
    }
}
