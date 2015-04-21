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
        public string Code { get; set; }
        public Guid? NhanvienId { get; set; }

        public DateTime? Ngaylap { get; set; }

        public string NgaylapString
        {
            get { return Ngaylap.HasValue ? Ngaylap.Value.ToShortDateString() : ""; }
            set
            {
                var saveDate = DateTime.Now;
                DateTime.TryParse(value, out saveDate);
                Ngaylap = saveDate;
            }
        }

        public string TenTinhtrangDonhang { get; set; }
        public Guid? KhoId { get; set; }
        public Guid? KhachhangId { get; set; }
        public DateTime? Ngaygiao { get; set; }
        public string NgaygiaoString
        {
            get { return Ngaygiao.HasValue ? Ngaygiao.Value.ToShortDateString() : ""; }
            set
            {
                var saveDate = DateTime.Now;
                DateTime.TryParse(value, out saveDate);
                Ngaygiao = saveDate;
            }
        }
        public string DiachiGiao { get; set; }
        public string TenTinhthanhGiao { get; set; }
        public string SoDienthoai { get; set; }
        public double Tiengiam { get; set; }

        public double PhantramGiam { get; set; }
        public double Tongtien { get; set; }
        public string Ghichu { get; set; }
        public int LoaiDonhang { get; set; }
        public Guid? NhanvienCapnhatId { get; set; }
        public DateTime? NgayCapnhat { get; set; }

        public string NgayCapnhatString
        {
            get { return NgayCapnhat.HasValue ? NgayCapnhat.Value.ToShortDateString() : ""; }
            set
            {
                var saveDate = DateTime.Now;
                DateTime.TryParse(value, out saveDate);
                NgayCapnhat = saveDate;
            }
        }
        public bool Active { get; set; }
        public Guid? TinhtrangDonhangCurrentId{get;set;}
        //public DonhangModel() { DonhangId = Guid.NewGuid(); }
    }

}
