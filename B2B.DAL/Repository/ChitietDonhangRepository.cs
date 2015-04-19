using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class ChitietDonhangRepository
    {
        B2BSystemEntities dbContext;
        public ChitietDonhangRepository()
        {
            dbContext = new B2BSystemEntities();
        }
        public IQueryable<ChitietDonhang> GetChitietDonhangTheoDonhang(string donhangId)
        {
            return dbContext.ChitietDonhangs.AsQueryable<ChitietDonhang>().Where(ctdh => ctdh.DonhangId == new Guid(donhangId)).OrderBy(ctdh => ctdh.TenHanghoa);
        }
        public bool Insert(ChitietDonhang chitietdonhang)
        {
            try
            {
                dbContext.ChitietDonhangs.Add(chitietdonhang);
                dbContext.SaveChanges();
                return true;
            }
            catch (System.Exception ex)
            {
                return false;
            }
        }

        public bool Update(ChitietDonhang chitietdonhang)
        {
            try
            {
                ChitietDonhang ctdh = dbContext.ChitietDonhangs.Find(chitietdonhang.ChitietDonhangId);
                if (ctdh != null)
                {
                    dbContext.Entry(ctdh).CurrentValues.SetValues(chitietdonhang);
                    dbContext.SaveChanges();
                    return true;
                }
                return false;
            }
            catch (System.Exception)
            {
                return false;
            }
        }
    }
}
