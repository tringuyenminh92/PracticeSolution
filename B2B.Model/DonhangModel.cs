using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class DonhangModel
    {
        public Guid DonhangId { get; set; }
        public Nullable<Guid> NhanvienId { get; set; }
        public Nullable<Guid> KhoId { get; set; }
        public Nullable<Guid> KhachhangId { get; set; }
        public Nullable<Guid> NhanvienCapnhatId { get; set; }
        public Nullable<Guid> TinhtrangDonhangCurrentId { get; set; }
        public Nullable<Int32> LoaiDonhang { get; set; }
        public Nullable<Int32> Step { get; set; }
        public Nullable<DateTime> Ngaylap { get; set; }
        public Nullable<DateTime> Ngaygiao { get; set; }
        public Nullable<DateTime> NgayCapnhat { get; set; }
        public Nullable<DateTime> HanDonhang { get; set; }
        public Nullable<Double> Tiengiam { get; set; }
        public Nullable<Double> PhantramGiam { get; set; }
        public Nullable<Double> Tongtien { get; set; }
        public Byte[] Version { get; set; }
        public String Code { get; set; }
        public String TenTinhtrangDonhang { get; set; }
        public String DiachiGiao { get; set; }
        public String TenTinhthanhGiao { get; set; }
        public String TenQuanhuyenGiao { get; set; }
        public String SoDienthoai { get; set; }
        public String Ghichu { get; set; }
    }
}
