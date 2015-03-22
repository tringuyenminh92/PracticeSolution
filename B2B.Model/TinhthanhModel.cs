using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class TinhthanhModel
    {
        public Guid _TinhthanhId { get; set; }
        public Nullable<Guid> _KhuvucId { get; set; }
        public Nullable<Int32> _Step { get; set; }
        public Nullable<DateTime> _NgayCapnhat { get; set; }
        public Nullable<Boolean> _Active { get; set; }
        public Byte[] _Version { get; set; }
        public String _Code { get; set; }
        public String _TenTinhthanh { get; set; }
        public String _Ghichu { get; set; }
    }
}
