using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class TinhtrangDonhangModel
    {
        public Guid TinhtrangDonhangId { get; set; }
        public Nullable<Guid> DonhangId { get; set; }
        public Nullable<Guid> TinhtrangId { get; set; }
        public Nullable<Guid> NhanvienCapnhatId { get; set; }
        public Nullable<DateTime> NgayCapnhat { get; set; }
        public Byte[] Version { get; set; }
        public String Ghichu { get; set; }
        public TinhtrangDonhangModel() { TinhtrangDonhangId = Guid.NewGuid(); }
    }
}
