using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class QuanhuyenModel
    {
        public Guid _QuanhuyenId;
        public Nullable<Guid> _TinhthanhId;
        public Nullable<Int32> _Step;
        public Nullable<DateTime> _NgayCapnhat;
        public Nullable<Boolean> _Active;
        public Byte[] _Version;
        public String _Code;
        public String _TenQuanhuyen;
        public String _Ghichu;
    }
}
