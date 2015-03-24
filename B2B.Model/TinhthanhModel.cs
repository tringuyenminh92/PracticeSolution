using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class TinhthanhModel
    {
        public Guid TinhthanhId { get; set; }
        public Nullable<Guid> KhuvucId { get; set; }
        public Nullable<Int32> Step { get; set; }
        public Nullable<DateTime> NgayCapnhat { get; set; }
        public Nullable<Boolean> Active { get; set; }
        public Byte[] Version { get; set; }
        public String Code { get; set; }
        public String TenTinhthanh { get; set; }
        public String Ghichu { get; set; }
    }
}
