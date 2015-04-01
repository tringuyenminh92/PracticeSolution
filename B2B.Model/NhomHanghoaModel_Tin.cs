using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class NhomHanghoaModel_Tin
    {
        private Guid _NhomHanghoaId;

        public Guid NhomHanghoaId
        {
            get { return _NhomHanghoaId; }
            set { _NhomHanghoaId = value; }
        }
        private Nullable<Int32> _Step;

        public Nullable<Int32> Step
        {
            get { return _Step; }
            set { _Step = value; }
        }
        private Nullable<DateTime> _NgayCapnhat;

        public Nullable<DateTime> NgayCapnhat
        {
            get { return _NgayCapnhat; }
            set { _NgayCapnhat = value; }
        }
        private Nullable<Boolean> _Active;

        public Nullable<Boolean> Active
        {
            get { return _Active; }
            set { _Active = value; }
        }
        private Byte[] _Version;

        public Byte[] Version
        {
            get { return _Version; }
            set { _Version = value; }
        }
        private String _Code;

        public String Code
        {
            get { return _Code; }
            set { _Code = value; }
        }
        private String _TenNhomHanghoa;

        public String TenNhomHanghoa
        {
            get { return _TenNhomHanghoa; }
            set { _TenNhomHanghoa = value; }
        }
        private String _Ghichu;

        public String Ghichu
        {
            get { return _Ghichu; }
            set { _Ghichu = value; }
        }
    }
}
