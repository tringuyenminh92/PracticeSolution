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
        public IQueryable<Hanghoa> GetHanghoa()
        {
            return dbContext.Hanghoas.AsQueryable<Hanghoa>();
        }
        public IQueryable<Hanghoa> GetHanghoaTheoNhomHanghoa(NhomHanghoa nhomHanghoa)
        {
            if (nhomHanghoa.NhomHanghoaId != new Guid("00000000-0000-0000-0000-000000000000"))
            {
                return dbContext.Hanghoas.AsQueryable<Hanghoa>().Where(h => h.NhomHanghoaId == nhomHanghoa.NhomHanghoaId);
            }
            else
            {
                return GetHanghoa();
            }
        }
        public IQueryable<Hanghoa> GetHanghoaActiveTheoNhomHanghoa(NhomHanghoa nhomHanghoa)
        {
            return dbContext.Hanghoas.AsQueryable<Hanghoa>().Where(h => h.NhomHanghoaId == nhomHanghoa.NhomHanghoaId ).Where(h=>h.Active == true);
         
        }
    }
}
