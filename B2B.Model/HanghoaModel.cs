using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class HanghoaModel
    {
        public Guid HanghoaId { get; set; }
        public Nullable<Guid> NhomHanghoaId { get; set; }
        public Nullable<Guid> DonviId { get; set; }
        public Nullable<Int32> Step { get; set; }
        public Nullable<DateTime> NgayCapnhat { get; set; }
        public string NgayCapnhatString
        {
            get { return NgayCapnhat.HasValue ? NgayCapnhat.Value.ToShortDateString() : ""; }
            set { NgayCapnhat = DateTime.Parse(value); }
        }
        public Nullable<Double> Giagoc { get; set; }
        public Nullable<Boolean> Active { get; set; }
        public Byte[] Version { get; set; }
        public String Code { get; set; }
        public String TenHanghoa { get; set; }
        public String Barcode { get; set; }
        public String LinkHinhanh { get; set; }
        public String Ghichu { get; set; }
        public String LinkHinhanh_Web { get; set; }
        public HanghoaModel() { HanghoaId = Guid.NewGuid(); }

        public string[] ArrayTag
        {

            get
            {
                if (!string.IsNullOrWhiteSpace(Tags))
                    return Tags.Split(',');
                return null;
            }
            set { if (ArrayTag != null && ArrayTag.Length > 0) Tags = string.Join(",", value); }
        }
        public string Tags { get; set; }
    }
}
