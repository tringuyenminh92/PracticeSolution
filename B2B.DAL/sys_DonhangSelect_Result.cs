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
    
    public partial class sys_DonhangSelect_Result
    {
        public System.Guid DonhangId { get; set; }
        public string Code { get; set; }
        public Nullable<System.Guid> NhanvienId { get; set; }
        public Nullable<System.DateTime> Ngaylap { get; set; }
        public string TenTinhtrangDonhang { get; set; }
        public Nullable<System.Guid> KhoId { get; set; }
        public Nullable<System.Guid> KhachhangId { get; set; }
        public Nullable<System.DateTime> Ngaygiao { get; set; }
        public string DiachiGiao { get; set; }
        public string TenTinhthanhGiao { get; set; }
        public string TenQuanhuyenGiao { get; set; }
        public string SoDienthoai { get; set; }
        public Nullable<double> Tiengiam { get; set; }
        public Nullable<double> PhantramGiam { get; set; }
        public Nullable<double> Tongtien { get; set; }
        public string Ghichu { get; set; }
        public Nullable<int> LoaiDonhang { get; set; }
        public Nullable<System.Guid> NhanvienCapnhatId { get; set; }
        public Nullable<System.DateTime> NgayCapnhat { get; set; }
        public Nullable<int> Step { get; set; }
        public byte[] Version { get; set; }
        public Nullable<System.DateTime> HanDonhang { get; set; }
        public Nullable<bool> Active { get; set; }
        public Nullable<System.Guid> TinhtrangDonhangCurrentId { get; set; }
    }
}
