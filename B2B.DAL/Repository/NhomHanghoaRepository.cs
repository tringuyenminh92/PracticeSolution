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

        public IQueryable<Vinh_GetNhomHanghoaActive_Result> GetNhomHanghoaActive()
        {
            return dbContext.Vinh_GetNhomHanghoaActive().AsQueryable<Vinh_GetNhomHanghoaActive_Result>().OrderBy(nhh => nhh.TenNhomHanghoa);
            //return dbContext.NhomHanghoas.AsQueryable<NhomHanghoa>();
        }

        public IQueryable<NhomHanghoa> GetNhomHanghoa()
        {
            return dbContext.NhomHanghoas.AsQueryable<NhomHanghoa>();
            //return dbContext.NhomHanghoas.AsQueryable<NhomHanghoa>();
        } 
    }
}
