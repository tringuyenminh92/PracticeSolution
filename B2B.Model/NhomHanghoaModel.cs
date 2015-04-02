using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class NhomHanghoaModel
    {
        public Guid _NhomHanghoaId { get; set; }
        public Nullable<Int32> _Step { get; set; }
        public Nullable<DateTime> _NgayCapnhat { get; set; }
        public Nullable<Boolean> _Active { get; set; }
        public Byte[] _Version { get; set; }
        public String _Code { get; set; }
        public String _TenNhomHanghoa { get; set; }
        public String _Ghichu { get; set; }
    }
}
