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
    
    public partial class Phieuxuat
    {
        public Phieuxuat()
        {
            this.ChitietPhieuxuats = new HashSet<ChitietPhieuxuat>();
            this.Thuchis = new HashSet<Thuchi>();
            this.TinhtrangPhieuxuats = new HashSet<TinhtrangPhieuxuat>();
        }
    
        public System.Guid PhieuxuatId { get; set; }
        public string Code { get; set; }
        public Nullable<System.Guid> NhanvienLapId { get; set; }
        public Nullable<System.Guid> KhoId { get; set; }
        public Nullable<System.Guid> DonhangId { get; set; }
        public Nullable<System.DateTime> Ngaylap { get; set; }
        public Nullable<System.Guid> NhanvienGiaohangId { get; set; }
        public string TenTinhtrangPhieuxuat { get; set; }
        public Nullable<System.DateTime> NgayCapnhat { get; set; }
        public string Ghichu { get; set; }
        public Nullable<int> Step { get; set; }
        public byte[] Version { get; set; }
        public Nullable<System.Guid> NguyennhanLydo { get; set; }
        public Nullable<System.Guid> TinhtrangPhieuxuatCurrentId { get; set; }
        public Nullable<System.Guid> NhanvienDonhang { get; set; }
        public Nullable<double> Tongtien { get; set; }
    
        public virtual ICollection<ChitietPhieuxuat> ChitietPhieuxuats { get; set; }
        public virtual Donhang Donhang { get; set; }
        public virtual Kho Kho { get; set; }
        public virtual NguyennhanLydo NguyennhanLydo1 { get; set; }
        public virtual Nhanvien Nhanvien { get; set; }
        public virtual Nhanvien Nhanvien1 { get; set; }
        public virtual Nhanvien Nhanvien2 { get; set; }
        public virtual ICollection<Thuchi> Thuchis { get; set; }
        public virtual ICollection<TinhtrangPhieuxuat> TinhtrangPhieuxuats { get; set; }
    }
}
