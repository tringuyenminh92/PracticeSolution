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
    
    public partial class sys_KhoSelect_Result
    {
        public System.Guid KhoId { get; set; }
        public string Code { get; set; }
        public string TenKho { get; set; }
        public string Diachi { get; set; }
        public Nullable<System.Guid> QuanhuyenId { get; set; }
        public Nullable<System.Guid> TinhthanhId { get; set; }
        public string Ghichu { get; set; }
        public Nullable<System.DateTime> NgayCapnhat { get; set; }
        public Nullable<bool> Active { get; set; }
        public Nullable<int> Step { get; set; }
        public byte[] Version { get; set; }
    }
}