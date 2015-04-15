using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class ChitietDonhangModel
    {
        public Guid ChitietDonhangId { get; set; }
        public Nullable<Guid> DonhangId { get; set; }
        public Nullable<Guid> HanghoaId { get; set; }
        public Nullable<Int32> Soluong { get; set; }
        public Nullable<Int32> SoluongGiao { get; set; }
        public Nullable<Int32> SoluongConlai { get; set; }
        public Nullable<Int32> Step { get; set; }
        public Nullable<DateTime> NgayCapnhat { get; set; }
        public Nullable<Double> Giaban { get; set; }
        public Nullable<Double> VAT { get; set; }
        public Nullable<Double> Tiengiam { get; set; }
        public Nullable<Double> PhantramGiam { get; set; }
        public Nullable<Double> Thanhtien { get; set; }
        public Byte[] Version { get; set; }
        public String TenHanghoa { get; set; }
        public String GhichuTrahang { get; set; }
        public int STT { get; set; }
        public String Code { get; set; }
        public ChitietDonhangModel() { ChitietDonhangId = Guid.NewGuid(); }
    }
}
