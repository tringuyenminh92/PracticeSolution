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
    
    public partial class User
    {
        public System.Guid UserId { get; set; }
        public string C_Username { get; set; }
        public string C_Password { get; set; }
        public Nullable<System.Guid> NhanvienId { get; set; }
        public Nullable<bool> Active { get; set; }
        public Nullable<int> Step { get; set; }
        public byte[] Version { get; set; }
    
        public virtual Nhanvien Nhanvien { get; set; }
    }
}
