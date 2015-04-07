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
        public IQueryable<Hanghoa> GetHanghoaTheoNhomHanghoa(string nhomHanghoaId)
        {
            return dbContext.Hanghoas.AsQueryable<Hanghoa>().Where(h => h.NhomHanghoaId == new Guid(nhomHanghoaId));
        }
        public IQueryable<Hanghoa> GetHanghoaActiveTheoNhomHanghoa(NhomHanghoa nhomHanghoa)
        {
            return dbContext.Hanghoas.AsQueryable<Hanghoa>().Where(h => h.NhomHanghoaId == nhomHanghoa.NhomHanghoaId ).Where(h=>h.Active == true);
        }
        public bool Delete(string hanghoaId)
        {
            try
            {
                Hanghoa hh = dbContext.Hanghoas.Find(new Guid(hanghoaId));
                if (hh != null)
                {
                    dbContext.Hanghoas.Remove(hh);
                    dbContext.SaveChanges();
                    return true;
                }
                return false;
            }
            catch (System.Exception ex)
            {
                return false;
            }
        }
        public bool Insert(Hanghoa hanghoa)
        {
            try
            {
                dbContext.Hanghoas.Add(hanghoa);
                dbContext.SaveChanges();
                return true;
            }
            catch (System.Exception ex)
            {
                return false;
            }
        }
        public bool Update(Hanghoa hanghoa)
        {
            try
            {
                Hanghoa hh = dbContext.Hanghoas.Find(hanghoa.HanghoaId);
                if (hh != null)
                {
                    dbContext.Entry(hh).CurrentValues.SetValues(hanghoa);
                    dbContext.SaveChanges();
                    return true;
                }
                return false;
            }
            catch (System.Exception ex)
            {
                return false;
            }
        }
    }
}
