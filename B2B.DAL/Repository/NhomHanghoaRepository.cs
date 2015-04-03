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

        public IQueryable<Vinh_GetNhomHanghoaActive_Result> GetNhomHanghoa()
        {
            return dbContext.Vinh_GetNhomHanghoaActive().AsQueryable<Vinh_GetNhomHanghoaActive_Result>();
            //return dbContext.NhomHanghoas.AsQueryable<NhomHanghoa>();
        }

    }
}
