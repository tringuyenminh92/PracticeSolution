USE [QLBH_08_2014]
GO
create proc [dbo].[Khuyen_GetDonhangTungayDenngay]
	@Tungay datetime,
	@Denngay datetime
as
begin

	select d.DonhangId
      ,d.Code
      ,d.NhanvienId
      ,d.Ngaylap
      ,d.TenTinhtrangDonhang
      ,d.KhoId
      ,d.KhachhangId
      ,d.Ngaygiao
      ,d.DiachiGiao
      ,d.TenQuanhuyenGiao
      ,d.TenTinhthanhGiao
      ,d.SoDienthoai
      ,d.Tiengiam
      ,d.PhantramGiam
      ,d.Tongtien
      ,d.Ghichu
      ,d.LoaiDonhang
      ,d.NhanvienCapnhatId
      ,d.NgayCapnhat
      ,d.Step
      ,d.Version
	  ,n.HovatenNhanvien as TenNhanvienLap
	  ,nv.HovatenNhanvien as TenNhanvienCapnhat
	  ,k.HotenKhachhang as TenKhachhang
	from Donhang d left join Nhanvien n on d.NhanvienId=n.NhanvienId
				left join Nhanvien nv on d.NhanvienCapnhatId=nv.NhanvienId
				left join Khachhang k on d.KhachhangId=k.KhachhangId
	where CAST(d.Ngaylap as DATE) BETWEEN @Tungay AND @Denngay
end
	
