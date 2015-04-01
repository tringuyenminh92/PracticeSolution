using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class HanghoaModel_Tin
    {
        private Guid _HanghoaId;

        public Guid HanghoaId
        {
            get { return _HanghoaId; }
            set { _HanghoaId = value; }
        }
        private Nullable<Guid> _NhomHanghoaId;

        public Nullable<Guid> NhomHanghoaId
        {
            get { return _NhomHanghoaId; }
            set { _NhomHanghoaId = value; }
        }
        private Nullable<Guid> _DonviId;

        public Nullable<Guid> DonviId
        {
            get { return _DonviId; }
            set { _DonviId = value; }
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
        private Nullable<Double> _Giagoc;

        public Nullable<Double> Giagoc
        {
            get { return _Giagoc; }
            set { _Giagoc = value; }
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
        private String _TenHanghoa;

        public String TenHanghoa
        {
            get { return _TenHanghoa; }
            set { _TenHanghoa = value; }
        }
        private String _Barcode;

        public String Barcode
        {
            get { return _Barcode; }
            set { _Barcode = value; }
        }
        private String _LinkHinhanh;

        public String LinkHinhanh
        {
            get { return _LinkHinhanh; }
            set { _LinkHinhanh = value; }
        }
        private String _Ghichu;

        public String Ghichu
        {
            get { return _Ghichu; }
            set { _Ghichu = value; }
        }
        //_________________Designer__________
        public string TenNhomhanghoa { get; set; }
        public string TenDonVi { get; set; }
        public double? Dongia { get; set; }
        public double? GiaHienthi
        {
            get
            {
                if (Dongia == null)
                {
                    return Giagoc;
                }
                return Dongia;
            }
            set { Dongia = value; }
        }

        public int SoluongTonHienthi { get; set; }

        public int SoluongKhachmua { get; set; }

        public float? TiengiamHienthi { get; set; }

        public float? PhantramVAT { get; set; }

        public float? PhantramGiam { get; set; }

    }
}
