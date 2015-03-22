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
        public void Insert(sys_KhachhangSelect_Result khachhangModel)
        {
            dbContext.sys_KhachhangInsert(khachhangModel.KhachhangId, khachhangModel.QuanhuyenId, khachhangModel.TinhthanhId, khachhangModel.NhomKhachhangId,
                khachhangModel.ThoigianCongno, khachhangModel.ToahangCongno, khachhangModel.Step, khachhangModel.Ngaysinh, khachhangModel.NgayCapnhat, khachhangModel.HanmucCongno,
                khachhangModel.Gioitinh, khachhangModel.Active, khachhangModel.Code, khachhangModel.HotenKhachhang, khachhangModel.CMND, khachhangModel.Diachi,
                khachhangModel.DiachiGiaohang, khachhangModel.Linkanh, khachhangModel.Ghichu, khachhangModel.Mobile, khachhangModel.Fax, khachhangModel.MasoThue, khachhangModel.TenTaikhoan,
                khachhangModel.SoTaikhoan, khachhangModel.Nganhang, khachhangModel.Congty, khachhangModel.Chucvu, khachhangModel.Email, khachhangModel.DiachiCongty,
                khachhangModel.PhoneCongty, khachhangModel.Tel, null);
        }
    }
}
