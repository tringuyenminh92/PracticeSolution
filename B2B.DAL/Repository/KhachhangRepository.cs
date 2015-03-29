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
    }
}
