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
    
    public partial class ChitietKiemke
    {
        public System.Guid ChitietKiemkeId { get; set; }
        public Nullable<System.Guid> KiemkeId { get; set; }
        public Nullable<System.Guid> HanghoaId { get; set; }
        public string TenHanghoa { get; set; }
        public Nullable<int> SoluongTon { get; set; }
        public Nullable<int> SoluongThuc { get; set; }
        public string Ghichu { get; set; }
        public Nullable<int> Step { get; set; }
        public byte[] Version { get; set; }
    }
}