using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class DonviModel
    {
        public Guid DonviId { get; set; }
        public Nullable<Int32> Step { get; set; }
        public Nullable<DateTime> NgayCapnhat { get; set; }
        public Nullable<Boolean> Active { get; set; }
        public Byte[] Version { get; set; }
        public String Code { get; set; }
        public String TenDonvi { get; set; }
        public String Ghichu { get; set; }
    }
}
