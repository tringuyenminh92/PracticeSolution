using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class NhomHanghoaRepository
    {
        B2BSystemEntities dbContext;
        public NhomHanghoaRepository()
        {
            dbContext = new B2BSystemEntities();
        }

        public IQueryable<NhomHanghoa> GetAllNhomHanghoa()
        {
            return dbContext.NhomHanghoas.AsQueryable<NhomHanghoa>();
        }

    }
}
