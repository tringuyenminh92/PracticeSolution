using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class ThuoctinhHanghoaRepository
    {
        B2BSystemEntities dbContext;
        public ThuoctinhHanghoaRepository()
        {
            dbContext = new B2BSystemEntities();
        }
        public IQueryable<ThuoctinhHanghoa> GetThuoctinhHanghoaTheoHanghoa(string hanghoaId)
        {
            return dbContext.ThuoctinhHanghoas.AsQueryable<ThuoctinhHanghoa>().Where(tt => tt.HanghoaId == new Guid(hanghoaId)).OrderBy(tt => tt.TenThuoctinh);
        }
        public bool Delete(string thuoctinhHanghoaId)
        {
            try
            {
                ThuoctinhHanghoa tthh = dbContext.ThuoctinhHanghoas.Find(new Guid(thuoctinhHanghoaId));
                if (tthh != null)
                {
                    dbContext.ThuoctinhHanghoas.Remove(tthh);
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
        public bool Insert(ThuoctinhHanghoa thuoctinhHanghoa)
        {
            try
            {
                dbContext.ThuoctinhHanghoas.Add(thuoctinhHanghoa);
                dbContext.SaveChanges();
                return true;
            }
            catch (System.Exception ex)
            {
                return false;
            }
        }
    }
}
