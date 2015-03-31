using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class NhomHanghoaModel
    {
        public string NhomHanghoaId { get; set; }
        public string Code { get; set; }
        public string TenNhomHanghoa { get; set; }
        public string Ghichu { get; set; }
        public bool Active { get; set; }
        public int Step { get; set; }
        public DateTime NgayCapnhat { get; set; }
    }
}
