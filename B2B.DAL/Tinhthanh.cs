//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace B2B.DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class Tinhthanh
    {
        public Tinhthanh()
        {
            this.Khachhangs = new HashSet<Khachhang>();
            this.Khoes = new HashSet<Kho>();
            this.NhaCungcaps = new HashSet<NhaCungcap>();
            this.Nhanviens = new HashSet<Nhanvien>();
            this.Quanhuyens = new HashSet<Quanhuyen>();
        }
    
        public System.Guid TinhthanhId { get; set; }
        public string Code { get; set; }
        public string TenTinhthanh { get; set; }
        public string Ghichu { get; set; }
        public Nullable<bool> Active { get; set; }
        public Nullable<int> Step { get; set; }
        public byte[] Version { get; set; }
        public Nullable<System.Guid> KhuvucId { get; set; }
        public Nullable<System.DateTime> NgayCapnhat { get; set; }
    
        public virtual ICollection<Khachhang> Khachhangs { get; set; }
        public virtual ICollection<Kho> Khoes { get; set; }
        public virtual Khuvuc Khuvuc { get; set; }
        public virtual ICollection<NhaCungcap> NhaCungcaps { get; set; }
        public virtual ICollection<Nhanvien> Nhanviens { get; set; }
        public virtual ICollection<Quanhuyen> Quanhuyens { get; set; }
    }
}
