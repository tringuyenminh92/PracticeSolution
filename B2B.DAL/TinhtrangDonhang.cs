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
    
    public partial class TinhtrangDonhang
    {
        public System.Guid TinhtrangDonhangId { get; set; }
        public Nullable<System.Guid> DonhangId { get; set; }
        public Nullable<System.Guid> PhieuxuatId { get; set; }
        public Nullable<System.DateTime> NgayCapnhat { get; set; }
        public Nullable<System.Guid> NhanvienCapnhatId { get; set; }
        public string Ghichu { get; set; }
        public byte[] Version { get; set; }
        public Nullable<System.Guid> TinhtrangId { get; set; }
    
        public virtual Donhang Donhang { get; set; }
        public virtual Nhanvien Nhanvien { get; set; }
        public virtual Tinhtrang Tinhtrang { get; set; }
    }
}
