using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class DonhangRepository
    {
          B2BSystemEntities _BSE;
          public DonhangRepository()
        {
            _BSE = new B2BSystemEntities();
        }
        public IQueryable<Donhang> GetDonhang()
          {
              return _BSE.Donhangs.AsQueryable<Donhang>().OrderByDescending(dh => dh.Ngaylap);
          }
        public IQueryable<Tri_GetDonhangTheoThang_Result> GetDonhangsByMonth(DateTime ngaylap,int loaiDonhang)
        {
            return _BSE.Tri_GetDonhangTheoThang(ngaylap,loaiDonhang).AsQueryable();
        }
        public bool Insert(Donhang donhang)
        {
            //try
            //{
                _BSE.Donhangs.Add(donhang);
                _BSE.SaveChanges();
                return true;
        //    }
        //    catch (System.Exception ex)
        //    {
        //        return false;
        //    }
        }

        public bool Update(Donhang donhang)
        {
            try
            {
                Donhang dh = _BSE.Donhangs.Find(donhang.DonhangId);
                if (dh != null)
                {
                    _BSE.Entry(dh).CurrentValues.SetValues(donhang);
                    _BSE.SaveChanges();
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
