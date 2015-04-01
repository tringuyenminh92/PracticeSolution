using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class DSHanghoaReponsitory
    {
        B2BSystemEntities _BSE;
        public DSHanghoaReponsitory()
        {
            _BSE = new B2BSystemEntities();
        }
        //Get Hang hoa theo nhom hang hoa
        public IQueryable<Khuyen_GetHanghoaTheoNhom_Result>GetDSHanghoaTheoNhomHanghoa( Guid? nhomHanghoa)
        {
            return (IQueryable<Khuyen_GetHanghoaTheoNhom_Result>)_BSE.Khuyen_GetHanghoaTheoNhom(nhomHanghoa).AsQueryable();
        }
        //get Nhom hang hoa
        public IQueryable<NhomHanghoa>GetNhomHanghoa()
        {
            return _BSE.NhomHanghoas.AsQueryable();
        }
    }
}
