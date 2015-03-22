using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace B2B.Model
{
    public class KhachhangModel
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Passnhaplai { get; set; }
        public Guid _KhachhangId { get; set; }
        public Nullable<Guid> _QuanhuyenId { get; set; }
        public Nullable<Guid> _TinhthanhId { get; set; }
        public Nullable<Guid> _NhomKhachhangId { get; set; }
        public Nullable<Int32> _ThoigianCongno { get; set; }
        public Nullable<Int32> _ToahangCongno { get; set; }
        public Nullable<Int32> _Step { get; set; }
        public Nullable<DateTime> _Ngaysinh { get; set; }
        public Nullable<DateTime> _NgayCapnhat { get; set; }
        public Nullable<Double> _HanmucCongno { get; set; }
        public Nullable<Boolean> _Gioitinh { get; set; }
        public Nullable<Boolean> _Active { get; set; }
        public Byte[] _Version { get; set; }
        public String _Code { get; set; }
        public String _HotenKhachhang { get; set; }
        public String _CMND { get; set; }
        public String _Diachi { get; set; }
        public String _DiachiGiaohang { get; set; }
        public String _Linkanh { get; set; }
        public String _Ghichu { get; set; }
        public String _Mobile { get; set; }
        public String _Fax { get; set; }
        public String _MasoThue { get; set; }
        public String _TenTaikhoan { get; set; }
        public String _SoTaikhoan { get; set; }
        public String _Nganhang { get; set; }
        public String _Congty { get; set; }
        public String _Chucvu { get; set; }
        public String _Email { get; set; }
        public String _DiachiCongty { get; set; }
        public String _PhoneCongty { get; set; }
        public String _Tel { get; set; }
    }
}
