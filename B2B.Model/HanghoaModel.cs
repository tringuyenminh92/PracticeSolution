using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class HanghoaModel
    {
        public Guid _HanghoaId { get; set; }
        public Nullable<Guid> _NhomHanghoaId { get; set; }
        public Nullable<Guid> _DonviId { get; set; }
        public Nullable<Int32> _Step { get; set; }
        public Nullable<DateTime> _NgayCapnhat { get; set; }
        public Nullable<Double> _Giagoc { get; set; }
        public Nullable<Boolean> _Active { get; set; }
        public Byte[] _Version { get; set; }
        public String _Code { get; set; }
        public String _TenHanghoa { get; set; }
        public String _Barcode { get; set; }
        public String _LinkHinhanh { get; set; }
        public String _Ghichu { get; set; }
    }
}
