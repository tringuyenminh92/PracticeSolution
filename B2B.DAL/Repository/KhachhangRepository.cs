using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class KhachhangRepository
    {
        B2BSystemEntities dbContext;
        public KhachhangRepository()
        {
            dbContext = new B2BSystemEntities();
        }
        //public Khachhang GetKhachhangFromAccountId(string accountId)
        //{
        //    return dbContext.Khachhangs.AsQueryable<Khachhang>().Where(u => u.AccountId == new Guid(accountId)).FirstOrDefault<Khachhang>(); 
        //}
        public Tri_GetKhachhangDemo_Result GetKhachhangFromAccountId(string accountId)
        {
            return dbContext.Tri_GetKhachhangDemo().AsQueryable().Where(u => u.AccountId == new Guid(accountId)).FirstOrDefault<Tri_GetKhachhangDemo_Result>();
        }
        public bool Insert(Khachhang khachhang)
        {
            try
            {
                dbContext.Khachhangs.Add(khachhang);
                dbContext.SaveChanges();
                return true;
            }
            catch (System.Exception ex)
            {
                return false;
            }
        }

        public bool Update(Khachhang khachhang)
        {
            try
            {
                Khachhang kh = dbContext.Khachhangs.Find(khachhang.KhachhangId);
                if (kh != null)
                {
                    dbContext.Entry(kh).CurrentValues.SetValues(khachhang);
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
