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
    
    public partial class NguyennhanLydo
    {
        public NguyennhanLydo()
        {
            this.Phieunhaps = new HashSet<Phieunhap>();
            this.Phieuxuats = new HashSet<Phieuxuat>();
        }
    
        public System.Guid NguyennhanLydoId { get; set; }
        public string Code { get; set; }
        public string Noidung { get; set; }
        public Nullable<bool> Active { get; set; }
        public string Ghichu { get; set; }
        public Nullable<int> Step { get; set; }
        public byte[] Version { get; set; }
    
        public virtual ICollection<Phieunhap> Phieunhaps { get; set; }
        public virtual ICollection<Phieuxuat> Phieuxuats { get; set; }
    }
}
