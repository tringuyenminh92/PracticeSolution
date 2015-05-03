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
    
    public partial class Phieunhap
    {
        public Phieunhap()
        {
            this.ChitietPhieunhaps = new HashSet<ChitietPhieunhap>();
            this.Thuchis = new HashSet<Thuchi>();
            this.TinhtrangPhieunhaps = new HashSet<TinhtrangPhieunhap>();
        }
    
        public System.Guid PhieunhapId { get; set; }
        public string Code { get; set; }
        public Nullable<System.Guid> NhanvienId { get; set; }
        public Nullable<System.Guid> KhoId { get; set; }
        public Nullable<System.Guid> NhacungcapId { get; set; }
        public Nullable<System.DateTime> Ngaylap { get; set; }
        public string Ghichu { get; set; }
        public Nullable<int> Step { get; set; }
        public byte[] Version { get; set; }
        public Nullable<System.Guid> NguyennhanLydo { get; set; }
        public Nullable<double> Tongtien { get; set; }
        public Nullable<System.Guid> TinhtrangPhieunhapCurrentId { get; set; }
    
        public virtual ICollection<ChitietPhieunhap> ChitietPhieunhaps { get; set; }
        public virtual Kho Kho { get; set; }
        public virtual NguyennhanLydo NguyennhanLydo1 { get; set; }
        public virtual NhaCungcap NhaCungcap { get; set; }
        public virtual Nhanvien Nhanvien { get; set; }
        public virtual ICollection<Thuchi> Thuchis { get; set; }
        public virtual ICollection<TinhtrangPhieunhap> TinhtrangPhieunhaps { get; set; }
    }
}
