using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace B2B.Model
{
    public class KhachhangModel
    {
        public Guid KhachhangId { get; set; }
        public Nullable<Guid> QuanhuyenId { get; set; }
        public Nullable<Guid> TinhthanhId { get; set; }
        public Nullable<Guid> AccountId { get; set; }
        public Nullable<Guid> NhomKhachhangId { get; set; }
        public Nullable<Int32> ThoigianCongno { get; set; }
        public Nullable<Int32> ToahangCongno { get; set; }
        public Nullable<Int32> Step { get; set; }

        public Nullable<DateTime> Ngaysinh { get; set; }
        public string NgaysinhString
        {
            get { return Ngaysinh.HasValue ? Ngaysinh.Value.ToShortDateString() : ""; }
            set { Ngaysinh = DateTime.Parse(value); }
        }
        public Nullable<DateTime> NgayCapnhat { get; set; }
        public Nullable<Double> HanmucCongno { get; set; }
        public Nullable<Boolean> Gioitinh { get; set; }
        public Nullable<Boolean> Active { get; set; }
        public Byte[] Version { get; set; }
        public String Code { get; set; }
        public String HotenKhachhang { get; set; }
        public String CMND { get; set; }
        public String Diachi { get; set; }
        public String DiachiGiaohang { get; set; }
        public String Linkanh { get; set; }
        public String Ghichu { get; set; }
        public String Mobile { get; set; }
        public String Fax { get; set; }
        public String MasoThue { get; set; }
        public String TenTaikhoan { get; set; }
        public String SoTaikhoan { get; set; }
        public String Nganhang { get; set; }
        public String Congty { get; set; }
        public String Chucvu { get; set; }
        public String Email { get; set; }
        public String DiachiCongty { get; set; }
        public String PhoneCongty { get; set; }
        public String Tel { get; set; }
        public String TenTinhthanh { get; set; }
        public String TenQuanhuyen { get; set; }
        public KhachhangModel() { KhachhangId = Guid.NewGuid(); }
    }
}
