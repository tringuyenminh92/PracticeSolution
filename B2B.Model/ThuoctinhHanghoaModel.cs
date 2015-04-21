using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class ThuoctinhHanghoaModel
    {
        public Guid ThuoctinhHanghoaId { get; set; }
        public Nullable<Guid> HanghoaId { get; set; }
        public Nullable<Int32> Step { get; set; }
        public Nullable<DateTime> NgayCapnhat { get; set; }
        public Nullable<Boolean> Active { get; set; }
        public Byte[] Version { get; set; }
        public String Code { get; set; }
        public String TenThuoctinh { get; set; }
        public String Ghichu { get; set; }
        public ThuoctinhHanghoaModel() { ThuoctinhHanghoaId = Guid.NewGuid(); }
    }
}
