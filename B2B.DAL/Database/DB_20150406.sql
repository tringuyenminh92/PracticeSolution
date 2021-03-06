USE [master]
GO
/****** Object:  Database [QLBH_08_2014]    Script Date: 06/04/2015 12:46:30 PM ******/
CREATE DATABASE [QLBH_08_2014]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLBH_08_2014', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\QLBH_08_2014.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QLBH_08_2014_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\QLBH_08_2014_log.ldf' , SIZE = 24384KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QLBH_08_2014] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLBH_08_2014].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLBH_08_2014] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QLBH_08_2014] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLBH_08_2014] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLBH_08_2014] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLBH_08_2014] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLBH_08_2014] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET RECOVERY FULL 
GO
ALTER DATABASE [QLBH_08_2014] SET  MULTI_USER 
GO
ALTER DATABASE [QLBH_08_2014] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLBH_08_2014] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLBH_08_2014] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLBH_08_2014] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QLBH_08_2014]
GO
/****** Object:  StoredProcedure [dbo].[Khuyen_GetBaogiaTheoNhomKhachhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Khuyen_GetBaogiaTheoNhomKhachhang]
@NhomKhachhangId uniqueidentifier
as
	select  h.HanghoaId,
	h.Code,
	h.TenHanghoa,
	h.NhomHanghoaId,
	h.Giagoc,
	h.Barcode,
	h.DonviId,
	h.LinkHinhanh,
	h.Ghichu,
	h.Active,
	h.Step,
	h.Version,
	h.NgayCapnhat,
	dv.TenDonvi as TenDonvi,
	d.Dongia as DonGia
	from Hanghoa h 
				left join Donvi dv on h.DonviId = dv.DonviId
				left join 
					( select * from Dongia where Dongia.NhomKhachhangId = @NhomKhachhangId
					and Dongia.ApdungTu <= GETDATE())
					d on d.HanghoaId = h.HanghoaId
	where h.Active = 1

GO
/****** Object:  StoredProcedure [dbo].[Khuyen_GetCongnoXuat]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Khuyen_GetCongnoXuat]
as
begin
	select cn.[CongnoXuatId]
      ,cn.[KhachhangId]
      ,cn.[Dienthoai]
      ,cn.[Diachi]
      ,cn.[NgayGiaodich]
      ,cn.[SoduTruocGiaodich]
      ,cn.[SotienGiaodich]
      ,cn.[Tongno]
      ,cn.[NgayhenTra]
      ,cn.[NhanvienId]
      ,cn.[Ghichu]
      ,cn.[Step]
      ,cn.[Version]
	  ,A.HotenKhachhang
	  ,nv.HovatenNhanvien
	from (select k.HotenKhachhang, (select top 1 c.[CongnoXuatId]
									from CongnoXuat c 
									where c.KhachhangId = k.KhachhangId 
									order by year(c.NgayGiaodich) desc, month(c.NgayGiaodich) desc, day(c.NgayGiaodich) desc) as CNXId
	from Khachhang k) as A left join CongnoXuat cn on A.CNXId = cn.CongnoXuatId left join Nhanvien nv on cn.NhanvienId = nv.NhanvienId
end
GO
/****** Object:  StoredProcedure [dbo].[Khuyen_GetCongnoXuatMoinhatTheoKhachhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Khuyen_GetCongnoXuatMoinhatTheoKhachhang]
@KhachhangId uniqueidentifier
as
begin
	select cn.[CongnoXuatId]
      ,cn.[KhachhangId]
      ,cn.[Dienthoai]
      ,cn.[Diachi]
      ,cn.[NgayGiaodich]
      ,cn.[SoduTruocGiaodich]
      ,cn.[SotienGiaodich]
      ,cn.[Tongno]
      ,cn.[NgayhenTra]
      ,cn.[NhanvienId]
      ,cn.[Ghichu]
      ,cn.[Step]
      ,cn.[Version]
	from CongnoXuat cn 
	where cn.KhachhangId=@KhachhangId and cn.NgayGiaodich=(select Max(NgayGiaodich) from CongnoXuat where cn.KhachhangId=@KhachhangId)
end
GO
/****** Object:  StoredProcedure [dbo].[Khuyen_GetDonhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Khuyen_GetDonhang]
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
	  ,kho.TenKho
	from Donhang d left join Nhanvien n on d.NhanvienId=n.NhanvienId
				left join Nhanvien nv on d.NhanvienCapnhatId=nv.NhanvienId
				left join Khachhang k on d.KhachhangId=k.KhachhangId
				left join Kho kho on d.KhoId = kho.KhoId
end
	

GO
/****** Object:  StoredProcedure [dbo].[Khuyen_GetHanghoa]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Khuyen_GetHanghoa]
as
	select  h.HanghoaId,
	h.Code,
	h.TenHanghoa,
	h.NhomHanghoaId,
	h.Giagoc,
	h.Barcode,
	h.DonviId,
	h.LinkHinhanh,
	h.Ghichu,
	h.Active,
	h.Step,
	h.Version,
	h.NgayCapnhat,
	nh.TenNhomHanghoa as TenNhomHanghoa,
	dv.TenDonvi as TenDonvi
	from Hanghoa h left join NhomHanghoa nh on h.NhomHanghoaId = nh.NhomHanghoaId
				left join Donvi dv on h.DonviId = dv.DonviId



GO
/****** Object:  StoredProcedure [dbo].[Khuyen_GetHanghoaTheoNhom]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Khuyen_GetHanghoaTheoNhom]
@NhomHanghoaId uniqueidentifier
as
	select  h.HanghoaId,
	h.Code,
	h.TenHanghoa,
	h.NhomHanghoaId,
	h.Giagoc,
	h.Barcode,
	h.DonviId,
	h.LinkHinhanh,
	h.Ghichu,
	h.Active,
	h.Step,
	h.Version,
	h.NgayCapnhat,
	nh.TenNhomHanghoa as TenNhomHanghoa,
	dv.TenDonvi as TenDonvi
	from Hanghoa h left join NhomHanghoa nh on h.NhomHanghoaId = nh.NhomHanghoaId
				left join Donvi dv on h.DonviId = dv.DonviId
	where h.NhomHanghoaId = @NhomHanghoaId or @NhomHanghoaId = '00000000-0000-0000-0000-000000000000'

GO
/****** Object:  StoredProcedure [dbo].[Khuyen_GetKhachhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Khuyen_GetKhachhang]
as
	SELECT kh.KhachhangId
      ,kh.Code
      ,kh.HotenKhachhang
      ,kh.CMND
      ,kh.Ngaysinh
      ,kh.Gioitinh
      ,kh.[Diachi]
      ,kh.[DiachiGiaohang]
      ,kh.[QuanhuyenId]
      ,kh.[TinhthanhId]
      ,kh.[NhomKhachhangId]
      ,kh.[Linkanh]
      ,kh.[Congty]
      ,kh.[Chucvu]
      ,kh.[Email]
      ,kh.[DiachiCongty]
      ,kh.[PhoneCongty]
      ,kh.[Tel]
      ,kh.[Mobile]
      ,kh.[Fax]
      ,kh.[MasoThue]
      ,kh.[TenTaikhoan]
      ,kh.[SoTaikhoan]
      ,kh.[Nganhang]
      ,kh.[HanmucCongno]
      ,kh.[ThoigianCongno]
      ,kh.[ToahangCongno]
      ,kh.[Ghichu]
      ,kh.[NgayCapnhat]
      ,kh.[Active]
      ,kh.[Step]
      ,kh.[Version]
	  ,nkh.TenNhomKhachhang
  FROM Khachhang kh left join NhomKhachhang nkh on kh.NhomKhachhangId = nkh.NhomKhachhangId



GO
/****** Object:  StoredProcedure [dbo].[Khuyen_GetPhieuxuatTheoDonhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Khuyen_GetPhieuxuatTheoDonhang]
@DonhangId uniqueidentifier
as
	select  px.PhieuxuatId
      ,px.[Code]
      ,px.[NhanvienLapId]
      ,px.[KhoId]
      ,px.[DonhangId]
      ,px.[Ngaylap]
      ,px.[NhanvienGiaohangId]
      ,px.[TenTinhtrangPhieuxuat]
      ,px.[NgayCapnhat]
      ,px.[Ghichu]
      ,px.[Step]
      ,px.[Version]
	  ,px.[NguyennhanLydo]
	  ,px.[TinhtrangPhieuxuatCurrentId]
	  ,nv.HovatenNhanvien as TenNhanvienLap
	  ,k.TenKho as TenKho
	  ,nv2.HovatenNhanvien as TenNhanvienGiaohang
	  ,dh.Code as CodeDonhang
	  ,dh.NgayLap as NgaylapDonhang
	  ,nn.Noidung as TenNguyennhanLydo
	from Phieuxuat px left join Nhanvien nv on px.NhanvienLapId = nv.NhanvienId
						left join Kho k on px.KhoId = k.KhoId
						left join Nhanvien nv2 on px.NhanvienGiaohangId = nv2.NhanvienId 
						left join Donhang dh on px.DonhangId = dh.DonhangId
						left join NguyennhanLydo nn on px.NguyennhanLydo = nn.NguyennhanLydoId
	where px.DonhangId = @DonhangId
	order by px.Ngaylap desc
GO
/****** Object:  StoredProcedure [dbo].[Khuyen_GetThuchi]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Khuyen_GetThuchi]
as
begin
	select t.[ThuchiId]
      ,t.[NhanvienId]
      ,t.[PhieunhapId]
      ,t.[PhieuxuatId]
      ,t.[Tongtien]
      ,t.[Vaoluc]
      ,t.[Ngay]
      ,t.[Thang]
      ,t.[Nam]
      ,t.[Ghichu]
      ,t.[Step]
      ,t.[Version]
      ,t.[NhannopTienId]
      ,t.[TenNhannopTien]
	  ,n.HovatenNhanvien as TenNhanvien
	from Thuchi t left join Nhanvien n on t.NhanvienId = n.NhanvienId
end
GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietDonhangDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietDonhangDelete]
@ChitietDonhangId UniqueIdentifier, @DonhangId UniqueIdentifier, @HanghoaId UniqueIdentifier, @Soluong Int, @SoluongGiao Int, @SoluongConlai Int, @Step Int, @NgayCapnhat DateTime, @Giaban Float, @VAT Float, @Tiengiam Float, @PhantramGiam Float, @Thanhtien Float, @TenHanghoa NVarChar(100), @GhichuTrahang NVarChar(1000), @Version Timestamp output
as
begin
	DELETE 	From 	[ChitietDonhang]
	WHERE [ChitietDonhangId] = @ChitietDonhangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [ChitietDonhang] where [ChitietDonhangId] = @ChitietDonhangId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietDonhangInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietDonhangInsert]
@ChitietDonhangId UniqueIdentifier, @DonhangId UniqueIdentifier, @HanghoaId UniqueIdentifier, @Soluong Int, @SoluongGiao Int, @SoluongConlai Int, @Step Int, @NgayCapnhat DateTime, @Giaban Float, @VAT Float, @Tiengiam Float, @PhantramGiam Float, @Thanhtien Float, @TenHanghoa NVarChar(100), @GhichuTrahang NVarChar(1000), @Version Timestamp output
as
begin
	INSERT INTO [ChitietDonhang]([ChitietDonhangId], [DonhangId], [HanghoaId], [Soluong], [SoluongGiao], [SoluongConlai], [Step], [NgayCapnhat], [Giaban], [VAT], [Tiengiam], [PhantramGiam], [Thanhtien], [TenHanghoa], [GhichuTrahang]) VALUES (@ChitietDonhangId, @DonhangId, @HanghoaId, @Soluong, @SoluongGiao, @SoluongConlai, @Step, @NgayCapnhat, @Giaban, @VAT, @Tiengiam, @PhantramGiam, @Thanhtien, @TenHanghoa, @GhichuTrahang)	
declare @Ver timestamp	
select @Ver = [Version] from [ChitietDonhang] where [ChitietDonhangId] = @ChitietDonhangId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietDonhangSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietDonhangSelect]
as
begin
	select * from [ChitietDonhang]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietDonhangUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietDonhangUpdate]
@ChitietDonhangId UniqueIdentifier, @DonhangId UniqueIdentifier, @HanghoaId UniqueIdentifier, @Soluong Int, @SoluongGiao Int, @SoluongConlai Int, @Step Int, @NgayCapnhat DateTime, @Giaban Float, @VAT Float, @Tiengiam Float, @PhantramGiam Float, @Thanhtien Float, @TenHanghoa NVarChar(100), @GhichuTrahang NVarChar(1000), @Version Timestamp output
as
begin
	UPDATE [ChitietDonhang]
	SET 
	[DonhangId] = @DonhangId, [HanghoaId] = @HanghoaId, [Soluong] = @Soluong, [SoluongGiao] = @SoluongGiao, [SoluongConlai] = @SoluongConlai, [Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Giaban] = @Giaban, [VAT] = @VAT, [Tiengiam] = @Tiengiam, [PhantramGiam] = @PhantramGiam, [Thanhtien] = @Thanhtien, [TenHanghoa] = @TenHanghoa, [GhichuTrahang] = @GhichuTrahang
	WHERE [ChitietDonhangId] = @ChitietDonhangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [ChitietDonhang] where [ChitietDonhangId] = @ChitietDonhangId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietPhieunhapDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietPhieunhapDelete]
@ChitietPhieunhapId UniqueIdentifier, @PhieunhapId UniqueIdentifier, @HanghoaId UniqueIdentifier, @Soluong Int, @Step Int, @NSX DateTime, @HSD DateTime, @Barcode NVarChar(100), @Ghichu NVarChar(400), @Version Timestamp output
as
begin
	DELETE 	From 	[ChitietPhieunhap]
	WHERE [ChitietPhieunhapId] = @ChitietPhieunhapId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [ChitietPhieunhap] where [ChitietPhieunhapId] = @ChitietPhieunhapId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietPhieunhapInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietPhieunhapInsert]
@ChitietPhieunhapId UniqueIdentifier, @PhieunhapId UniqueIdentifier, @HanghoaId UniqueIdentifier, @Soluong Int, @Step Int, @NSX DateTime, @HSD DateTime, @Barcode NVarChar(100), @Ghichu NVarChar(400), @Version Timestamp output
as
begin
	INSERT INTO [ChitietPhieunhap]([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Step], [NSX], [HSD], [Barcode], [Ghichu]) VALUES (@ChitietPhieunhapId, @PhieunhapId, @HanghoaId, @Soluong, @Step, @NSX, @HSD, @Barcode, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [ChitietPhieunhap] where [ChitietPhieunhapId] = @ChitietPhieunhapId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietPhieunhapSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietPhieunhapSelect]
as
begin
	select * from [ChitietPhieunhap]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietPhieunhapUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietPhieunhapUpdate]
@ChitietPhieunhapId UniqueIdentifier, @PhieunhapId UniqueIdentifier, @HanghoaId UniqueIdentifier, @Soluong Int, @Step Int, @NSX DateTime, @HSD DateTime, @Barcode NVarChar(100), @Ghichu NVarChar(400), @Version Timestamp output
as
begin
	UPDATE [ChitietPhieunhap]
	SET 
	[PhieunhapId] = @PhieunhapId, [HanghoaId] = @HanghoaId, [Soluong] = @Soluong, [Step] = @Step, [NSX] = @NSX, [HSD] = @HSD, [Barcode] = @Barcode, [Ghichu] = @Ghichu
	WHERE [ChitietPhieunhapId] = @ChitietPhieunhapId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [ChitietPhieunhap] where [ChitietPhieunhapId] = @ChitietPhieunhapId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietPhieuxuatDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietPhieuxuatDelete]
@ChitietPhieuxuatId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @HanghoaId UniqueIdentifier, @ChitietDonhangId UniqueIdentifier, @Soluong Int, @Step Int, @Thanhtien Float, @Active Bit, @Ghichu NVarChar(1000), @Version Timestamp output
as
begin
	DELETE 	From 	[ChitietPhieuxuat]
	WHERE [ChitietPhieuxuatId] = @ChitietPhieuxuatId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [ChitietPhieuxuat] where [ChitietPhieuxuatId] = @ChitietPhieuxuatId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietPhieuxuatInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietPhieuxuatInsert]
@ChitietPhieuxuatId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @HanghoaId UniqueIdentifier, @ChitietDonhangId UniqueIdentifier, @Soluong Int, @Step Int, @Thanhtien Float, @Active Bit, @Ghichu NVarChar(1000), @Version Timestamp output
as
begin
	INSERT INTO [ChitietPhieuxuat]([ChitietPhieuxuatId], [PhieuxuatId], [HanghoaId], [ChitietDonhangId], [Soluong], [Step], [Thanhtien], [Active], [Ghichu]) VALUES (@ChitietPhieuxuatId, @PhieuxuatId, @HanghoaId, @ChitietDonhangId, @Soluong, @Step, @Thanhtien, @Active, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [ChitietPhieuxuat] where [ChitietPhieuxuatId] = @ChitietPhieuxuatId	
set @Version = @Ver
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietPhieuxuatSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietPhieuxuatSelect]
as
begin
	select * from [ChitietPhieuxuat]
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_ChitietPhieuxuatUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ChitietPhieuxuatUpdate]
@ChitietPhieuxuatId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @HanghoaId UniqueIdentifier, @ChitietDonhangId UniqueIdentifier, @Soluong Int, @Step Int, @Thanhtien Float, @Active Bit, @Ghichu NVarChar(1000), @Version Timestamp output
as
begin
	UPDATE [ChitietPhieuxuat]
	SET 
	[PhieuxuatId] = @PhieuxuatId, [HanghoaId] = @HanghoaId, [ChitietDonhangId] = @ChitietDonhangId, [Soluong] = @Soluong, [Step] = @Step, [Thanhtien] = @Thanhtien, [Active] = @Active, [Ghichu] = @Ghichu
	WHERE [ChitietPhieuxuatId] = @ChitietPhieuxuatId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [ChitietPhieuxuat] where [ChitietPhieuxuatId] = @ChitietPhieuxuatId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_CongnoNhapDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_CongnoNhapDelete]
@CongnoNhapId UniqueIdentifier, @NhaCungcapId UniqueIdentifier, @NhanvienId UniqueIdentifier, @Step Int, @NgayGiaodich DateTime, @NgayHentra DateTime, @SoduTruocGiaodich Float, @SotienGiaodich Float, @Ghichu NVarChar(100), @Tongno NChar(20), @Version Timestamp output
as
begin
	DELETE 	From 	[CongnoNhap]
	WHERE [CongnoNhapId] = @CongnoNhapId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [CongnoNhap] where [CongnoNhapId] = @CongnoNhapId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_CongnoNhapInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_CongnoNhapInsert]
@CongnoNhapId UniqueIdentifier, @NhaCungcapId UniqueIdentifier, @NhanvienId UniqueIdentifier, @Step Int, @NgayGiaodich DateTime, @NgayHentra DateTime, @SoduTruocGiaodich Float, @SotienGiaodich Float, @Ghichu NVarChar(100), @Tongno NChar(20), @Version Timestamp output
as
begin
	INSERT INTO [CongnoNhap]([CongnoNhapId], [NhaCungcapId], [NhanvienId], [Step], [NgayGiaodich], [NgayHentra], [SoduTruocGiaodich], [SotienGiaodich], [Ghichu], [Tongno]) VALUES (@CongnoNhapId, @NhaCungcapId, @NhanvienId, @Step, @NgayGiaodich, @NgayHentra, @SoduTruocGiaodich, @SotienGiaodich, @Ghichu, @Tongno)	
declare @Ver timestamp	
select @Ver = [Version] from [CongnoNhap] where [CongnoNhapId] = @CongnoNhapId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_CongnoNhapSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_CongnoNhapSelect]
as
begin
	select * from [CongnoNhap]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_CongnoNhapUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_CongnoNhapUpdate]
@CongnoNhapId UniqueIdentifier, @NhaCungcapId UniqueIdentifier, @NhanvienId UniqueIdentifier, @Step Int, @NgayGiaodich DateTime, @NgayHentra DateTime, @SoduTruocGiaodich Float, @SotienGiaodich Float, @Ghichu NVarChar(100), @Tongno NChar(20), @Version Timestamp output
as
begin
	UPDATE [CongnoNhap]
	SET 
	[NhaCungcapId] = @NhaCungcapId, [NhanvienId] = @NhanvienId, [Step] = @Step, [NgayGiaodich] = @NgayGiaodich, [NgayHentra] = @NgayHentra, [SoduTruocGiaodich] = @SoduTruocGiaodich, [SotienGiaodich] = @SotienGiaodich, [Ghichu] = @Ghichu, [Tongno] = @Tongno
	WHERE [CongnoNhapId] = @CongnoNhapId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [CongnoNhap] where [CongnoNhapId] = @CongnoNhapId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_CongnoXuatDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_CongnoXuatDelete]
@CongnoXuatId UniqueIdentifier, @KhachhangId UniqueIdentifier, @NhanvienId UniqueIdentifier, @Step Int, @NgayGiaodich DateTime, @NgayhenTra DateTime, @SoduTruocGiaodich Float, @SotienGiaodich Float, @Tongno Float, @Dienthoai NVarChar(40), @Diachi NVarChar(400), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[CongnoXuat]
	WHERE [CongnoXuatId] = @CongnoXuatId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [CongnoXuat] where [CongnoXuatId] = @CongnoXuatId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_CongnoXuatInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_CongnoXuatInsert]
@CongnoXuatId UniqueIdentifier, @KhachhangId UniqueIdentifier, @NhanvienId UniqueIdentifier, @Step Int, @NgayGiaodich DateTime, @NgayhenTra DateTime, @SoduTruocGiaodich Float, @SotienGiaodich Float, @Tongno Float, @Dienthoai NVarChar(40), @Diachi NVarChar(400), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [CongnoXuat]([CongnoXuatId], [KhachhangId], [NhanvienId], [Step], [NgayGiaodich], [NgayhenTra], [SoduTruocGiaodich], [SotienGiaodich], [Tongno], [Dienthoai], [Diachi], [Ghichu]) VALUES (@CongnoXuatId, @KhachhangId, @NhanvienId, @Step, @NgayGiaodich, @NgayhenTra, @SoduTruocGiaodich, @SotienGiaodich, @Tongno, @Dienthoai, @Diachi, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [CongnoXuat] where [CongnoXuatId] = @CongnoXuatId	
set @Version = @Ver
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_CongnoXuatSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_CongnoXuatSelect]
as
begin
	select * from [CongnoXuat]
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_CongnoXuatUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_CongnoXuatUpdate]
@CongnoXuatId UniqueIdentifier, @KhachhangId UniqueIdentifier, @NhanvienId UniqueIdentifier, @Step Int, @NgayGiaodich DateTime, @NgayhenTra DateTime, @SoduTruocGiaodich Float, @SotienGiaodich Float, @Tongno Float, @Dienthoai NVarChar(40), @Diachi NVarChar(400), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [CongnoXuat]
	SET 
	[KhachhangId] = @KhachhangId, [NhanvienId] = @NhanvienId, [Step] = @Step, [NgayGiaodich] = @NgayGiaodich, [NgayhenTra] = @NgayhenTra, [SoduTruocGiaodich] = @SoduTruocGiaodich, [SotienGiaodich] = @SotienGiaodich, [Tongno] = @Tongno, [Dienthoai] = @Dienthoai, [Diachi] = @Diachi, [Ghichu] = @Ghichu
	WHERE [CongnoXuatId] = @CongnoXuatId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [CongnoXuat] where [CongnoXuatId] = @CongnoXuatId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_DongiaDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DongiaDelete]
@DongiaId UniqueIdentifier, @HanghoaId UniqueIdentifier, @NhomKhachhangId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @ApdungTu DateTime, @Dongia Float, @Active Bit, @Code NVarChar(40), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[Dongia]
	WHERE [DongiaId] = @DongiaId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Dongia] where [DongiaId] = @DongiaId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_DongiaInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DongiaInsert]
@DongiaId UniqueIdentifier, @HanghoaId UniqueIdentifier, @NhomKhachhangId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @ApdungTu DateTime, @Dongia Float, @Active Bit, @Code NVarChar(40), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [Dongia]([DongiaId], [HanghoaId], [NhomKhachhangId], [Step], [NgayCapnhat], [ApdungTu], [Dongia], [Active], [Code], [Ghichu]) VALUES (@DongiaId, @HanghoaId, @NhomKhachhangId, @Step, @NgayCapnhat, @ApdungTu, @Dongia, @Active, @Code, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Dongia] where [DongiaId] = @DongiaId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_DongiaSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DongiaSelect]
as
begin
	select * from [Dongia]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_DongiaUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DongiaUpdate]
@DongiaId UniqueIdentifier, @HanghoaId UniqueIdentifier, @NhomKhachhangId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @ApdungTu DateTime, @Dongia Float, @Active Bit, @Code NVarChar(40), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [Dongia]
	SET 
	[HanghoaId] = @HanghoaId, [NhomKhachhangId] = @NhomKhachhangId, [Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [ApdungTu] = @ApdungTu, [Dongia] = @Dongia, [Active] = @Active, [Code] = @Code, [Ghichu] = @Ghichu
	WHERE [DongiaId] = @DongiaId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Dongia] where [DongiaId] = @DongiaId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_DonhangDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DonhangDelete]
@DonhangId UniqueIdentifier, @NhanvienId UniqueIdentifier, @KhoId UniqueIdentifier, @KhachhangId UniqueIdentifier, @NhanvienCapnhatId UniqueIdentifier, @LoaiDonhang Int, @Step Int, @Ngaylap DateTime, @Ngaygiao DateTime, @NgayCapnhat DateTime, @Tiengiam Float, @PhantramGiam Float, @Tongtien Float, @Code NVarChar(40), @TenTinhtrangDonhang NVarChar(100), @DiachiGiao NVarChar(200), @TenTinhthanhGiao NVarChar(100), @TenQuanhuyenGiao NVarChar(100), @SoDienthoai NVarChar(100), @Ghichu NVarChar(400), @Version Timestamp output
as
begin
	DELETE 	From 	[Donhang]
	WHERE [DonhangId] = @DonhangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Donhang] where [DonhangId] = @DonhangId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_DonhangInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DonhangInsert]
@DonhangId UniqueIdentifier, @NhanvienId UniqueIdentifier, @KhoId UniqueIdentifier, @KhachhangId UniqueIdentifier, @NhanvienCapnhatId UniqueIdentifier, @LoaiDonhang Int, @Step Int, @Ngaylap DateTime, @Ngaygiao DateTime, @NgayCapnhat DateTime, @Tiengiam Float, @PhantramGiam Float, @Tongtien Float, @Code NVarChar(40), @TenTinhtrangDonhang NVarChar(100), @DiachiGiao NVarChar(200), @TenTinhthanhGiao NVarChar(100), @TenQuanhuyenGiao NVarChar(100), @SoDienthoai NVarChar(100), @Ghichu NVarChar(400), @Version Timestamp output
as
begin
	INSERT INTO [Donhang]([DonhangId], [NhanvienId], [KhoId], [KhachhangId], [NhanvienCapnhatId], [LoaiDonhang], [Step], [Ngaylap], [Ngaygiao], [NgayCapnhat], [Tiengiam], [PhantramGiam], [Tongtien], [Code], [TenTinhtrangDonhang], [DiachiGiao], [TenTinhthanhGiao], [TenQuanhuyenGiao], [SoDienthoai], [Ghichu]) VALUES (@DonhangId, @NhanvienId, @KhoId, @KhachhangId, @NhanvienCapnhatId, @LoaiDonhang, @Step, @Ngaylap, @Ngaygiao, @NgayCapnhat, @Tiengiam, @PhantramGiam, @Tongtien, @Code, @TenTinhtrangDonhang, @DiachiGiao, @TenTinhthanhGiao, @TenQuanhuyenGiao, @SoDienthoai, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Donhang] where [DonhangId] = @DonhangId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_DonhangSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DonhangSelect]
as
begin
	select * from [Donhang]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_DonhangUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DonhangUpdate]
@DonhangId UniqueIdentifier, @NhanvienId UniqueIdentifier, @KhoId UniqueIdentifier, @KhachhangId UniqueIdentifier, @NhanvienCapnhatId UniqueIdentifier, @LoaiDonhang Int, @Step Int, @Ngaylap DateTime, @Ngaygiao DateTime, @NgayCapnhat DateTime, @Tiengiam Float, @PhantramGiam Float, @Tongtien Float, @Code NVarChar(40), @TenTinhtrangDonhang NVarChar(100), @DiachiGiao NVarChar(200), @TenTinhthanhGiao NVarChar(100), @TenQuanhuyenGiao NVarChar(100), @SoDienthoai NVarChar(100), @Ghichu NVarChar(400), @Version Timestamp output
as
begin
	UPDATE [Donhang]
	SET 
	[NhanvienId] = @NhanvienId, [KhoId] = @KhoId, [KhachhangId] = @KhachhangId, [NhanvienCapnhatId] = @NhanvienCapnhatId, [LoaiDonhang] = @LoaiDonhang, [Step] = @Step, [Ngaylap] = @Ngaylap, [Ngaygiao] = @Ngaygiao, [NgayCapnhat] = @NgayCapnhat, [Tiengiam] = @Tiengiam, [PhantramGiam] = @PhantramGiam, [Tongtien] = @Tongtien, [Code] = @Code, [TenTinhtrangDonhang] = @TenTinhtrangDonhang, [DiachiGiao] = @DiachiGiao, [TenTinhthanhGiao] = @TenTinhthanhGiao, [TenQuanhuyenGiao] = @TenQuanhuyenGiao, [SoDienthoai] = @SoDienthoai, [Ghichu] = @Ghichu
	WHERE [DonhangId] = @DonhangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Donhang] where [DonhangId] = @DonhangId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_DonviDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DonviDelete]
@DonviId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenDonvi NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[Donvi]
	WHERE [DonviId] = @DonviId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Donvi] where [DonviId] = @DonviId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_DonviInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DonviInsert]
@DonviId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenDonvi NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [Donvi]([DonviId], [Step], [NgayCapnhat], [Active], [Code], [TenDonvi], [Ghichu]) VALUES (@DonviId, @Step, @NgayCapnhat, @Active, @Code, @TenDonvi, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Donvi] where [DonviId] = @DonviId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_DonviSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DonviSelect]
as
begin
	select * from [Donvi]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_DonviUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_DonviUpdate]
@DonviId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenDonvi NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [Donvi]
	SET 
	[Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [Code] = @Code, [TenDonvi] = @TenDonvi, [Ghichu] = @Ghichu
	WHERE [DonviId] = @DonviId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Donvi] where [DonviId] = @DonviId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_HanghoaDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_HanghoaDelete]
@HanghoaId UniqueIdentifier, @NhomHanghoaId UniqueIdentifier, @DonviId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Giagoc Float, @Active Bit, @Code NVarChar(40), @TenHanghoa NVarChar(100), @Barcode NVarChar(200), @LinkHinhanh NVarChar(600), @Ghichu NVarChar(1000), @Version Timestamp output
as
begin
	DELETE 	From 	[Hanghoa]
	WHERE [HanghoaId] = @HanghoaId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Hanghoa] where [HanghoaId] = @HanghoaId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_HanghoaInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_HanghoaInsert]
@HanghoaId UniqueIdentifier, @NhomHanghoaId UniqueIdentifier, @DonviId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Giagoc Float, @Active Bit, @Code NVarChar(40), @TenHanghoa NVarChar(100), @Barcode NVarChar(200), @LinkHinhanh NVarChar(600), @Ghichu NVarChar(1000), @Version Timestamp output
as
begin
	INSERT INTO [Hanghoa]([HanghoaId], [NhomHanghoaId], [DonviId], [Step], [NgayCapnhat], [Giagoc], [Active], [Code], [TenHanghoa], [Barcode], [LinkHinhanh], [Ghichu]) VALUES (@HanghoaId, @NhomHanghoaId, @DonviId, @Step, @NgayCapnhat, @Giagoc, @Active, @Code, @TenHanghoa, @Barcode, @LinkHinhanh, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Hanghoa] where [HanghoaId] = @HanghoaId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_HanghoaNhaCungcapDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_HanghoaNhaCungcapDelete]
@HanghoaNhaCungcapId UniqueIdentifier, @HanghoaId UniqueIdentifier, @NhaCungcapId UniqueIdentifier, @Step Int, @Code NVarChar(40), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[HanghoaNhaCungcap]
	WHERE [HanghoaNhaCungcapId] = @HanghoaNhaCungcapId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [HanghoaNhaCungcap] where [HanghoaNhaCungcapId] = @HanghoaNhaCungcapId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_HanghoaNhaCungcapInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_HanghoaNhaCungcapInsert]
@HanghoaNhaCungcapId UniqueIdentifier, @HanghoaId UniqueIdentifier, @NhaCungcapId UniqueIdentifier, @Step Int, @Code NVarChar(40), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [HanghoaNhaCungcap]([HanghoaNhaCungcapId], [HanghoaId], [NhaCungcapId], [Step], [Code], [Ghichu]) VALUES (@HanghoaNhaCungcapId, @HanghoaId, @NhaCungcapId, @Step, @Code, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [HanghoaNhaCungcap] where [HanghoaNhaCungcapId] = @HanghoaNhaCungcapId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_HanghoaNhaCungcapSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_HanghoaNhaCungcapSelect]
as
begin
	select * from [HanghoaNhaCungcap]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_HanghoaNhaCungcapUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_HanghoaNhaCungcapUpdate]
@HanghoaNhaCungcapId UniqueIdentifier, @HanghoaId UniqueIdentifier, @NhaCungcapId UniqueIdentifier, @Step Int, @Code NVarChar(40), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [HanghoaNhaCungcap]
	SET 
	[HanghoaId] = @HanghoaId, [NhaCungcapId] = @NhaCungcapId, [Step] = @Step, [Code] = @Code, [Ghichu] = @Ghichu
	WHERE [HanghoaNhaCungcapId] = @HanghoaNhaCungcapId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [HanghoaNhaCungcap] where [HanghoaNhaCungcapId] = @HanghoaNhaCungcapId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_HanghoaSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_HanghoaSelect]
as
begin
	select * from [Hanghoa]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_HanghoaUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_HanghoaUpdate]
@HanghoaId UniqueIdentifier, @NhomHanghoaId UniqueIdentifier, @DonviId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Giagoc Float, @Active Bit, @Code NVarChar(40), @TenHanghoa NVarChar(100), @Barcode NVarChar(200), @LinkHinhanh NVarChar(600), @Ghichu NVarChar(1000), @Version Timestamp output
as
begin
	UPDATE [Hanghoa]
	SET 
	[NhomHanghoaId] = @NhomHanghoaId, [DonviId] = @DonviId, [Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Giagoc] = @Giagoc, [Active] = @Active, [Code] = @Code, [TenHanghoa] = @TenHanghoa, [Barcode] = @Barcode, [LinkHinhanh] = @LinkHinhanh, [Ghichu] = @Ghichu
	WHERE [HanghoaId] = @HanghoaId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Hanghoa] where [HanghoaId] = @HanghoaId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_KhachhangDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhachhangDelete]
@KhachhangId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @NhomKhachhangId UniqueIdentifier, @AccountId UniqueIdentifier, @ThoigianCongno Int, @ToahangCongno Int, @Step Int, @Ngaysinh DateTime, @NgayCapnhat DateTime, @HanmucCongno Float, @Gioitinh Bit, @Active Bit, @Code NVarChar(40), @HotenKhachhang NVarChar(200), @CMND NVarChar(100), @Diachi NVarChar(400), @DiachiGiaohang NVarChar(200), @Linkanh NVarChar(600), @Ghichu NVarChar(1000), @Mobile NVarChar(40), @Fax NVarChar(40), @MasoThue NVarChar(100), @TenTaikhoan NVarChar(510), @SoTaikhoan NVarChar(100), @Nganhang NVarChar(100), @Congty NVarChar(100), @Chucvu NVarChar(100), @Email NVarChar(200), @DiachiCongty NVarChar(400), @PhoneCongty NVarChar(40), @Tel NVarChar(40), @Version Timestamp output
as
begin
	DELETE 	From 	[Khachhang]
	WHERE [KhachhangId] = @KhachhangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Khachhang] where [KhachhangId] = @KhachhangId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_KhachhangInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhachhangInsert]
@KhachhangId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @NhomKhachhangId UniqueIdentifier, @AccountId UniqueIdentifier, @ThoigianCongno Int, @ToahangCongno Int, @Step Int, @Ngaysinh DateTime, @NgayCapnhat DateTime, @HanmucCongno Float, @Gioitinh Bit, @Active Bit, @Code NVarChar(40), @HotenKhachhang NVarChar(200), @CMND NVarChar(100), @Diachi NVarChar(400), @DiachiGiaohang NVarChar(200), @Linkanh NVarChar(600), @Ghichu NVarChar(1000), @Mobile NVarChar(40), @Fax NVarChar(40), @MasoThue NVarChar(100), @TenTaikhoan NVarChar(510), @SoTaikhoan NVarChar(100), @Nganhang NVarChar(100), @Congty NVarChar(100), @Chucvu NVarChar(100), @Email NVarChar(200), @DiachiCongty NVarChar(400), @PhoneCongty NVarChar(40), @Tel NVarChar(40), @Version Timestamp output
as
begin
	INSERT INTO [Khachhang]([KhachhangId], [QuanhuyenId], [TinhthanhId], [NhomKhachhangId], [AccountId], [ThoigianCongno], [ToahangCongno], [Step], [Ngaysinh], [NgayCapnhat], [HanmucCongno], [Gioitinh], [Active], [Code], [HotenKhachhang], [CMND], [Diachi], [DiachiGiaohang], [Linkanh], [Ghichu], [Mobile], [Fax], [MasoThue], [TenTaikhoan], [SoTaikhoan], [Nganhang], [Congty], [Chucvu], [Email], [DiachiCongty], [PhoneCongty], [Tel]) VALUES (@KhachhangId, @QuanhuyenId, @TinhthanhId, @NhomKhachhangId, @AccountId, @ThoigianCongno, @ToahangCongno, @Step, @Ngaysinh, @NgayCapnhat, @HanmucCongno, @Gioitinh, @Active, @Code, @HotenKhachhang, @CMND, @Diachi, @DiachiGiaohang, @Linkanh, @Ghichu, @Mobile, @Fax, @MasoThue, @TenTaikhoan, @SoTaikhoan, @Nganhang, @Congty, @Chucvu, @Email, @DiachiCongty, @PhoneCongty, @Tel)	
declare @Ver timestamp	
select @Ver = [Version] from [Khachhang] where [KhachhangId] = @KhachhangId	
set @Version = @Ver
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_KhachhangSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhachhangSelect]
as
begin
	select * from [Khachhang]
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_KhachhangUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhachhangUpdate]
@KhachhangId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @NhomKhachhangId UniqueIdentifier, @AccountId UniqueIdentifier, @ThoigianCongno Int, @ToahangCongno Int, @Step Int, @Ngaysinh DateTime, @NgayCapnhat DateTime, @HanmucCongno Float, @Gioitinh Bit, @Active Bit, @Code NVarChar(40), @HotenKhachhang NVarChar(200), @CMND NVarChar(100), @Diachi NVarChar(400), @DiachiGiaohang NVarChar(200), @Linkanh NVarChar(600), @Ghichu NVarChar(1000), @Mobile NVarChar(40), @Fax NVarChar(40), @MasoThue NVarChar(100), @TenTaikhoan NVarChar(510), @SoTaikhoan NVarChar(100), @Nganhang NVarChar(100), @Congty NVarChar(100), @Chucvu NVarChar(100), @Email NVarChar(200), @DiachiCongty NVarChar(400), @PhoneCongty NVarChar(40), @Tel NVarChar(40), @Version Timestamp output
as
begin
	UPDATE [Khachhang]
	SET 
	[QuanhuyenId] = @QuanhuyenId, [TinhthanhId] = @TinhthanhId, [NhomKhachhangId] = @NhomKhachhangId, [AccountId] = @AccountId, [ThoigianCongno] = @ThoigianCongno, [ToahangCongno] = @ToahangCongno, [Step] = @Step, [Ngaysinh] = @Ngaysinh, [NgayCapnhat] = @NgayCapnhat, [HanmucCongno] = @HanmucCongno, [Gioitinh] = @Gioitinh, [Active] = @Active, [Code] = @Code, [HotenKhachhang] = @HotenKhachhang, [CMND] = @CMND, [Diachi] = @Diachi, [DiachiGiaohang] = @DiachiGiaohang, [Linkanh] = @Linkanh, [Ghichu] = @Ghichu, [Mobile] = @Mobile, [Fax] = @Fax, [MasoThue] = @MasoThue, [TenTaikhoan] = @TenTaikhoan, [SoTaikhoan] = @SoTaikhoan, [Nganhang] = @Nganhang, [Congty] = @Congty, [Chucvu] = @Chucvu, [Email] = @Email, [DiachiCongty] = @DiachiCongty, [PhoneCongty] = @PhoneCongty, [Tel] = @Tel
	WHERE [KhachhangId] = @KhachhangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Khachhang] where [KhachhangId] = @KhachhangId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_KhoDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhoDelete]
@KhoId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenKho NVarChar(100), @Diachi NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[Kho]
	WHERE [KhoId] = @KhoId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Kho] where [KhoId] = @KhoId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_KhoInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhoInsert]
@KhoId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenKho NVarChar(100), @Diachi NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [Kho]([KhoId], [QuanhuyenId], [TinhthanhId], [Step], [NgayCapnhat], [Active], [Code], [TenKho], [Diachi], [Ghichu]) VALUES (@KhoId, @QuanhuyenId, @TinhthanhId, @Step, @NgayCapnhat, @Active, @Code, @TenKho, @Diachi, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Kho] where [KhoId] = @KhoId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_KhoSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhoSelect]
as
begin
	select * from [Kho]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_KhoUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhoUpdate]
@KhoId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenKho NVarChar(100), @Diachi NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [Kho]
	SET 
	[QuanhuyenId] = @QuanhuyenId, [TinhthanhId] = @TinhthanhId, [Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [Code] = @Code, [TenKho] = @TenKho, [Diachi] = @Diachi, [Ghichu] = @Ghichu
	WHERE [KhoId] = @KhoId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Kho] where [KhoId] = @KhoId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_KhuvucDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhuvucDelete]
@KhuvucId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenKhuvuc NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[Khuvuc]
	WHERE [KhuvucId] = @KhuvucId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Khuvuc] where [KhuvucId] = @KhuvucId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_KhuvucInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhuvucInsert]
@KhuvucId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenKhuvuc NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [Khuvuc]([KhuvucId], [Step], [NgayCapnhat], [Active], [Code], [TenKhuvuc], [Ghichu]) VALUES (@KhuvucId, @Step, @NgayCapnhat, @Active, @Code, @TenKhuvuc, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Khuvuc] where [KhuvucId] = @KhuvucId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_KhuvucSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhuvucSelect]
as
begin
	select * from [Khuvuc]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_KhuvucUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_KhuvucUpdate]
@KhuvucId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenKhuvuc NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [Khuvuc]
	SET 
	[Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [Code] = @Code, [TenKhuvuc] = @TenKhuvuc, [Ghichu] = @Ghichu
	WHERE [KhuvucId] = @KhuvucId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Khuvuc] where [KhuvucId] = @KhuvucId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_LoHanghoaDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_LoHanghoaDelete]
@LoHanghoaId UniqueIdentifier, @HanghoaId UniqueIdentifier, @KhoId UniqueIdentifier, @NhanvienCapnhat UniqueIdentifier, @Ngay Int, @Thang Int, @Nam Int, @SoduDauky Int, @SoluongNhap Int, @SoluongXuat Int, @SoluongHuy Int, @SoluongTon Int, @Step Int, @HSD DateTime, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenloHanghoa NVarChar(100), @Ghichu NVarChar(200), @Version Timestamp output
as
begin
	DELETE 	From 	[LoHanghoa]
	WHERE [LoHanghoaId] = @LoHanghoaId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [LoHanghoa] where [LoHanghoaId] = @LoHanghoaId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_LoHanghoaInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_LoHanghoaInsert]
@LoHanghoaId UniqueIdentifier, @HanghoaId UniqueIdentifier, @KhoId UniqueIdentifier, @NhanvienCapnhat UniqueIdentifier, @Ngay Int, @Thang Int, @Nam Int, @SoduDauky Int, @SoluongNhap Int, @SoluongXuat Int, @SoluongHuy Int, @SoluongTon Int, @Step Int, @HSD DateTime, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenloHanghoa NVarChar(100), @Ghichu NVarChar(200), @Version Timestamp output
as
begin
	INSERT INTO [LoHanghoa]([LoHanghoaId], [HanghoaId], [KhoId], [NhanvienCapnhat], [Ngay], [Thang], [Nam], [SoduDauky], [SoluongNhap], [SoluongXuat], [SoluongHuy], [SoluongTon], [Step], [HSD], [NgayCapnhat], [Active], [Code], [TenloHanghoa], [Ghichu]) VALUES (@LoHanghoaId, @HanghoaId, @KhoId, @NhanvienCapnhat, @Ngay, @Thang, @Nam, @SoduDauky, @SoluongNhap, @SoluongXuat, @SoluongHuy, @SoluongTon, @Step, @HSD, @NgayCapnhat, @Active, @Code, @TenloHanghoa, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [LoHanghoa] where [LoHanghoaId] = @LoHanghoaId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_LoHanghoaSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_LoHanghoaSelect]
as
begin
	select * from [LoHanghoa]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_LoHanghoaUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_LoHanghoaUpdate]
@LoHanghoaId UniqueIdentifier, @HanghoaId UniqueIdentifier, @KhoId UniqueIdentifier, @NhanvienCapnhat UniqueIdentifier, @Ngay Int, @Thang Int, @Nam Int, @SoduDauky Int, @SoluongNhap Int, @SoluongXuat Int, @SoluongHuy Int, @SoluongTon Int, @Step Int, @HSD DateTime, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenloHanghoa NVarChar(100), @Ghichu NVarChar(200), @Version Timestamp output
as
begin
	UPDATE [LoHanghoa]
	SET 
	[HanghoaId] = @HanghoaId, [KhoId] = @KhoId, [NhanvienCapnhat] = @NhanvienCapnhat, [Ngay] = @Ngay, [Thang] = @Thang, [Nam] = @Nam, [SoduDauky] = @SoduDauky, [SoluongNhap] = @SoluongNhap, [SoluongXuat] = @SoluongXuat, [SoluongHuy] = @SoluongHuy, [SoluongTon] = @SoluongTon, [Step] = @Step, [HSD] = @HSD, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [Code] = @Code, [TenloHanghoa] = @TenloHanghoa, [Ghichu] = @Ghichu
	WHERE [LoHanghoaId] = @LoHanghoaId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [LoHanghoa] where [LoHanghoaId] = @LoHanghoaId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_NguyennhanLydoDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NguyennhanLydoDelete]
@NguyennhanLydoId UniqueIdentifier, @Step Int, @Active Bit, @Code NVarChar(100), @Noidung NVarChar(200), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[NguyennhanLydo]
	WHERE [NguyennhanLydoId] = @NguyennhanLydoId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [NguyennhanLydo] where [NguyennhanLydoId] = @NguyennhanLydoId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NguyennhanLydoInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NguyennhanLydoInsert]
@NguyennhanLydoId UniqueIdentifier, @Step Int, @Active Bit, @Code NVarChar(100), @Noidung NVarChar(200), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [NguyennhanLydo]([NguyennhanLydoId], [Step], [Active], [Code], [Noidung], [Ghichu]) VALUES (@NguyennhanLydoId, @Step, @Active, @Code, @Noidung, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [NguyennhanLydo] where [NguyennhanLydoId] = @NguyennhanLydoId	
set @Version = @Ver
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_NguyennhanLydoSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NguyennhanLydoSelect]
as
begin
	select * from [NguyennhanLydo]
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_NguyennhanLydoUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NguyennhanLydoUpdate]
@NguyennhanLydoId UniqueIdentifier, @Step Int, @Active Bit, @Code NVarChar(100), @Noidung NVarChar(200), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [NguyennhanLydo]
	SET 
	[Step] = @Step, [Active] = @Active, [Code] = @Code, [Noidung] = @Noidung, [Ghichu] = @Ghichu
	WHERE [NguyennhanLydoId] = @NguyennhanLydoId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [NguyennhanLydo] where [NguyennhanLydoId] = @NguyennhanLydoId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NhaCungcapDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhaCungcapDelete]
@NhaCungcapId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenNhaCungcap NVarChar(100), @Diachi NVarChar(100), @TenCongty NVarChar(100), @Fax NVarChar(40), @Tel NVarChar(40), @Ghichu NVarChar(100), @Mobile NVarChar(40), @Email NVarChar(200), @Website NVarChar(510), @TenTaikhoan NVarChar(100), @SoTaikhoan NVarChar(100), @Nganhang NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[NhaCungcap]
	WHERE [NhaCungcapId] = @NhaCungcapId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [NhaCungcap] where [NhaCungcapId] = @NhaCungcapId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_NhaCungcapInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhaCungcapInsert]
@NhaCungcapId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenNhaCungcap NVarChar(100), @Diachi NVarChar(100), @TenCongty NVarChar(100), @Fax NVarChar(40), @Tel NVarChar(40), @Ghichu NVarChar(100), @Mobile NVarChar(40), @Email NVarChar(200), @Website NVarChar(510), @TenTaikhoan NVarChar(100), @SoTaikhoan NVarChar(100), @Nganhang NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [NhaCungcap]([NhaCungcapId], [QuanhuyenId], [TinhthanhId], [Step], [NgayCapnhat], [Active], [Code], [TenNhaCungcap], [Diachi], [TenCongty], [Fax], [Tel], [Ghichu], [Mobile], [Email], [Website], [TenTaikhoan], [SoTaikhoan], [Nganhang]) VALUES (@NhaCungcapId, @QuanhuyenId, @TinhthanhId, @Step, @NgayCapnhat, @Active, @Code, @TenNhaCungcap, @Diachi, @TenCongty, @Fax, @Tel, @Ghichu, @Mobile, @Email, @Website, @TenTaikhoan, @SoTaikhoan, @Nganhang)	
declare @Ver timestamp	
select @Ver = [Version] from [NhaCungcap] where [NhaCungcapId] = @NhaCungcapId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NhaCungcapSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhaCungcapSelect]
as
begin
	select * from [NhaCungcap]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NhaCungcapUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhaCungcapUpdate]
@NhaCungcapId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenNhaCungcap NVarChar(100), @Diachi NVarChar(100), @TenCongty NVarChar(100), @Fax NVarChar(40), @Tel NVarChar(40), @Ghichu NVarChar(100), @Mobile NVarChar(40), @Email NVarChar(200), @Website NVarChar(510), @TenTaikhoan NVarChar(100), @SoTaikhoan NVarChar(100), @Nganhang NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [NhaCungcap]
	SET 
	[QuanhuyenId] = @QuanhuyenId, [TinhthanhId] = @TinhthanhId, [Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [Code] = @Code, [TenNhaCungcap] = @TenNhaCungcap, [Diachi] = @Diachi, [TenCongty] = @TenCongty, [Fax] = @Fax, [Tel] = @Tel, [Ghichu] = @Ghichu, [Mobile] = @Mobile, [Email] = @Email, [Website] = @Website, [TenTaikhoan] = @TenTaikhoan, [SoTaikhoan] = @SoTaikhoan, [Nganhang] = @Nganhang
	WHERE [NhaCungcapId] = @NhaCungcapId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [NhaCungcap] where [NhaCungcapId] = @NhaCungcapId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_NhanvienDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhanvienDelete]
@NhanvienId UniqueIdentifier, @PhongbanId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @Ngaysinh DateTime, @NgayBatdau DateTime, @NgayKetthuc DateTime, @NgayCapnhat DateTime, @Gioitinh Bit, @Active Bit, @Code NVarChar(40), @TenNhanvien NVarChar(60), @HoNhanvien NVarChar(40), @HovatenNhanvien NVarChar(100), @CMND NVarChar(100), @Email NVarChar(200), @Tel NVarChar(40), @Mobile NVarChar(40), @Diachi NVarChar(400), @Ghichu NVarChar(1000), @Linkanh NVarChar(600), @Version Timestamp output
as
begin
	DELETE 	From 	[Nhanvien]
	WHERE [NhanvienId] = @NhanvienId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Nhanvien] where [NhanvienId] = @NhanvienId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NhanvienInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhanvienInsert]
@NhanvienId UniqueIdentifier, @PhongbanId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @Ngaysinh DateTime, @NgayBatdau DateTime, @NgayKetthuc DateTime, @NgayCapnhat DateTime, @Gioitinh Bit, @Active Bit, @Code NVarChar(40), @TenNhanvien NVarChar(60), @HoNhanvien NVarChar(40), @HovatenNhanvien NVarChar(100), @CMND NVarChar(100), @Email NVarChar(200), @Tel NVarChar(40), @Mobile NVarChar(40), @Diachi NVarChar(400), @Ghichu NVarChar(1000), @Linkanh NVarChar(600), @Version Timestamp output
as
begin
	INSERT INTO [Nhanvien]([NhanvienId], [PhongbanId], [QuanhuyenId], [TinhthanhId], [Step], [Ngaysinh], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Gioitinh], [Active], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Email], [Tel], [Mobile], [Diachi], [Ghichu], [Linkanh]) VALUES (@NhanvienId, @PhongbanId, @QuanhuyenId, @TinhthanhId, @Step, @Ngaysinh, @NgayBatdau, @NgayKetthuc, @NgayCapnhat, @Gioitinh, @Active, @Code, @TenNhanvien, @HoNhanvien, @HovatenNhanvien, @CMND, @Email, @Tel, @Mobile, @Diachi, @Ghichu, @Linkanh)	
declare @Ver timestamp	
select @Ver = [Version] from [Nhanvien] where [NhanvienId] = @NhanvienId	
set @Version = @Ver
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_NhanvienKhoDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhanvienKhoDelete]
@NhanvienKhoId UniqueIdentifier, @NhanvienId UniqueIdentifier, @KhoId UniqueIdentifier, @Step Int, @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[NhanvienKho]
	WHERE [NhanvienKhoId] = @NhanvienKhoId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [NhanvienKho] where [NhanvienKhoId] = @NhanvienKhoId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_NhanvienKhoInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhanvienKhoInsert]
@NhanvienKhoId UniqueIdentifier, @NhanvienId UniqueIdentifier, @KhoId UniqueIdentifier, @Step Int, @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [NhanvienKho]([NhanvienKhoId], [NhanvienId], [KhoId], [Step], [Ghichu]) VALUES (@NhanvienKhoId, @NhanvienId, @KhoId, @Step, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [NhanvienKho] where [NhanvienKhoId] = @NhanvienKhoId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NhanvienKhoSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhanvienKhoSelect]
as
begin
	select * from [NhanvienKho]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NhanvienKhoUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhanvienKhoUpdate]
@NhanvienKhoId UniqueIdentifier, @NhanvienId UniqueIdentifier, @KhoId UniqueIdentifier, @Step Int, @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [NhanvienKho]
	SET 
	[NhanvienId] = @NhanvienId, [KhoId] = @KhoId, [Step] = @Step, [Ghichu] = @Ghichu
	WHERE [NhanvienKhoId] = @NhanvienKhoId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [NhanvienKho] where [NhanvienKhoId] = @NhanvienKhoId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_NhanvienSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhanvienSelect]
as
begin
	select * from [Nhanvien]
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_NhanvienUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhanvienUpdate]
@NhanvienId UniqueIdentifier, @PhongbanId UniqueIdentifier, @QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @Ngaysinh DateTime, @NgayBatdau DateTime, @NgayKetthuc DateTime, @NgayCapnhat DateTime, @Gioitinh Bit, @Active Bit, @Code NVarChar(40), @TenNhanvien NVarChar(60), @HoNhanvien NVarChar(40), @HovatenNhanvien NVarChar(100), @CMND NVarChar(100), @Email NVarChar(200), @Tel NVarChar(40), @Mobile NVarChar(40), @Diachi NVarChar(400), @Ghichu NVarChar(1000), @Linkanh NVarChar(600), @Version Timestamp output
as
begin
	UPDATE [Nhanvien]
	SET 
	[PhongbanId] = @PhongbanId, [QuanhuyenId] = @QuanhuyenId, [TinhthanhId] = @TinhthanhId, [Step] = @Step, [Ngaysinh] = @Ngaysinh, [NgayBatdau] = @NgayBatdau, [NgayKetthuc] = @NgayKetthuc, [NgayCapnhat] = @NgayCapnhat, [Gioitinh] = @Gioitinh, [Active] = @Active, [Code] = @Code, [TenNhanvien] = @TenNhanvien, [HoNhanvien] = @HoNhanvien, [HovatenNhanvien] = @HovatenNhanvien, [CMND] = @CMND, [Email] = @Email, [Tel] = @Tel, [Mobile] = @Mobile, [Diachi] = @Diachi, [Ghichu] = @Ghichu, [Linkanh] = @Linkanh
	WHERE [NhanvienId] = @NhanvienId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Nhanvien] where [NhanvienId] = @NhanvienId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NhomHanghoaDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhomHanghoaDelete]
@NhomHanghoaId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenNhomHanghoa NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[NhomHanghoa]
	WHERE [NhomHanghoaId] = @NhomHanghoaId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [NhomHanghoa] where [NhomHanghoaId] = @NhomHanghoaId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_NhomHanghoaInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhomHanghoaInsert]
@NhomHanghoaId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenNhomHanghoa NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [NhomHanghoa]([NhomHanghoaId], [Step], [NgayCapnhat], [Active], [Code], [TenNhomHanghoa], [Ghichu]) VALUES (@NhomHanghoaId, @Step, @NgayCapnhat, @Active, @Code, @TenNhomHanghoa, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [NhomHanghoa] where [NhomHanghoaId] = @NhomHanghoaId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NhomHanghoaSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhomHanghoaSelect]
as
begin
	select * from [NhomHanghoa]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NhomHanghoaUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhomHanghoaUpdate]
@NhomHanghoaId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenNhomHanghoa NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [NhomHanghoa]
	SET 
	[Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [Code] = @Code, [TenNhomHanghoa] = @TenNhomHanghoa, [Ghichu] = @Ghichu
	WHERE [NhomHanghoaId] = @NhomHanghoaId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [NhomHanghoa] where [NhomHanghoaId] = @NhomHanghoaId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_NhomKhachhangDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhomKhachhangDelete]
@NhomKhachhangId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenNhomKhachhang NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[NhomKhachhang]
	WHERE [NhomKhachhangId] = @NhomKhachhangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [NhomKhachhang] where [NhomKhachhangId] = @NhomKhachhangId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_NhomKhachhangInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhomKhachhangInsert]
@NhomKhachhangId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenNhomKhachhang NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [NhomKhachhang]([NhomKhachhangId], [Step], [NgayCapnhat], [Active], [Code], [TenNhomKhachhang], [Ghichu]) VALUES (@NhomKhachhangId, @Step, @NgayCapnhat, @Active, @Code, @TenNhomKhachhang, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [NhomKhachhang] where [NhomKhachhangId] = @NhomKhachhangId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NhomKhachhangSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhomKhachhangSelect]
as
begin
	select * from [NhomKhachhang]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_NhomKhachhangUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_NhomKhachhangUpdate]
@NhomKhachhangId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenNhomKhachhang NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [NhomKhachhang]
	SET 
	[Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [Code] = @Code, [TenNhomKhachhang] = @TenNhomKhachhang, [Ghichu] = @Ghichu
	WHERE [NhomKhachhangId] = @NhomKhachhangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [NhomKhachhang] where [NhomKhachhangId] = @NhomKhachhangId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_PhieunhapDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhieunhapDelete]
@PhieunhapId UniqueIdentifier, @NhanvienId UniqueIdentifier, @KhoId UniqueIdentifier, @NhacungcapId UniqueIdentifier, @Step Int, @Ngaylap DateTime, @Code NVarChar(40), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[Phieunhap]
	WHERE [PhieunhapId] = @PhieunhapId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Phieunhap] where [PhieunhapId] = @PhieunhapId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_PhieunhapInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhieunhapInsert]
@PhieunhapId UniqueIdentifier, @NhanvienId UniqueIdentifier, @KhoId UniqueIdentifier, @NhacungcapId UniqueIdentifier, @Step Int, @Ngaylap DateTime, @Code NVarChar(40), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [Phieunhap]([PhieunhapId], [NhanvienId], [KhoId], [NhacungcapId], [Step], [Ngaylap], [Code], [Ghichu]) VALUES (@PhieunhapId, @NhanvienId, @KhoId, @NhacungcapId, @Step, @Ngaylap, @Code, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Phieunhap] where [PhieunhapId] = @PhieunhapId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_PhieunhapSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhieunhapSelect]
as
begin
	select * from [Phieunhap]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_PhieunhapUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhieunhapUpdate]
@PhieunhapId UniqueIdentifier, @NhanvienId UniqueIdentifier, @KhoId UniqueIdentifier, @NhacungcapId UniqueIdentifier, @Step Int, @Ngaylap DateTime, @Code NVarChar(40), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [Phieunhap]
	SET 
	[NhanvienId] = @NhanvienId, [KhoId] = @KhoId, [NhacungcapId] = @NhacungcapId, [Step] = @Step, [Ngaylap] = @Ngaylap, [Code] = @Code, [Ghichu] = @Ghichu
	WHERE [PhieunhapId] = @PhieunhapId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Phieunhap] where [PhieunhapId] = @PhieunhapId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_PhieuxuatDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhieuxuatDelete]
@PhieuxuatId UniqueIdentifier, @NhanvienLapId UniqueIdentifier, @KhoId UniqueIdentifier, @DonhangId UniqueIdentifier, @NhanvienGiaohangId UniqueIdentifier, @NguyennhanLydo UniqueIdentifier, @TinhtrangPhieuxuatCurrentId UniqueIdentifier, @NhanvienDonhang UniqueIdentifier, @Step Int, @Ngaylap DateTime, @NgayCapnhat DateTime, @Tongtien Float, @Code NVarChar(40), @TenTinhtrangPhieuxuat NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[Phieuxuat]
	WHERE [PhieuxuatId] = @PhieuxuatId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Phieuxuat] where [PhieuxuatId] = @PhieuxuatId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_PhieuxuatInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhieuxuatInsert]
@PhieuxuatId UniqueIdentifier, @NhanvienLapId UniqueIdentifier, @KhoId UniqueIdentifier, @DonhangId UniqueIdentifier, @NhanvienGiaohangId UniqueIdentifier, @NguyennhanLydo UniqueIdentifier, @TinhtrangPhieuxuatCurrentId UniqueIdentifier, @NhanvienDonhang UniqueIdentifier, @Step Int, @Ngaylap DateTime, @NgayCapnhat DateTime, @Tongtien Float, @Code NVarChar(40), @TenTinhtrangPhieuxuat NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [Phieuxuat]([PhieuxuatId], [NhanvienLapId], [KhoId], [DonhangId], [NhanvienGiaohangId], [NguyennhanLydo], [TinhtrangPhieuxuatCurrentId], [NhanvienDonhang], [Step], [Ngaylap], [NgayCapnhat], [Tongtien], [Code], [TenTinhtrangPhieuxuat], [Ghichu]) VALUES (@PhieuxuatId, @NhanvienLapId, @KhoId, @DonhangId, @NhanvienGiaohangId, @NguyennhanLydo, @TinhtrangPhieuxuatCurrentId, @NhanvienDonhang, @Step, @Ngaylap, @NgayCapnhat, @Tongtien, @Code, @TenTinhtrangPhieuxuat, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Phieuxuat] where [PhieuxuatId] = @PhieuxuatId	
set @Version = @Ver
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_PhieuxuatSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhieuxuatSelect]
as
begin
	select * from [Phieuxuat]
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_PhieuxuatUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhieuxuatUpdate]
@PhieuxuatId UniqueIdentifier, @NhanvienLapId UniqueIdentifier, @KhoId UniqueIdentifier, @DonhangId UniqueIdentifier, @NhanvienGiaohangId UniqueIdentifier, @NguyennhanLydo UniqueIdentifier, @TinhtrangPhieuxuatCurrentId UniqueIdentifier, @NhanvienDonhang UniqueIdentifier, @Step Int, @Ngaylap DateTime, @NgayCapnhat DateTime, @Tongtien Float, @Code NVarChar(40), @TenTinhtrangPhieuxuat NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [Phieuxuat]
	SET 
	[NhanvienLapId] = @NhanvienLapId, [KhoId] = @KhoId, [DonhangId] = @DonhangId, [NhanvienGiaohangId] = @NhanvienGiaohangId, [NguyennhanLydo] = @NguyennhanLydo, [TinhtrangPhieuxuatCurrentId] = @TinhtrangPhieuxuatCurrentId, [NhanvienDonhang] = @NhanvienDonhang, [Step] = @Step, [Ngaylap] = @Ngaylap, [NgayCapnhat] = @NgayCapnhat, [Tongtien] = @Tongtien, [Code] = @Code, [TenTinhtrangPhieuxuat] = @TenTinhtrangPhieuxuat, [Ghichu] = @Ghichu
	WHERE [PhieuxuatId] = @PhieuxuatId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Phieuxuat] where [PhieuxuatId] = @PhieuxuatId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_PhongbanDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhongbanDelete]
@PhongbanId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(100), @TenPhongban NVarChar(200), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[Phongban]
	WHERE [PhongbanId] = @PhongbanId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Phongban] where [PhongbanId] = @PhongbanId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_PhongbanInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhongbanInsert]
@PhongbanId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(100), @TenPhongban NVarChar(200), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [Phongban]([PhongbanId], [Step], [NgayCapnhat], [Active], [Code], [TenPhongban], [Ghichu]) VALUES (@PhongbanId, @Step, @NgayCapnhat, @Active, @Code, @TenPhongban, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Phongban] where [PhongbanId] = @PhongbanId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_PhongbanSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhongbanSelect]
as
begin
	select * from [Phongban]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_PhongbanUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_PhongbanUpdate]
@PhongbanId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(100), @TenPhongban NVarChar(200), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [Phongban]
	SET 
	[Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [Code] = @Code, [TenPhongban] = @TenPhongban, [Ghichu] = @Ghichu
	WHERE [PhongbanId] = @PhongbanId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Phongban] where [PhongbanId] = @PhongbanId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_QuanhuyenDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_QuanhuyenDelete]
@QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenQuanhuyen NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[Quanhuyen]
	WHERE [QuanhuyenId] = @QuanhuyenId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Quanhuyen] where [QuanhuyenId] = @QuanhuyenId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_QuanhuyenInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_QuanhuyenInsert]
@QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenQuanhuyen NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [Quanhuyen]([QuanhuyenId], [TinhthanhId], [Step], [NgayCapnhat], [Active], [Code], [TenQuanhuyen], [Ghichu]) VALUES (@QuanhuyenId, @TinhthanhId, @Step, @NgayCapnhat, @Active, @Code, @TenQuanhuyen, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Quanhuyen] where [QuanhuyenId] = @QuanhuyenId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_QuanhuyenSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_QuanhuyenSelect]
as
begin
	select * from [Quanhuyen]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_QuanhuyenUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_QuanhuyenUpdate]
@QuanhuyenId UniqueIdentifier, @TinhthanhId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenQuanhuyen NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [Quanhuyen]
	SET 
	[TinhthanhId] = @TinhthanhId, [Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [Code] = @Code, [TenQuanhuyen] = @TenQuanhuyen, [Ghichu] = @Ghichu
	WHERE [QuanhuyenId] = @QuanhuyenId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Quanhuyen] where [QuanhuyenId] = @QuanhuyenId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_sysdiagramsDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_sysdiagramsDelete]
@principal_id Int, @diagram_id Int, @version Int, @definition VarBinary, @name NVarChar(256)
as
begin
	DELETE 	From 	[sysdiagrams]
	WHERE [diagram_id] = @diagram_id 

	
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_sysdiagramsInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_sysdiagramsInsert]
@principal_id Int, @diagram_id Int, @version Int, @definition VarBinary, @name NVarChar(256)
as
begin
	INSERT INTO [sysdiagrams]([principal_id], [version], [definition], [name]) VALUES (@principal_id, @version, @definition, @name)
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_sysdiagramsSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_sysdiagramsSelect]
as
begin
	select * from [sysdiagrams]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_sysdiagramsUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_sysdiagramsUpdate]
@principal_id Int, @diagram_id Int, @version Int, @definition VarBinary, @name NVarChar(256)
as
begin
	UPDATE [sysdiagrams]
	SET 
	[principal_id] = @principal_id, [version] = @version, [definition] = @definition, [name] = @name
	WHERE [diagram_id] = @diagram_id 

	
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_ThuchiDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ThuchiDelete]
@ThuchiId UniqueIdentifier, @NhanvienId UniqueIdentifier, @PhieunhapId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @NhannopTienId UniqueIdentifier, @Ngay Int, @Thang Int, @Nam Int, @Step Int, @Vaoluc DateTime, @Tongtien Float, @Ghichu NVarChar(100), @TenNhannopTien NVarChar(200), @Version Timestamp output
as
begin
	DELETE 	From 	[Thuchi]
	WHERE [ThuchiId] = @ThuchiId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Thuchi] where [ThuchiId] = @ThuchiId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_ThuchiInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ThuchiInsert]
@ThuchiId UniqueIdentifier, @NhanvienId UniqueIdentifier, @PhieunhapId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @NhannopTienId UniqueIdentifier, @Ngay Int, @Thang Int, @Nam Int, @Step Int, @Vaoluc DateTime, @Tongtien Float, @Ghichu NVarChar(100), @TenNhannopTien NVarChar(200), @Version Timestamp output
as
begin
	INSERT INTO [Thuchi]([ThuchiId], [NhanvienId], [PhieunhapId], [PhieuxuatId], [NhannopTienId], [Ngay], [Thang], [Nam], [Step], [Vaoluc], [Tongtien], [Ghichu], [TenNhannopTien]) VALUES (@ThuchiId, @NhanvienId, @PhieunhapId, @PhieuxuatId, @NhannopTienId, @Ngay, @Thang, @Nam, @Step, @Vaoluc, @Tongtien, @Ghichu, @TenNhannopTien)	
declare @Ver timestamp	
select @Ver = [Version] from [Thuchi] where [ThuchiId] = @ThuchiId	
set @Version = @Ver
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_ThuchiSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ThuchiSelect]
as
begin
	select * from [Thuchi]
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_ThuchiUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ThuchiUpdate]
@ThuchiId UniqueIdentifier, @NhanvienId UniqueIdentifier, @PhieunhapId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @NhannopTienId UniqueIdentifier, @Ngay Int, @Thang Int, @Nam Int, @Step Int, @Vaoluc DateTime, @Tongtien Float, @Ghichu NVarChar(100), @TenNhannopTien NVarChar(200), @Version Timestamp output
as
begin
	UPDATE [Thuchi]
	SET 
	[NhanvienId] = @NhanvienId, [PhieunhapId] = @PhieunhapId, [PhieuxuatId] = @PhieuxuatId, [NhannopTienId] = @NhannopTienId, [Ngay] = @Ngay, [Thang] = @Thang, [Nam] = @Nam, [Step] = @Step, [Vaoluc] = @Vaoluc, [Tongtien] = @Tongtien, [Ghichu] = @Ghichu, [TenNhannopTien] = @TenNhannopTien
	WHERE [ThuchiId] = @ThuchiId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Thuchi] where [ThuchiId] = @ThuchiId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_ThuoctinhHanghoaDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ThuoctinhHanghoaDelete]
@ThuoctinhHanghoaId UniqueIdentifier, @HanghoaId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenThuoctinh NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[ThuoctinhHanghoa]
	WHERE [ThuoctinhHanghoaId] = @ThuoctinhHanghoaId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [ThuoctinhHanghoa] where [ThuoctinhHanghoaId] = @ThuoctinhHanghoaId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_ThuoctinhHanghoaInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ThuoctinhHanghoaInsert]
@ThuoctinhHanghoaId UniqueIdentifier, @HanghoaId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenThuoctinh NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [ThuoctinhHanghoa]([ThuoctinhHanghoaId], [HanghoaId], [Step], [NgayCapnhat], [Active], [Code], [TenThuoctinh], [Ghichu]) VALUES (@ThuoctinhHanghoaId, @HanghoaId, @Step, @NgayCapnhat, @Active, @Code, @TenThuoctinh, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [ThuoctinhHanghoa] where [ThuoctinhHanghoaId] = @ThuoctinhHanghoaId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_ThuoctinhHanghoaSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ThuoctinhHanghoaSelect]
as
begin
	select * from [ThuoctinhHanghoa]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_ThuoctinhHanghoaUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_ThuoctinhHanghoaUpdate]
@ThuoctinhHanghoaId UniqueIdentifier, @HanghoaId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenThuoctinh NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [ThuoctinhHanghoa]
	SET 
	[HanghoaId] = @HanghoaId, [Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [Code] = @Code, [TenThuoctinh] = @TenThuoctinh, [Ghichu] = @Ghichu
	WHERE [ThuoctinhHanghoaId] = @ThuoctinhHanghoaId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [ThuoctinhHanghoa] where [ThuoctinhHanghoaId] = @ThuoctinhHanghoaId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_TinhthanhDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhthanhDelete]
@TinhthanhId UniqueIdentifier, @KhuvucId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenTinhthanh NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[Tinhthanh]
	WHERE [TinhthanhId] = @TinhthanhId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Tinhthanh] where [TinhthanhId] = @TinhthanhId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_TinhthanhInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhthanhInsert]
@TinhthanhId UniqueIdentifier, @KhuvucId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenTinhthanh NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [Tinhthanh]([TinhthanhId], [KhuvucId], [Step], [NgayCapnhat], [Active], [Code], [TenTinhthanh], [Ghichu]) VALUES (@TinhthanhId, @KhuvucId, @Step, @NgayCapnhat, @Active, @Code, @TenTinhthanh, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Tinhthanh] where [TinhthanhId] = @TinhthanhId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_TinhthanhSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhthanhSelect]
as
begin
	select * from [Tinhthanh]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_TinhthanhUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhthanhUpdate]
@TinhthanhId UniqueIdentifier, @KhuvucId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @Code NVarChar(40), @TenTinhthanh NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [Tinhthanh]
	SET 
	[KhuvucId] = @KhuvucId, [Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [Code] = @Code, [TenTinhthanh] = @TenTinhthanh, [Ghichu] = @Ghichu
	WHERE [TinhthanhId] = @TinhthanhId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Tinhthanh] where [TinhthanhId] = @TinhthanhId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangDelete]
@TinhtrangId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @CanDelete Bit, @Code NVarChar(100), @TenTinhtrang NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[Tinhtrang]
	WHERE [TinhtrangId] = @TinhtrangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Tinhtrang] where [TinhtrangId] = @TinhtrangId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangDonhangDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangDonhangDelete]
@TinhtrangDonhangId UniqueIdentifier, @DonhangId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @NhanvienCapnhatId UniqueIdentifier, @NgayCapnhat DateTime, @Ghichu NVarChar(200), @Version Timestamp output
as
begin
	DELETE 	From 	[TinhtrangDonhang]
	WHERE [TinhtrangDonhangId] = @TinhtrangDonhangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [TinhtrangDonhang] where [TinhtrangDonhangId] = @TinhtrangDonhangId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangDonhangInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangDonhangInsert]
@TinhtrangDonhangId UniqueIdentifier, @DonhangId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @NhanvienCapnhatId UniqueIdentifier, @NgayCapnhat DateTime, @Ghichu NVarChar(200), @Version Timestamp output
as
begin
	INSERT INTO [TinhtrangDonhang]([TinhtrangDonhangId], [DonhangId], [PhieuxuatId], [NhanvienCapnhatId], [NgayCapnhat], [Ghichu]) VALUES (@TinhtrangDonhangId, @DonhangId, @PhieuxuatId, @NhanvienCapnhatId, @NgayCapnhat, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [TinhtrangDonhang] where [TinhtrangDonhangId] = @TinhtrangDonhangId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangDonhangSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangDonhangSelect]
as
begin
	select * from [TinhtrangDonhang]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangDonhangUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangDonhangUpdate]
@TinhtrangDonhangId UniqueIdentifier, @DonhangId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @NhanvienCapnhatId UniqueIdentifier, @NgayCapnhat DateTime, @Ghichu NVarChar(200), @Version Timestamp output
as
begin
	UPDATE [TinhtrangDonhang]
	SET 
	[DonhangId] = @DonhangId, [PhieuxuatId] = @PhieuxuatId, [NhanvienCapnhatId] = @NhanvienCapnhatId, [NgayCapnhat] = @NgayCapnhat, [Ghichu] = @Ghichu
	WHERE [TinhtrangDonhangId] = @TinhtrangDonhangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [TinhtrangDonhang] where [TinhtrangDonhangId] = @TinhtrangDonhangId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangInsert]
@TinhtrangId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @CanDelete Bit, @Code NVarChar(100), @TenTinhtrang NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [Tinhtrang]([TinhtrangId], [Step], [NgayCapnhat], [Active], [CanDelete], [Code], [TenTinhtrang], [Ghichu]) VALUES (@TinhtrangId, @Step, @NgayCapnhat, @Active, @CanDelete, @Code, @TenTinhtrang, @Ghichu)	
declare @Ver timestamp	
select @Ver = [Version] from [Tinhtrang] where [TinhtrangId] = @TinhtrangId	
set @Version = @Ver
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangPhieuxuatDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangPhieuxuatDelete]
@TinhtrangPhieuxuatId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @TinhtrangId UniqueIdentifier, @NhanvienCapnhatId UniqueIdentifier, @NgayCapnhat DateTime, @GhichuLydo NVarChar(100), @Version Timestamp output
as
begin
	DELETE 	From 	[TinhtrangPhieuxuat]
	WHERE [TinhtrangPhieuxuatId] = @TinhtrangPhieuxuatId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [TinhtrangPhieuxuat] where [TinhtrangPhieuxuatId] = @TinhtrangPhieuxuatId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangPhieuxuatInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangPhieuxuatInsert]
@TinhtrangPhieuxuatId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @TinhtrangId UniqueIdentifier, @NhanvienCapnhatId UniqueIdentifier, @NgayCapnhat DateTime, @GhichuLydo NVarChar(100), @Version Timestamp output
as
begin
	INSERT INTO [TinhtrangPhieuxuat]([TinhtrangPhieuxuatId], [PhieuxuatId], [TinhtrangId], [NhanvienCapnhatId], [NgayCapnhat], [GhichuLydo]) VALUES (@TinhtrangPhieuxuatId, @PhieuxuatId, @TinhtrangId, @NhanvienCapnhatId, @NgayCapnhat, @GhichuLydo)	
declare @Ver timestamp	
select @Ver = [Version] from [TinhtrangPhieuxuat] where [TinhtrangPhieuxuatId] = @TinhtrangPhieuxuatId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangPhieuxuatSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangPhieuxuatSelect]
as
begin
	select * from [TinhtrangPhieuxuat]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangPhieuxuatUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangPhieuxuatUpdate]
@TinhtrangPhieuxuatId UniqueIdentifier, @PhieuxuatId UniqueIdentifier, @TinhtrangId UniqueIdentifier, @NhanvienCapnhatId UniqueIdentifier, @NgayCapnhat DateTime, @GhichuLydo NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [TinhtrangPhieuxuat]
	SET 
	[PhieuxuatId] = @PhieuxuatId, [TinhtrangId] = @TinhtrangId, [NhanvienCapnhatId] = @NhanvienCapnhatId, [NgayCapnhat] = @NgayCapnhat, [GhichuLydo] = @GhichuLydo
	WHERE [TinhtrangPhieuxuatId] = @TinhtrangPhieuxuatId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [TinhtrangPhieuxuat] where [TinhtrangPhieuxuatId] = @TinhtrangPhieuxuatId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangSelect]
as
begin
	select * from [Tinhtrang]
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_TinhtrangUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TinhtrangUpdate]
@TinhtrangId UniqueIdentifier, @Step Int, @NgayCapnhat DateTime, @Active Bit, @CanDelete Bit, @Code NVarChar(100), @TenTinhtrang NVarChar(100), @Ghichu NVarChar(100), @Version Timestamp output
as
begin
	UPDATE [Tinhtrang]
	SET 
	[Step] = @Step, [NgayCapnhat] = @NgayCapnhat, [Active] = @Active, [CanDelete] = @CanDelete, [Code] = @Code, [TenTinhtrang] = @TenTinhtrang, [Ghichu] = @Ghichu
	WHERE [TinhtrangId] = @TinhtrangId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Tinhtrang] where [TinhtrangId] = @TinhtrangId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_TonkhoDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TonkhoDelete]
@TonkhoId UniqueIdentifier, @HanghoaId UniqueIdentifier, @KhoId UniqueIdentifier, @NhanvienCapnhat UniqueIdentifier, @Ngay Int, @Thang Int, @Nam Int, @SoduDauky Int, @SoluongNhap Int, @SoluongXuat Int, @SoluongTon Int, @Step Int, @SoluongTonDukien Int, @NgayCapnhat DateTime, @GioCapnhat DateTime, @ThanhtienNhap Float, @ThanhtienXuat Float, @Active Bit, @Version Timestamp output
as
begin
	DELETE 	From 	[Tonkho]
	WHERE [TonkhoId] = @TonkhoId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Tonkho] where [TonkhoId] = @TonkhoId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_TonkhoInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TonkhoInsert]
@TonkhoId UniqueIdentifier, @HanghoaId UniqueIdentifier, @KhoId UniqueIdentifier, @NhanvienCapnhat UniqueIdentifier, @Ngay Int, @Thang Int, @Nam Int, @SoduDauky Int, @SoluongNhap Int, @SoluongXuat Int, @SoluongTon Int, @Step Int, @SoluongTonDukien Int, @NgayCapnhat DateTime, @GioCapnhat DateTime, @ThanhtienNhap Float, @ThanhtienXuat Float, @Active Bit, @Version Timestamp output
as
begin
	INSERT INTO [Tonkho]([TonkhoId], [HanghoaId], [KhoId], [NhanvienCapnhat], [Ngay], [Thang], [Nam], [SoduDauky], [SoluongNhap], [SoluongXuat], [SoluongTon], [Step], [SoluongTonDukien], [NgayCapnhat], [GioCapnhat], [ThanhtienNhap], [ThanhtienXuat], [Active]) VALUES (@TonkhoId, @HanghoaId, @KhoId, @NhanvienCapnhat, @Ngay, @Thang, @Nam, @SoduDauky, @SoluongNhap, @SoluongXuat, @SoluongTon, @Step, @SoluongTonDukien, @NgayCapnhat, @GioCapnhat, @ThanhtienNhap, @ThanhtienXuat, @Active)	
declare @Ver timestamp	
select @Ver = [Version] from [Tonkho] where [TonkhoId] = @TonkhoId	
set @Version = @Ver
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_TonkhoSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TonkhoSelect]
as
begin
	select * from [Tonkho]
end	
GO
/****** Object:  StoredProcedure [dbo].[sys_TonkhoUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_TonkhoUpdate]
@TonkhoId UniqueIdentifier, @HanghoaId UniqueIdentifier, @KhoId UniqueIdentifier, @NhanvienCapnhat UniqueIdentifier, @Ngay Int, @Thang Int, @Nam Int, @SoduDauky Int, @SoluongNhap Int, @SoluongXuat Int, @SoluongTon Int, @Step Int, @SoluongTonDukien Int, @NgayCapnhat DateTime, @GioCapnhat DateTime, @ThanhtienNhap Float, @ThanhtienXuat Float, @Active Bit, @Version Timestamp output
as
begin
	UPDATE [Tonkho]
	SET 
	[HanghoaId] = @HanghoaId, [KhoId] = @KhoId, [NhanvienCapnhat] = @NhanvienCapnhat, [Ngay] = @Ngay, [Thang] = @Thang, [Nam] = @Nam, [SoduDauky] = @SoduDauky, [SoluongNhap] = @SoluongNhap, [SoluongXuat] = @SoluongXuat, [SoluongTon] = @SoluongTon, [Step] = @Step, [SoluongTonDukien] = @SoluongTonDukien, [NgayCapnhat] = @NgayCapnhat, [GioCapnhat] = @GioCapnhat, [ThanhtienNhap] = @ThanhtienNhap, [ThanhtienXuat] = @ThanhtienXuat, [Active] = @Active
	WHERE [TonkhoId] = @TonkhoId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [Tonkho] where [TonkhoId] = @TonkhoId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_UserDelete]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_UserDelete]
@UserId UniqueIdentifier, @NhanvienId UniqueIdentifier, @Step Int, @Active Bit, @_Username NVarChar(500), @_Password NVarChar(500), @Version Timestamp output
as
begin
	DELETE 	From 	[User]
	WHERE [UserId] = @UserId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [User] where [UserId] = @UserId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[sys_UserInsert]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_UserInsert]
@UserId UniqueIdentifier, @NhanvienId UniqueIdentifier, @Step Int, @Active Bit, @_Username NVarChar(500), @_Password NVarChar(500), @Version Timestamp output
as
begin
	INSERT INTO [User]([UserId], [NhanvienId], [Step], [Active], [_Username], [_Password]) VALUES (@UserId, @NhanvienId, @Step, @Active, @_Username, @_Password)	
declare @Ver timestamp	
select @Ver = [Version] from [User] where [UserId] = @UserId	
set @Version = @Ver
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_UserSelect]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_UserSelect]
as
begin
	select * from [User]
end	

GO
/****** Object:  StoredProcedure [dbo].[sys_UserUpdate]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sys_UserUpdate]
@UserId UniqueIdentifier, @NhanvienId UniqueIdentifier, @Step Int, @Active Bit, @_Username NVarChar(500), @_Password NVarChar(500), @Version Timestamp output
as
begin
	UPDATE [User]
	SET 
	[NhanvienId] = @NhanvienId, [Step] = @Step, [Active] = @Active, [_Username] = @_Username, [_Password] = @_Password
	WHERE [UserId] = @UserId AND [Version] = @Version 

		
declare @Ver timestamp	
select @Ver = [Version] from [User] where [UserId] = @UserId	
set @Version = @Ver
end	


GO
/****** Object:  StoredProcedure [dbo].[Tin_CheckLogin]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[Tin_CheckLogin] 
@accountname nvarchar(250), @accountpassword nvarchar(250)
as
begin
	SELECT [AccountId]
      ,[AccountName]
      ,[AccountPassword]
  FROM [QLBH_08_2014].[dbo].[Account]
  WHERE ([AccountName]=@accountname AND [AccountPassword]=@accountpassword)
end
GO
/****** Object:  StoredProcedure [dbo].[Tin_DeletePhieunhap]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tin_DeletePhieunhap]
@PhieunhapId uniqueidentifier
as
begin
delete from ChitietPhieunhap  where PhieunhapID=@PhieunhapId
delete from Phieunhap where PhieunhapId=@PhieunhapId
end


GO
/****** Object:  StoredProcedure [dbo].[Tin_GetChitietPhieunhapTheoPhieunhap]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tin_GetChitietPhieunhapTheoPhieunhap]
	@PhieunhapId uniqueidentifier
as
begin
select ChitietPhieunhapId,
		a.PhieunhapId,
		a.HanghoaId,
		b.TenHanghoa,
		a.Soluong,
		a.Barcode,
		a.NSX,
		a.HSD,
		a.Gianhap,
		a.Thanhtien,
		a.Ghichu,
		a.Step,
		a.Version
from ChitietPhieunhap a left join Hanghoa b on a.HanghoaId=b.HanghoaId
where a.PhieunhapId=@PhieunhapId
end
GO
/****** Object:  StoredProcedure [dbo].[Tin_GetHanghoaActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tin_GetHanghoaActive]
as
	select [HanghoaId]
      ,[Code]
      ,[TenHanghoa]
	  ,[NhomhanghoaId]
	  ,[Barcode]
	  ,[Giagoc]
	  ,[DonviId]
	  ,[LinkHinhanh]
      ,[Ghichu]
      ,[Active]
      ,[Step]
      ,[Version]
      ,[NgayCapnhat]
	from Hanghoa t
	where t.Active=1

GO
/****** Object:  StoredProcedure [dbo].[Tin_GetHanghoaTheoKho]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tin_GetHanghoaTheoKho]
@KhoId uniqueidentifier
as
begin
	select  a.[HanghoaId]
      ,a.[Code]
      ,a.[TenHanghoa]
      ,a.[NhomHanghoaId]
      ,a.[Giagoc]
      ,a.[Barcode]
      ,a.[DonviId]
      ,a.[LinkHinhanh]
      ,a.[Ghichu]
      ,a.[Active]
      ,a.[Step]
      ,a.[Version]
      ,a.[NgayCapnhat]
	  from Hanghoa a left join Tonkho b on a.HanghoaId = b.HanghoaId 
	  where b.KhoId = @KhoId
end
GO
/****** Object:  StoredProcedure [dbo].[Tin_GetNhomKhachhangActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tin_GetNhomKhachhangActive]
as
	select [NhomKhachhangId]
      ,[Code]
      ,[TenNhomKhachhang]
      ,[Ghichu]
      ,[Active]
      ,[Step]
      ,[Version]
      ,[NgayCapnhat]
	from NhomKhachhang t
	where t.Active=1


GO
/****** Object:  StoredProcedure [dbo].[Tin_GetPhieunhapTheoThang_Kho]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tin_GetPhieunhapTheoThang_Kho]
	@Ngaylap datetime,
	@KhoId uniqueidentifier
as
begin
	declare @thang int,@nam int
	set @thang=Month(@Ngaylap)
	set @nam=Year(@Ngaylap)

	select  d.PhieunhapId
      ,d.Code
      ,d.NhanvienId
	  ,d.KhoId
	  ,d.NhaCungcapId
	  ,d.Ngaylap
      ,d.Ghichu
      ,d.Step
      ,d.Version
	  ,n.HovatenNhanvien as TenNhanvien
	  ,k.TenKho
	  ,h.TenNhaCungcap
	from Phieunhap d left join Nhanvien n on d.NhanvienId=n.NhanvienId
				left join Nhanvien nv on d.NhanvienId=nv.NhanvienId
				left join Kho k on d.KhoId=k.KhoId
				left join NhaCungcap h on d.NhacungcapId=h.NhaCungcapId
	where Month(d.Ngaylap)=@thang and Year(d.Ngaylap)=@nam
	and d.KhoId=@KhoId or (@KhoId=N'00000000-0000-0000-0000-000000000000')
end


GO
/****** Object:  StoredProcedure [dbo].[Tin_GetSoluongtonTheoHanghoaTrongKho]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tin_GetSoluongtonTheoHanghoaTrongKho]
@KhoId UniqueIdentifier,
@HanghoaId UniqueIdentifier
as
begin
SELECT [TonkhoId]
      ,[HanghoaId]
      ,[KhoId]
      ,[Ngay]
      ,[Thang]
      ,[Nam]
      ,[NgayCapnhat]
      ,[GioCapnhat]
      ,[SoduDauky]
      ,[SoluongNhap]
      ,[SoluongXuat]
      ,[SoluongTon]
      ,[NhanvienCapnhat]
      ,[Step]
      ,[Version]
      ,[Active]
      ,[SoluongTonDukien]
      ,[ThanhtienNhap]
      ,[ThanhtienXuat]
  FROM [QLBH_08_2014].[dbo].[Tonkho]
  WHERE [KhoId]=@KhoId and [HanghoaId]=@HanghoaId
end

GO
/****** Object:  StoredProcedure [dbo].[Tin_GetThuoctinHanghoaTheoHanghoa]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[Tin_GetThuoctinHanghoaTheoHanghoa]
as
select   d.ThuoctinhHanghoaId
      ,d.Code
      ,d.TenThuoctinh
      ,d.NgayCapnhat
      ,d.HanghoaId
      ,d.Ghichu
      ,d.Active
      ,d.Step
      ,d.Version
	  ,h.TenHanghoa as TenHanghoa
	from ThuoctinhHanghoa d left join Hanghoa h on d.HanghoaId=h.HanghoaId

GO
/****** Object:  StoredProcedure [dbo].[Tin_GetTonkhoMaxHang_Kho]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tin_GetTonkhoMaxHang_Kho]
@KhoId uniqueidentifier,
@HanghoaId uniqueidentifier
as
begin
    
	select Ngay,
	Thang,
	Nam,
	NgayCapnhat,
	GioCapnhat,
	SoduDauky,
	SoluongNhap,
	SoluongXuat,
	SoluongTon,
	NhanvienCapnhat,
	Step,
	Version,
	Active
	from Tonkho
	where KhoId=@KhoId and HanghoaId=@HanghoaId and NgayCapnhat=(select Max(NgayCapnhat) from Tonkho where KhoId=@KhoId and HanghoaId=@HanghoaId)
end
GO
/****** Object:  StoredProcedure [dbo].[Tin_GetTonkhoMoinhatHanghoaTheoKho]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tin_GetTonkhoMoinhatHanghoaTheoKho]
@KhoId uniqueidentifier,
@HanghoaId uniqueidentifier
as
begin
    
	select *
	from Tonkho
	where KhoId=@KhoId and HanghoaId=@HanghoaId and NgayCapnhat=(select Max(NgayCapnhat) from Tonkho where KhoId=@KhoId and HanghoaId=@HanghoaId)
end
GO
/****** Object:  StoredProcedure [dbo].[Tin_SelectChitietKiemkeTheoKiemke]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tin_SelectChitietKiemkeTheoKiemke]
@KiemkeId UniqueIdentifier
as
begin
SELECT ct.[ChitietKiemkeId]
      ,ct.[KiemkeId]
      ,ct.[HanghoaId]
      ,ct.[TenHanghoa]
      ,ct.[SoluongTon]
      ,ct.[SoluongThuc]
      ,ct.[Ghichu]
      ,ct.[Step]
      ,ct.[Version]
  FROM [QLBH_08_2014].[dbo].[ChitietKiemke] ct
  where ct.KiemkeId=@KiemkeId
end 
GO
/****** Object:  StoredProcedure [dbo].[Tin_SelectCongnoNhap]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tin_SelectCongnoNhap]
as
begin
SELECT a.[CongnoNhapId]
      ,a.[NhaCungcapId]
      ,a.[NgayGiaodich]
      ,a.[SoduTruocGiaodich]
      ,a.[SotienGiaodich]
      ,a.[Tongno]
      ,a.[NgayHentra]
      ,a.[NhanvienId]
      ,a.[Ghichu]
      ,a.[Step]
      ,a.[Version]
	  ,b.TenNhaCungcap
	  ,c.TenNhanvien
  FROM ([QLBH_08_2014].[dbo].[CongnoNhap] a left join NhaCungcap b on a.NhaCungcapId=b.NhaCungcapId) left join Nhanvien c on a.NhanvienId=c.NhanvienId
end
GO
/****** Object:  StoredProcedure [dbo].[Tin_SelectKiemkeTheoKho]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tin_SelectKiemkeTheoKho]
@KhoId UniqueIdentifier
as
begin
SELECT a.[KiemkeId]
      ,a.[Code]
      ,a.[KhoId]
	  ,b.TenKho
      ,a.[Ngaylap]
      ,a.[NhanvienId]
	  ,c.[TenNhanvien]
      ,a.[Step]
      ,a.[Version]
      ,a.[Active]
  FROM Kiemke a left join Kho b on b.KhoId=a.KhoId
				left join Nhanvien c on c.NhanvienId=a.NhanvienId
  WHERE a.KhoId=@KhoId
  end

GO
/****** Object:  StoredProcedure [dbo].[Tri_GetChitietDonhangTheoDonhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tri_GetChitietDonhangTheoDonhang]
	@DonhangId uniqueidentifier
as
begin
	select *
	from ChitietDonhang ct
	where ct.DonhangId=@DonhangId
end
	

GO
/****** Object:  StoredProcedure [dbo].[Tri_GetDongiaTheoNhomKhachhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetDongiaTheoNhomKhachhang]
@NhomKhachhangId uniqueidentifier
as
	select   d.DongiaId
      ,d.Code
      ,d.Dongia
      ,d.NgayCapnhat
      ,d.ApdungTu
      ,d.HanghoaId
      ,d.NhomKhachhangId
      ,d.Ghichu
      ,d.Active
      ,d.Step
      ,d.Version
	  ,h.TenHanghoa as TenHanghoa
	  ,k.TenNhomKhachhang as TenNhomKhachhang
	from (Dongia d left join Hanghoa h on d.HanghoaId=h.HanghoaId) left join NhomKhachhang k on k.NhomKhachhangId=d.NhomKhachhangId
	where (d.NhomKhachhangId=@NhomKhachhangId)




GO
/****** Object:  StoredProcedure [dbo].[Tri_GetDonhangTheoThang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetDonhangTheoThang]
	@Ngaylap datetime,@LoaiDonhangValue int
as
begin
	declare @thang int,@nam int
	set @thang=Month(@Ngaylap)
	set @nam=Year(@Ngaylap)

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
	where Month(d.Ngaylap)=@thang and Year(d.Ngaylap)=@nam and d.LoaiDonhang=@LoaiDonhangValue or (@LoaiDonhangValue=-1)
end
	

GO
/****** Object:  StoredProcedure [dbo].[Tri_GetHanghoaTheoNhomKhachhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetHanghoaTheoNhomKhachhang]
	@NhomKhachhangId uniqueidentifier
as
	select  h.HanghoaId
      , h.Code
      , h.TenHanghoa
      , h.NhomHanghoaId
      , h.Giagoc
      , h.Barcode
      , h.DonviId
      , h.LinkHinhanh
      , h.Ghichu
      , h.Active
      , h.Step
      , h.Version
      , h.NgayCapnhat
	,(select d.Dongia
				from Dongia d 
				where d.HanghoaId=h.HanghoaId and d.ApdungTu<=Getdate() and d.NhomKhachhangId=@NhomKhachhangId
				group by d.Dongia,d.NgayCapnhat
				having d.NgayCapnhat=max(d.NgayCapnhat)
				) as Dongia,
			n.TenNhomHanghoa as TenNhomHanghoa,
			dv.TenDonvi as TenDonvi
	from Hanghoa h left join NhomHanghoa n on h.NhomHanghoaId=n.NhomHanghoaId
					left join Donvi dv on h.DonviId=dv.DonviId

GO
/****** Object:  StoredProcedure [dbo].[Tri_GetKhachhangDemo]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetKhachhangDemo]
as
	select  k.KhachhangId
      ,k.Code
      ,k.HotenKhachhang
      ,k.CMND
      ,k.Ngaysinh
      ,k.Gioitinh
      ,k.Diachi
      ,k.DiachiGiaohang
      ,k.QuanhuyenId
      ,k.TinhthanhId
      ,k.NhomKhachhangId
      ,k.Linkanh
      ,k.Congty
      ,k.Chucvu
      ,k.Email
      ,k.DiachiCongty
      ,k.PhoneCongty
      ,k.Tel
      ,k.Mobile
      ,k.Fax
      ,k.MasoThue
      ,k.TenTaikhoan
      ,k.SoTaikhoan
      ,k.Nganhang
      ,k.HanmucCongno
      ,k.ThoigianCongno
      ,k.ToahangCongno
      ,k.Ghichu
      ,k.NgayCapnhat
      ,k.Active
      ,k.Step
      ,k.Version
	  ,q.TenQuanhuyen as TenQuanhuyen
	  ,t.TenTinhthanh as TenTinhthanh
	  ,n.TenNhomKhachhang as TenNhomKhachhang
	from Khachhang k left join Quanhuyen q on k.QuanhuyenId= q.QuanhuyenId
					left join Tinhthanh t on k.TinhthanhId=t.TinhthanhId
					left join NhomKhachhang n on k.NhomKhachhangId=n.NhomKhachhangId


GO
/****** Object:  StoredProcedure [dbo].[Tri_GetKhachhangTheoNhomKhachhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetKhachhangTheoNhomKhachhang]
	@NhomKhachhangId uniqueidentifier
as
	select  k.KhachhangId
      ,k.Code
      ,k.HotenKhachhang
      ,k.CMND
      ,k.Ngaysinh
      ,k.Gioitinh
      ,k.Diachi
      ,k.DiachiGiaohang
      ,k.QuanhuyenId
      ,k.TinhthanhId
      ,k.NhomKhachhangId
      ,k.Linkanh
      ,k.Congty
      ,k.Chucvu
      ,k.Email
      ,k.DiachiCongty
      ,k.PhoneCongty
      ,k.Tel
      ,k.Mobile
      ,k.Fax
      ,k.MasoThue
      ,k.TenTaikhoan
      ,k.SoTaikhoan
      ,k.Nganhang
      ,k.HanmucCongno
      ,k.ThoigianCongno
      ,k.ToahangCongno
      ,k.Ghichu
      ,k.NgayCapnhat
      ,k.Active
      ,k.Step
      ,k.Version
	  ,q.TenQuanhuyen as TenQuanhuyen
	  ,t.TenTinhthanh as TenTinhthanh
	  ,n.TenNhomKhachhang as TenNhomKhachhang
	from Khachhang k left join Quanhuyen q on k.QuanhuyenId= q.QuanhuyenId
					left join Tinhthanh t on k.TinhthanhId=t.TinhthanhId
					left join NhomKhachhang n on k.NhomKhachhangId=n.NhomKhachhangId
	where k.NhomKhachhangId=@NhomKhachhangId or @NhomKhachhangId=N'00000000-0000-0000-0000-000000000000'



GO
/****** Object:  StoredProcedure [dbo].[Tri_GetKho]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetKho]
as
	select   k.KhoId
      ,k.Code
      ,k.TenKho
      ,k.Diachi
      ,k.QuanhuyenId
      ,k.TinhthanhId
      ,k.Ghichu
      ,k.NgayCapnhat
      ,k.Active
      ,k.Step
      ,k.Version
	  ,t.TenTinhthanh as TenTinhthanh
	  ,q.TenQuanhuyen as TenQuanhuyen
	from Kho k left join Tinhthanh t on k.TinhthanhId=t.TinhthanhId
			left join Quanhuyen q on k.QuanhuyenId= q.QuanhuyenId



GO
/****** Object:  StoredProcedure [dbo].[Tri_GetKhuvucActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetKhuvucActive]
as
	select [KhuvucId]
      ,[Code]
      ,[TenKhuvuc]
      ,[Active]
      ,[Ghichu]
      ,[Step]
      ,[Version]
      ,[NgayCapnhat]
	from Khuvuc k
	where k.Active=1



GO
/****** Object:  StoredProcedure [dbo].[Tri_GetNhaCungcap]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetNhaCungcap]
as
	select  n.NhaCungcapId
      ,n.Code
      ,n.TenNhaCungcap
      ,n.Diachi
      ,n.QuanhuyenId
      ,n.TinhthanhId
      ,n.TenCongty
      ,n.Fax
      ,n.Tel
      ,n.Mobile
      ,n.Email
      ,n.Website
      ,n.TenTaikhoan
      ,n.SoTaikhoan
      ,n.Nganhang
      ,n.Ghichu
      ,n.Active
      ,n.Step
      ,n.Version
      ,n.NgayCapnhat
	  ,t.TenTinhthanh as TenTinhthanh
	  ,q.TenQuanhuyen as TenQuanhuyen
	from NhaCungcap n left join Tinhthanh t on n.TinhthanhId=t.TinhthanhId
					left join Quanhuyen q on n.QuanhuyenId=q.QuanhuyenId



GO
/****** Object:  StoredProcedure [dbo].[Tri_GetNhanvien]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetNhanvien]
as
	select  n.NhanvienId
      ,n.Code
      ,n.TenNhanvien
      ,n.HoNhanvien
      ,n.HovatenNhanvien
      ,n.CMND
      ,n.Ngaysinh
      ,n.Gioitinh
      ,n.Email
      ,n.Tel
      ,n.Mobile
      ,n.Diachi
      ,n.QuanhuyenId
      ,n.TinhthanhId
      ,n.NgayBatdau
      ,n.NgayKetthuc
      ,n.NgayCapnhat
      ,n.Ghichu
      ,n.Active
      ,n.Step
      ,n.Version
      ,n.Linkanh
	  ,t.TenTinhthanh as TenTinhthanh
	  ,q.TenQuanhuyen as TenQuanhuyen
	from Nhanvien n left join Tinhthanh t on n.TinhthanhId=t.TinhthanhId
				left join Quanhuyen q on n.QuanhuyenId=q.QuanhuyenId



GO
/****** Object:  StoredProcedure [dbo].[Tri_GetNhanvienActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetNhanvienActive]
as
	select *
	from Nhanvien n
	where n.Active=1



GO
/****** Object:  StoredProcedure [dbo].[Tri_GetNhanvienTheoPhongban]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetNhanvienTheoPhongban]
	@PhongbanId uniqueidentifier
as
	select  n.NhanvienId
      ,n.Code
      ,n.TenNhanvien
      ,n.HoNhanvien
      ,n.HovatenNhanvien
      ,n.CMND
      ,n.Ngaysinh
      ,n.Gioitinh
      ,n.Email
      ,n.Tel
      ,n.Mobile
      ,n.Diachi
      ,n.QuanhuyenId
      ,n.TinhthanhId
      ,n.NgayBatdau
      ,n.NgayKetthuc
      ,n.NgayCapnhat
      ,n.Ghichu
      ,n.Active
      ,n.Step
      ,n.Version
      ,n.Linkanh
	  ,t.TenTinhthanh as TenTinhthanh
	  ,q.TenQuanhuyen as TenQuanhuyen
	  ,p.TenPhongban as TenPhongban
	from Nhanvien n left join Tinhthanh t on n.TinhthanhId=t.TinhthanhId
				left join Quanhuyen q on n.QuanhuyenId=q.QuanhuyenId
				left join Phongban p on n.PhongbanId=p.PhongbanId
	where  n.PhongbanId=@PhongbanId or (@PhongbanId=N'00000000-0000-0000-0000-000000000000')

GO
/****** Object:  StoredProcedure [dbo].[Tri_GetNhomKhachhangActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tri_GetNhomKhachhangActive]
as
	select [NhomKhachhangId]
      ,[Code]
      ,[TenNhomKhachhang]
      ,[Ghichu]
      ,[Active]
      ,[Step]
      ,[Version]
      ,[NgayCapnhat]
  FROM [NhomKhachhang] n
  where n.Active=1

GO
/****** Object:  StoredProcedure [dbo].[Tri_GetQuanhuyenActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tri_GetQuanhuyenActive]
as
	select [QuanhuyenId]
      ,[Code]
      ,[TenQuanhuyen]
      ,[Active]
      ,[Ghichu]
      ,[TinhthanhId]
      ,[Step]
      ,[Version]
      ,[NgayCapnhat]
	from Quanhuyen q
	where  q.Active=1



GO
/****** Object:  StoredProcedure [dbo].[Tri_GetQuanhuyenActiveTheoTinhthanh]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetQuanhuyenActiveTheoTinhthanh]
	@TinhthanhId uniqueidentifier
as
	select [QuanhuyenId]
      ,[Code]
      ,[TenQuanhuyen]
      ,[Active]
      ,[Ghichu]
      ,[TinhthanhId]
      ,[Step]
      ,[Version]
      ,[NgayCapnhat]
	from Quanhuyen q
	where  q.TinhthanhId=@TinhthanhId and q.Active=1



GO
/****** Object:  StoredProcedure [dbo].[Tri_GetQuanhuyenTheoTinhthanh]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetQuanhuyenTheoTinhthanh]
	@TinhthanhId uniqueidentifier
as
	select [QuanhuyenId]
      ,[Code]
      ,[TenQuanhuyen]
      ,[Active]
      ,[Ghichu]
      ,[TinhthanhId]
      ,[Step]
      ,[Version]
      ,[NgayCapnhat]
	from Quanhuyen q
	where  q.TinhthanhId=@TinhthanhId



GO
/****** Object:  StoredProcedure [dbo].[Tri_GetThangNamNhapXuat]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tri_GetThangNamNhapXuat]
as
	declare @tempTable table
	(
		inYear int,
		inMonth int,
		onNgay int,
		tongNhap float,
		tongXuat float
	)
	
	--intit when number of rows = 0
	declare @numRow int
	select @numRow=count(*) from @tempTable
	if(@numRow=0) insert into @tempTable(inMonth,inYear,onNgay,tongNhap,tongXuat) values(Month(getdate()),year(getdate()),day(getdate()),0,0) 

	insert into @tempTable
	select tk.Nam as inYear,tk.Thang as inMonth,tk.Ngay as onNgay,sum(tk.ThanhtienNhap) as Tongnhap,sum(tk.ThanhtienXuat) as Tongxuat
	from Tonkho tk
	group by tk.Ngay,tk.Nam,tk.Thang
	order by tk.Ngay,tk.Nam,tk.Thang
	
	declare @minYear int,@maxYear int
	select @minYear=Min(t.inYear),@maxYear=Max(t.inYear) from @tempTable t

	--init value table temple
	while(@minYear<=@maxYear)
	begin
		declare @month int 
		set @month=1
		while(@month<=12)
		begin
			declare @firstDay int,@lastDay int,@d date
			set @d= DATEFROMPARTS(@minYear,@month,6)
			set @firstDay=DAY(DATEADD(dd, -DAY(@d) + 1, @d))
			set @lastDay=DAY(DATEADD(dd, -DAY(@d), DATEADD(mm, 1, @d)))
			while(@firstDay<=@lastDay)
			begin
				if not exists (select * from @tempTable tb where (tb.inMonth=@month and tb.inYear=@minYear and tb.onNgay=@firstDay))
					begin
						insert into @tempTable(inYear,inMonth,onNgay,tongNhap,tongXuat) values(@minYear,@month,@firstDay,0,0)
					end
				set @firstDay=@firstDay+1
			end
			set @month=@month+1
		end
		set @minYear=@minYear+1
	end

	--return table tmp
	select e.inYear,e.inMonth,e.onNgay,e.tongNhap,e.tongXuat from @tempTable e
	order by e.inYear,e.inMonth,e.onNgay
	
	return

GO
/****** Object:  StoredProcedure [dbo].[Tri_GetTinhthanhActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetTinhthanhActive]
as
	select [TinhthanhId]
      ,[Code]
      ,[TenTinhthanh]
      ,[Ghichu]
      ,[Active]
      ,[Step]
      ,[Version]
      ,[KhuvucId]
      ,[NgayCapnhat]
	from Tinhthanh t
	where t.Active=1
	


GO
/****** Object:  StoredProcedure [dbo].[Tri_GetTinhthanhTheoKhuvuc]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetTinhthanhTheoKhuvuc]
	@KhuvucId uniqueidentifier
as
	select [TinhthanhId]
      ,[Code]
      ,[TenTinhthanh]
      ,[Ghichu]
      ,[Active]
      ,[Step]
      ,[Version]
      ,[KhuvucId]
      ,[NgayCapnhat]
	from Tinhthanh t
	where t.Active=1 and t.KhuvucId=@KhuvucId 



GO
/****** Object:  StoredProcedure [dbo].[Tri_GetTinhthanhVoiTenKhuvuc]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tri_GetTinhthanhVoiTenKhuvuc]
as
	select t.TinhthanhId
      ,t.Code
      ,t.TenTinhthanh
      ,t.Ghichu
      ,t.Active
      ,t.Step
      ,t.Version
      ,t.KhuvucId
      ,t.NgayCapnhat
	  ,k.TenKhuvuc as TenKhuvuc
	from Tinhthanh t left join Khuvuc k on t.KhuvucId=k.KhuvucId



GO
/****** Object:  StoredProcedure [dbo].[Tri_GetTinhthanhWithTenKhuvuc]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tri_GetTinhthanhWithTenKhuvuc]
as
	select t.TinhthanhId
      ,t.Code
      ,t.TenTinhthanh
      ,t.Ghichu
      ,t.Active
      ,t.Step
      ,t.Version
      ,t.KhuvucId
      ,t.NgayCapnhat
	  ,k.TenKhuvuc as TenKhuvuc
	from Tinhthanh t join Khuvuc k on t.KhuvucId=k.KhuvucId

GO
/****** Object:  StoredProcedure [dbo].[Tri_GetTinhtrangDalap]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tri_GetTinhtrangDalap]
	@Code nvarchar(50)
as
	select	 tt.TinhtrangId
      ,tt.Code
      ,tt.TenTinhtrang
      ,tt.Ghichu
      ,tt.Active
      ,tt.NgayCapnhat
      ,tt.Step
      ,tt.Version
      ,tt.CanDelete
	from Tinhtrang tt
	where  tt.Code=@Code
GO
/****** Object:  StoredProcedure [dbo].[Tri_GetTonkhoTheoNgay]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Tri_GetTonkhoTheoNgay]
	@Ngay datetime
as
	select h.TenHanghoa
	,sum(t.SoluongNhap) as Tongnhap
	,sum(t.SoluongXuat) as Tongxuat
	,sum(t.ThanhtienNhap) as TongtienNhap
	,sum(t.ThanhtienXuat) as TongtienXuat
	,[dbo].Tri_GetSoduDaukyTheoNgay(h.HanghoaId,@Ngay) as SoduBandau
	,[dbo].Tri_GetSoluongTon(h.HanghoaId,@Ngay) as SoluongTon
	from Hanghoa h left join (select * from Tonkho tk where tk.NgayCapnhat=@Ngay) as t on h.HanghoaId=t.HanghoaId
	group by h.HanghoaId,h.TenHanghoa

GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetChitietDonhangTheoDonHang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Vinh_GetChitietDonhangTheoDonHang]
	@DonhangId uniqueidentifier
as
select cd.[ChitietDonhangId]
      ,cd.[DonhangId]
      ,cd.[HanghoaId]
      ,cd.[TenHanghoa]
      ,cd.[Giaban]
      ,cd.[VAT]
      ,cd.[Soluong]
      ,cd.[Tiengiam]
      ,cd.[PhantramGiam]
      ,cd.[Thanhtien]
      ,cd.[GhichuTrahang]
      ,cd.[SoluongGiao]
      ,cd.[SoluongConlai]
      ,cd.[NgayCapnhat]
      ,cd.[Step]
      ,cd.[Version]
from ChitietDonhang cd
where cd.DonhangId = @DonhangId

GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetChitietPhieuxuatTheoPhieuxuat]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Vinh_GetChitietPhieuxuatTheoPhieuxuat]
	@PhieuxuatId uniqueidentifier
as
select ctpx.[ChitietPhieuxuatId]
      ,ctpx.[PhieuxuatId]
      ,ctpx.[HanghoaId]
      ,ctpx.[Soluong]
      ,ctpx.[Ghichu]
      ,ctpx.[Step]
      ,ctpx.[Version]
      ,ctpx.[ChitietDonhangId]
	  ,ctpx.[Thanhtien]
	  ,hh.TenHanghoa as TenHanghoa
	  ,ctdh.Giaban as Dongia
from ChitietPhieuxuat ctpx left join Hanghoa hh on ctpx.HanghoaId = hh.HanghoaId left join ChitietDonhang ctdh on ctpx.ChitietDonhangId = ctdh.ChitietDonhangId
where ctpx.PhieuxuatId = @PhieuxuatId
	
GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetDonhangTheoDonhangId]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Vinh_GetDonhangTheoDonhangId]
@DonhangId uniqueidentifier
as
	select [DonhangId]
      ,[Code]
      ,[NhanvienId]
      ,[Ngaylap]
      ,[TenTinhtrangDonhang]
      ,[KhoId]
      ,[KhachhangId]
      ,[Ngaygiao]
      ,[DiachiGiao]
      ,[TenTinhthanhGiao]
      ,[TenQuanhuyenGiao]
      ,[SoDienthoai]
      ,[Tiengiam]
      ,[PhantramGiam]
      ,[Tongtien]
      ,[Ghichu]
      ,[LoaiDonhang]
      ,[NhanvienCapnhatId]
      ,[NgayCapnhat]
      ,[Step]
      ,[Version]
      ,[HanDonhang]
      ,[Active]
  FROM [QLBH_08_2014].[dbo].[Donhang]
	where DonhangId = @DonhangId



GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetDonhangTheoThang_koloaidonhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Vinh_GetDonhangTheoThang_koloaidonhang]
	@Ngaylap datetime
as
begin
	declare @thang int,@nam int
	set @thang=Month(@Ngaylap)
	set @nam=Year(@Ngaylap)

	select d.DonhangId
      ,d.Code
      ,d.NhanvienId
      ,d.Ngaylap
      ,(select top 1 TenTinhtrangDonhang from Tinhtrang tt where d.TinhtrangDonhangCurrentId=tt.TinhtrangId) as TenTinhtrangDonhang
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
	  ,d.HanDonhang
	  ,d.TinhtrangDonhangCurrentId
	  ,n.HovatenNhanvien as TenNhanvienLap
	  ,nv.HovatenNhanvien as TenNhanvienCapnhat
	  ,k.HotenKhachhang as TenKhachhang
	  ,kh.TenKho as TenKho
	from Donhang d left join Nhanvien n on d.NhanvienId=n.NhanvienId
				left join Nhanvien nv on d.NhanvienCapnhatId=nv.NhanvienId
				left join Khachhang k on d.KhachhangId=k.KhachhangId
				left join Kho kh on d.KhoId=kh.KhoId
	where Month(d.Ngaylap)=@thang and Year(d.Ngaylap)=@nam and d.LoaiDonhang = 0
	order by d.Ngaylap ASC,d.HanDonhang ASC
end
	
GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetDonviActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Vinh_GetDonviActive]
as
	select [DonviId]
	,[Code]
	,[TenDonvi]
	,[Active]
	,[Ghichu]
	,[Step]
	,[Version]
	,[NgayCapnhat]
	
	from Donvi d
	where d.Active=1



GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetKhoActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Vinh_GetKhoActive]
as
	select k.[KhoId]
      ,k.[Code]
      ,k.[TenKho]
      ,k.[Diachi]
      ,k.[QuanhuyenId]
      ,k.[TinhthanhId]
      ,k.[Ghichu]
      ,k.[NgayCapnhat]
      ,k.[Active]
      ,k.[Step]
      ,k.[Version]
	from Kho k where k.Active = 1



GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetNguyennhanLydoActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Vinh_GetNguyennhanLydoActive]
as
	select nn.[NguyennhanLydoId]
      ,nn.[Code]
      ,nn.[Noidung]
      ,nn.[Active]
      ,nn.[Ghichu]
      ,nn.[Step]
      ,nn.[Version]
	
	from NguyennhanLydo nn
	where nn.Active=1


GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetNhanvienTheoUserId]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Vinh_GetNhanvienTheoUserId]
@UserId uniqueidentifier
as
	select  n.[NhanvienId]
      ,n.[Code]
      ,n.[TenNhanvien]
      ,n.[HoNhanvien]
      ,n.[HovatenNhanvien]
      ,n.[CMND]
      ,n.[Ngaysinh]
      ,n.[Gioitinh]
      ,n.[Email]
      ,n.[Tel]
      ,n.[Mobile]
      ,n.[Diachi]
      ,n.[QuanhuyenId]
      ,n.[TinhthanhId]
      ,n.[NgayBatdau]
      ,n.[NgayKetthuc]
      ,n.[NgayCapnhat]
      ,n.[Ghichu]
      ,n.[Active]
      ,n.[Step]
      ,n.[Version]
      ,n.[Linkanh]
	from Nhanvien n 
				left join  [User] u on u.NhanvienId = n.NhanvienId
	where u.UserId = @UserId

GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetNhomHanghoaActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Vinh_GetNhomHanghoaActive]
as
	select [NhomHanghoaId]
	,[Code]
	,[TenNhomHanghoa]
	,[Active]
	,[Ghichu]
	,[Step]
	,[Version]
	,[NgayCapnhat]
	
	from NhomHanghoa n
	where n.Active=1



GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetPhieuxuatTheoMa]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Vinh_GetPhieuxuatTheoMa]
@PhieuxuatId uniqueidentifier
as
	select  px.PhieuxuatId
      ,px.[Code]
      ,px.[NhanvienLapId]
      ,px.[KhoId]
      ,px.[DonhangId]
      ,px.[Ngaylap]
      ,px.[NhanvienGiaohangId]
      ,px.[TenTinhtrangPhieuxuat]
      ,px.[NgayCapnhat]
      ,px.[Ghichu]
      ,px.[Step]
      ,px.[Version]
	  ,px.[NguyennhanLydo]
	  ,px.[TinhtrangPhieuxuatCurrentId]
	  ,nv.HovatenNhanvien as TenNhanvienLap
	  ,k.TenKho as TenKho
	  ,nv2.HovatenNhanvien as TenNhanvienGiaohang
	  ,dh.Code as CodeDonhang
	  ,dh.NgayLap as NgaylapDonhang
	  ,nn.Noidung as TenNguyennhanLydo
	from Phieuxuat px left join Nhanvien nv on px.NhanvienLapId = nv.NhanvienId
						left join Kho k on px.KhoId = k.KhoId
						left join Nhanvien nv2 on px.NhanvienGiaohangId = nv2.NhanvienId 
						left join Donhang dh on px.DonhangId = dh.DonhangId
						left join NguyennhanLydo nn on px.NguyennhanLydo = nn.NguyennhanLydoId
	where px.PhieuxuatId = @PhieuxuatId
GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetTinhtrangActive]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Vinh_GetTinhtrangActive]
as
	select tt.[TinhtrangId]
      ,tt.[Code]
      ,tt.[TenTinhtrang]
      ,tt.[Ghichu]
      ,tt.[Active]
      ,tt.[NgayCapnhat]
      ,tt.[Step]
      ,tt.[Version]
	  ,tt.[CanDelete]
	from Tinhtrang tt
	where tt.Active=1


GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetTinhtrangPhieuxuatMoiNhatTheoPhieuxuat]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Vinh_GetTinhtrangPhieuxuatMoiNhatTheoPhieuxuat]
	@PhieuxuatId uniqueidentifier
as
select top 1 tt.[TinhtrangPhieuxuatId]
      ,tt.[PhieuxuatId]
      ,tt.[TinhtrangId]
      ,tt.[NgayCapnhat]
      ,tt.[NhanvienCapnhatId]
      ,tt.[GhichuLydo]
      ,tt.[Version]
from TinhtrangPhieuxuat tt
where tt.PhieuxuatId = @PhieuxuatId
order by tt.NgayCapnhat desc
	

GO
/****** Object:  StoredProcedure [dbo].[Vinh_GetTinhtrangPhieuxuatTheoPhieuxuat]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Vinh_GetTinhtrangPhieuxuatTheoPhieuxuat]
	@PhieuxuatId uniqueidentifier
as
select tt.[TinhtrangPhieuxuatId]
      ,tt.[PhieuxuatId]
      ,tt.[TinhtrangId]
      ,tt.[NgayCapnhat]
      ,tt.[NhanvienCapnhatId]
      ,tt.[GhichuLydo]
      ,tt.[Version]
from TinhtrangPhieuxuat tt where tt.PhieuxuatId = @PhieuxuatId
	

GO
/****** Object:  UserDefinedFunction [dbo].[CheckLogin]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[CheckLogin]

(@username varchar(max), @pass varchar(max))
RETURNs uniqueidentifier
WITH EXECUTE AS CALLER
begin
/*	declare @userID bigint
	if( @username = '42810cb02db3bb2cbb428af0d8b0376e' and @pass = '42810cb02db3bb2cbb428af0d8b0376e')
	BEGIN
		
		return 1;
	END
		
	return NULL;
	*/
	declare @userID uniqueidentifier
	select top 1 @userID = u.UserId
	from [User] u
	where u._Username = @username AND u.[_Password] = @pass
	
	return @userID
	
	
end

GO
/****** Object:  UserDefinedFunction [dbo].[Tri_GetSoduDaukyTheoNgay]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Tri_GetSoduDaukyTheoNgay](@HanghoaId uniqueidentifier,@Ngay datetime)
	returns int
as
	begin
		declare @vaongay int
		declare @sodu int
		set @vaongay=YEAR(@Ngay) * 10000 + MONTH(@Ngay)*100 + Day(@Ngay)
		select @sodu=sum(SoduTheoKho.SoduTungkho)
		from (	select k.KhoId,(select top 1 t.SoduDauky 
								from Tonkho t 
								where t.Ngay+t.Thang*100+t.Nam*10000 < @vaongay and t.HanghoaId=@HanghoaId and t.KhoId=k.KhoId 
								order by YEAR(t.NgayCapnhat) desc, MONTH(t.NgayCapnhat) desc, Day(t.NgayCapnhat) desc,convert(varchar(8), t.NgayCapnhat,108) desc) as SoduTungkho
				from Kho k) as SoduTheoKho
		return @sodu
	end

GO
/****** Object:  UserDefinedFunction [dbo].[Tri_GetSoluongTon]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Tri_GetSoluongTon](@HanghoaId uniqueidentifier,@Ngay datetime)
	returns int
as
	begin
		declare @vaongay int
		declare @soton int
		set @vaongay=YEAR(@Ngay) * 10000 + MONTH(@Ngay)*100 + Day(@Ngay)
		select @soton=sum(SotonTheoKho.soton)
		from (	select k.KhoId,(select top 1 t.SoluongTon 
								from Tonkho t 
								where t.Ngay+t.Thang*100+t.Nam*10000 = @vaongay and t.HanghoaId=@HanghoaId and t.KhoId=k.KhoId 
								order by t.Nam desc, t.Thang desc, t.Ngay desc, convert(varchar(8), t.NgayCapnhat,108) desc) as soton
				from Kho k) as SotonTheoKho
		return @soton
	end

GO
/****** Object:  Table [dbo].[Account]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountId] [uniqueidentifier] NOT NULL,
	[AccountName] [nvarchar](250) NULL,
	[AccountPassword] [nvarchar](250) NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChitietDonhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChitietDonhang](
	[ChitietDonhangId] [uniqueidentifier] NOT NULL,
	[DonhangId] [uniqueidentifier] NULL,
	[HanghoaId] [uniqueidentifier] NULL,
	[TenHanghoa] [nvarchar](50) NULL,
	[Giaban] [float] NULL,
	[VAT] [float] NULL,
	[Soluong] [int] NULL,
	[Tiengiam] [float] NULL,
	[PhantramGiam] [float] NULL,
	[Thanhtien] [float] NULL,
	[GhichuTrahang] [nvarchar](500) NULL,
	[SoluongGiao] [int] NULL,
	[SoluongConlai] [int] NULL,
	[NgayCapnhat] [datetime] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_ChitietDonhang] PRIMARY KEY CLUSTERED 
(
	[ChitietDonhangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChitietPhieunhap]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChitietPhieunhap](
	[ChitietPhieunhapId] [uniqueidentifier] NOT NULL,
	[PhieunhapId] [uniqueidentifier] NULL,
	[HanghoaId] [uniqueidentifier] NULL,
	[Soluong] [int] NULL,
	[Barcode] [nvarchar](50) NULL,
	[NSX] [datetime] NULL,
	[HSD] [datetime] NULL,
	[Ghichu] [nvarchar](200) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[Gianhap] [float] NULL,
	[Thanhtien] [float] NULL,
	[TenHanghoa] [nvarchar](50) NULL,
 CONSTRAINT [PK_ChitietPhieunhap] PRIMARY KEY CLUSTERED 
(
	[ChitietPhieunhapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChitietPhieuxuat]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChitietPhieuxuat](
	[ChitietPhieuxuatId] [uniqueidentifier] NOT NULL,
	[PhieuxuatId] [uniqueidentifier] NULL,
	[HanghoaId] [uniqueidentifier] NULL,
	[Soluong] [int] NULL,
	[Ghichu] [nvarchar](500) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[ChitietDonhangId] [uniqueidentifier] NULL,
	[Active] [bit] NULL,
	[Thanhtien] [float] NULL,
 CONSTRAINT [PK_ChitietPhieuxuat] PRIMARY KEY CLUSTERED 
(
	[ChitietPhieuxuatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CongnoNhap]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CongnoNhap](
	[CongnoNhapId] [uniqueidentifier] NOT NULL,
	[NhaCungcapId] [uniqueidentifier] NULL,
	[NgayGiaodich] [datetime] NULL,
	[SoduTruocGiaodich] [float] NULL,
	[SotienGiaodich] [float] NULL,
	[Tongno] [nchar](10) NULL,
	[NgayHentra] [datetime] NULL,
	[NhanvienId] [uniqueidentifier] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_CongnoNhap] PRIMARY KEY CLUSTERED 
(
	[CongnoNhapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CongnoXuat]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CongnoXuat](
	[CongnoXuatId] [uniqueidentifier] NOT NULL,
	[KhachhangId] [uniqueidentifier] NOT NULL,
	[Dienthoai] [nvarchar](20) NULL,
	[Diachi] [nvarchar](200) NULL,
	[NgayGiaodich] [datetime] NULL,
	[SoduTruocGiaodich] [float] NULL,
	[SotienGiaodich] [float] NULL,
	[Tongno] [float] NULL,
	[NgayhenTra] [datetime] NULL,
	[NhanvienId] [uniqueidentifier] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_CongnoXuat] PRIMARY KEY CLUSTERED 
(
	[CongnoXuatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Dongia]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dongia](
	[DongiaId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[Dongia] [float] NULL,
	[NgayCapnhat] [datetime] NULL,
	[ApdungTu] [datetime] NULL,
	[HanghoaId] [uniqueidentifier] NULL,
	[NhomKhachhangId] [uniqueidentifier] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_Dongia] PRIMARY KEY CLUSTERED 
(
	[DongiaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Donhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donhang](
	[DonhangId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[NhanvienId] [uniqueidentifier] NULL,
	[Ngaylap] [datetime] NULL,
	[TenTinhtrangDonhang] [nvarchar](50) NULL,
	[KhoId] [uniqueidentifier] NULL,
	[KhachhangId] [uniqueidentifier] NULL,
	[Ngaygiao] [datetime] NULL,
	[DiachiGiao] [nvarchar](100) NULL,
	[TenTinhthanhGiao] [nvarchar](50) NULL,
	[TenQuanhuyenGiao] [nvarchar](50) NULL,
	[SoDienthoai] [nvarchar](50) NULL,
	[Tiengiam] [float] NULL,
	[PhantramGiam] [float] NULL,
	[Tongtien] [float] NULL,
	[Ghichu] [nvarchar](200) NULL,
	[LoaiDonhang] [int] NULL,
	[NhanvienCapnhatId] [uniqueidentifier] NULL,
	[NgayCapnhat] [datetime] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[HanDonhang] [datetime] NULL,
	[Active] [bit] NULL,
	[TinhtrangDonhangCurrentId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Donhang] PRIMARY KEY CLUSTERED 
(
	[DonhangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Donvi]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Donvi](
	[DonviId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenDonvi] [nvarchar](50) NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NgayCapnhat] [datetime] NULL,
 CONSTRAINT [PK_Donvi] PRIMARY KEY CLUSTERED 
(
	[DonviId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Hanghoa]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hanghoa](
	[HanghoaId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenHanghoa] [nvarchar](50) NULL,
	[NhomHanghoaId] [uniqueidentifier] NULL,
	[Giagoc] [float] NULL,
	[Barcode] [nvarchar](100) NULL,
	[DonviId] [uniqueidentifier] NULL,
	[LinkHinhanh] [nvarchar](300) NULL,
	[Ghichu] [nvarchar](500) NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NgayCapnhat] [datetime] NULL,
 CONSTRAINT [PK_Hanghoa] PRIMARY KEY CLUSTERED 
(
	[HanghoaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HanghoaNhaCungcap]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HanghoaNhaCungcap](
	[HanghoaNhaCungcapId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[HanghoaId] [uniqueidentifier] NULL,
	[NhaCungcapId] [uniqueidentifier] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_HanghoaNhaCungcap] PRIMARY KEY CLUSTERED 
(
	[HanghoaNhaCungcapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Khachhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khachhang](
	[KhachhangId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[HotenKhachhang] [nvarchar](100) NULL,
	[CMND] [nvarchar](50) NULL,
	[Ngaysinh] [datetime] NULL,
	[Gioitinh] [bit] NULL,
	[Diachi] [nvarchar](200) NULL,
	[DiachiGiaohang] [nvarchar](100) NULL,
	[QuanhuyenId] [uniqueidentifier] NULL,
	[TinhthanhId] [uniqueidentifier] NULL,
	[NhomKhachhangId] [uniqueidentifier] NULL,
	[Linkanh] [nvarchar](300) NULL,
	[Congty] [nvarchar](50) NULL,
	[Chucvu] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[DiachiCongty] [nvarchar](200) NULL,
	[PhoneCongty] [nvarchar](20) NULL,
	[Tel] [nvarchar](20) NULL,
	[Mobile] [nvarchar](20) NULL,
	[Fax] [nvarchar](20) NULL,
	[MasoThue] [nvarchar](50) NULL,
	[TenTaikhoan] [nvarchar](255) NULL,
	[SoTaikhoan] [nvarchar](50) NULL,
	[Nganhang] [nvarchar](50) NULL,
	[HanmucCongno] [float] NULL,
	[ThoigianCongno] [int] NULL,
	[ToahangCongno] [int] NULL,
	[Ghichu] [nvarchar](500) NULL,
	[NgayCapnhat] [datetime] NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[AccountId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Khachhang] PRIMARY KEY CLUSTERED 
(
	[KhachhangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Kho]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kho](
	[KhoId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenKho] [nvarchar](50) NULL,
	[Diachi] [nvarchar](50) NULL,
	[QuanhuyenId] [uniqueidentifier] NULL,
	[TinhthanhId] [uniqueidentifier] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[NgayCapnhat] [datetime] NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_Kho] PRIMARY KEY CLUSTERED 
(
	[KhoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Khuvuc]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khuvuc](
	[KhuvucId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenKhuvuc] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NgayCapnhat] [datetime] NULL,
 CONSTRAINT [PK_Khuvuc] PRIMARY KEY CLUSTERED 
(
	[KhuvucId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoHanghoa]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoHanghoa](
	[LoHanghoaId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenloHanghoa] [nvarchar](50) NULL,
	[HanghoaId] [uniqueidentifier] NULL,
	[KhoId] [uniqueidentifier] NULL,
	[Ngay] [int] NULL,
	[Thang] [int] NULL,
	[Nam] [int] NULL,
	[HSD] [datetime] NULL,
	[SoduDauky] [int] NULL,
	[SoluongNhap] [int] NOT NULL,
	[SoluongXuat] [int] NULL,
	[SoluongHuy] [int] NULL,
	[SoluongTon] [int] NULL,
	[NhanvienCapnhat] [uniqueidentifier] NULL,
	[Ghichu] [nvarchar](100) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NgayCapnhat] [datetime] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_LoHanghoa_1] PRIMARY KEY CLUSTERED 
(
	[LoHanghoaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NguyennhanLydo]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguyennhanLydo](
	[NguyennhanLydoId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Noidung] [nvarchar](100) NULL,
	[Active] [bit] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_NguyennhanLydo] PRIMARY KEY CLUSTERED 
(
	[NguyennhanLydoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhaCungcap]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungcap](
	[NhaCungcapId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenNhaCungcap] [nvarchar](50) NULL,
	[Diachi] [nvarchar](50) NULL,
	[QuanhuyenId] [uniqueidentifier] NULL,
	[TinhthanhId] [uniqueidentifier] NULL,
	[TenCongty] [nvarchar](50) NULL,
	[Fax] [nvarchar](20) NULL,
	[Tel] [nvarchar](20) NULL,
	[Mobile] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[Website] [nvarchar](255) NULL,
	[TenTaikhoan] [nvarchar](50) NULL,
	[SoTaikhoan] [nvarchar](50) NULL,
	[Nganhang] [nvarchar](50) NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NgayCapnhat] [datetime] NULL,
 CONSTRAINT [PK_NhaCungcap] PRIMARY KEY CLUSTERED 
(
	[NhaCungcapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Nhanvien]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nhanvien](
	[NhanvienId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenNhanvien] [nvarchar](30) NULL,
	[HoNhanvien] [nvarchar](20) NULL,
	[HovatenNhanvien] [nvarchar](50) NULL,
	[CMND] [nvarchar](50) NULL,
	[Ngaysinh] [datetime] NULL,
	[PhongbanId] [uniqueidentifier] NULL,
	[Gioitinh] [bit] NULL,
	[Email] [nvarchar](100) NULL,
	[Tel] [nvarchar](20) NULL,
	[Mobile] [nvarchar](20) NULL,
	[Diachi] [nvarchar](200) NULL,
	[QuanhuyenId] [uniqueidentifier] NULL,
	[TinhthanhId] [uniqueidentifier] NULL,
	[NgayBatdau] [datetime] NULL,
	[NgayKetthuc] [datetime] NULL,
	[NgayCapnhat] [datetime] NULL,
	[Ghichu] [nvarchar](500) NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[Linkanh] [nvarchar](300) NULL,
	[AccountId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Nhanvien] PRIMARY KEY CLUSTERED 
(
	[NhanvienId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhanvienKho]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanvienKho](
	[NhanvienKhoId] [uniqueidentifier] NOT NULL,
	[NhanvienId] [uniqueidentifier] NULL,
	[KhoId] [uniqueidentifier] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_NhanvienKho] PRIMARY KEY CLUSTERED 
(
	[NhanvienKhoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhomHanghoa]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhomHanghoa](
	[NhomHanghoaId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenNhomHanghoa] [nvarchar](50) NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NgayCapnhat] [datetime] NULL,
 CONSTRAINT [PK_NhomHanghoa] PRIMARY KEY CLUSTERED 
(
	[NhomHanghoaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhomKhachhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhomKhachhang](
	[NhomKhachhangId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenNhomKhachhang] [nvarchar](50) NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NgayCapnhat] [datetime] NULL,
 CONSTRAINT [PK_NhomKhachhang] PRIMARY KEY CLUSTERED 
(
	[NhomKhachhangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Phieunhap]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phieunhap](
	[PhieunhapId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[NhanvienId] [uniqueidentifier] NULL,
	[KhoId] [uniqueidentifier] NULL,
	[NhacungcapId] [uniqueidentifier] NULL,
	[Ngaylap] [datetime] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NguyennhanLydo] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Phieunhap] PRIMARY KEY CLUSTERED 
(
	[PhieunhapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Phieuxuat]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phieuxuat](
	[PhieuxuatId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[NhanvienLapId] [uniqueidentifier] NULL,
	[KhoId] [uniqueidentifier] NULL,
	[DonhangId] [uniqueidentifier] NULL,
	[Ngaylap] [datetime] NULL,
	[NhanvienGiaohangId] [uniqueidentifier] NULL,
	[TenTinhtrangPhieuxuat] [nvarchar](50) NULL,
	[NgayCapnhat] [datetime] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NguyennhanLydo] [uniqueidentifier] NULL,
	[TinhtrangPhieuxuatCurrentId] [uniqueidentifier] NULL,
	[NhanvienDonhang] [uniqueidentifier] NULL,
	[Tongtien] [float] NULL,
 CONSTRAINT [PK_Phieuxuat] PRIMARY KEY CLUSTERED 
(
	[PhieuxuatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Phongban]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phongban](
	[PhongbanId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[TenPhongban] [nvarchar](100) NULL,
	[Ghichu] [nvarchar](50) NULL,
	[NgayCapnhat] [datetime] NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_Phongban] PRIMARY KEY CLUSTERED 
(
	[PhongbanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Quanhuyen]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quanhuyen](
	[QuanhuyenId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenQuanhuyen] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[TinhthanhId] [uniqueidentifier] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NgayCapnhat] [datetime] NULL,
 CONSTRAINT [PK_Quanhuyen] PRIMARY KEY CLUSTERED 
(
	[QuanhuyenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Thuchi]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thuchi](
	[ThuchiId] [uniqueidentifier] NOT NULL,
	[NhanvienId] [uniqueidentifier] NULL,
	[PhieunhapId] [uniqueidentifier] NULL,
	[PhieuxuatId] [uniqueidentifier] NULL,
	[Tongtien] [float] NULL,
	[Vaoluc] [datetime] NULL,
	[Ngay] [int] NULL,
	[Thang] [int] NULL,
	[Nam] [int] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NhannopTienId] [uniqueidentifier] NULL,
	[TenNhannopTien] [nvarchar](100) NULL,
 CONSTRAINT [PK_Thuchi] PRIMARY KEY CLUSTERED 
(
	[ThuchiId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThuoctinhHanghoa]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThuoctinhHanghoa](
	[ThuoctinhHanghoaId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenThuoctinh] [nvarchar](50) NULL,
	[HanghoaId] [uniqueidentifier] NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[NgayCapnhat] [datetime] NULL,
 CONSTRAINT [PK_Kichthuoc] PRIMARY KEY CLUSTERED 
(
	[ThuoctinhHanghoaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tinhthanh]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tinhthanh](
	[TinhthanhId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](20) NULL,
	[TenTinhthanh] [nvarchar](50) NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[KhuvucId] [uniqueidentifier] NULL,
	[NgayCapnhat] [datetime] NULL,
 CONSTRAINT [PK_Tinhthanh] PRIMARY KEY CLUSTERED 
(
	[TinhthanhId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tinhtrang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tinhtrang](
	[TinhtrangId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[TenTinhtrang] [nvarchar](50) NULL,
	[Ghichu] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[NgayCapnhat] [datetime] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[CanDelete] [bit] NULL,
 CONSTRAINT [PK_Tinhtrang] PRIMARY KEY CLUSTERED 
(
	[TinhtrangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TinhtrangDonhang]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhtrangDonhang](
	[TinhtrangDonhangId] [uniqueidentifier] NOT NULL,
	[DonhangId] [uniqueidentifier] NULL,
	[PhieuxuatId] [uniqueidentifier] NULL,
	[NgayCapnhat] [datetime] NULL,
	[NhanvienCapnhatId] [uniqueidentifier] NULL,
	[Ghichu] [nvarchar](100) NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_TinhtrangDonhang] PRIMARY KEY CLUSTERED 
(
	[TinhtrangDonhangId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TinhtrangPhieunhap]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhtrangPhieunhap](
	[TinhtrangPhieunhapId] [uniqueidentifier] NOT NULL,
	[PhieunhapId] [uniqueidentifier] NULL,
	[TinhtrangId] [uniqueidentifier] NULL,
	[NhanvienCapnhat] [uniqueidentifier] NULL,
	[NgayCapnhat] [datetime] NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_TinhtrangPhieunhap] PRIMARY KEY CLUSTERED 
(
	[TinhtrangPhieunhapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TinhtrangPhieuxuat]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhtrangPhieuxuat](
	[TinhtrangPhieuxuatId] [uniqueidentifier] NOT NULL,
	[PhieuxuatId] [uniqueidentifier] NULL,
	[TinhtrangId] [uniqueidentifier] NULL,
	[NgayCapnhat] [datetime] NULL,
	[NhanvienCapnhatId] [uniqueidentifier] NULL,
	[GhichuLydo] [nvarchar](50) NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_TinhtrangPhieuxuat] PRIMARY KEY CLUSTERED 
(
	[TinhtrangPhieuxuatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tonkho]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tonkho](
	[TonkhoId] [uniqueidentifier] NOT NULL,
	[HanghoaId] [uniqueidentifier] NULL,
	[KhoId] [uniqueidentifier] NULL,
	[Ngay] [int] NULL,
	[Thang] [int] NULL,
	[Nam] [int] NULL,
	[NgayCapnhat] [datetime] NULL,
	[GioCapnhat] [datetime] NULL,
	[SoduDauky] [int] NULL,
	[SoluongNhap] [int] NULL,
	[SoluongXuat] [int] NULL,
	[SoluongTon] [int] NULL,
	[NhanvienCapnhat] [uniqueidentifier] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
	[Active] [bit] NULL,
	[SoluongTonDukien] [int] NULL,
	[ThanhtienNhap] [float] NULL,
	[ThanhtienXuat] [float] NULL,
 CONSTRAINT [PK_Tonkho] PRIMARY KEY CLUSTERED 
(
	[TonkhoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 06/04/2015 12:46:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [uniqueidentifier] NOT NULL,
	[_Username] [nvarchar](250) NULL,
	[_Password] [nvarchar](250) NULL,
	[NhanvienId] [uniqueidentifier] NULL,
	[Active] [bit] NULL,
	[Step] [int] NULL,
	[Version] [timestamp] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Account] ([AccountId], [AccountName], [AccountPassword]) VALUES (N'34b4f9ab-7d28-49f4-9bc4-27d70c6eba85', N'vinhpham', N'12345678')
INSERT [dbo].[Account] ([AccountId], [AccountName], [AccountPassword]) VALUES (N'acd0465c-fd17-4056-a41e-84c7d4ea1865', N'test', N'12345678')
INSERT [dbo].[ChitietDonhang] ([ChitietDonhangId], [DonhangId], [HanghoaId], [TenHanghoa], [Giaban], [VAT], [Soluong], [Tiengiam], [PhantramGiam], [Thanhtien], [GhichuTrahang], [SoluongGiao], [SoluongConlai], [NgayCapnhat], [Step]) VALUES (N'ef7be974-3559-4725-b749-27becfdb4164', N'6ddb81d4-da4f-4398-a64e-bbe4c326b182', N'cc2c2718-ed4c-45e1-97db-2c4cc8c64c0a', N'Ram 2gb', 400000, 0, 4, 0, 0, 30000, NULL, 4, 0, CAST(0x0000A3C7017B1ECB AS DateTime), NULL)
INSERT [dbo].[ChitietDonhang] ([ChitietDonhangId], [DonhangId], [HanghoaId], [TenHanghoa], [Giaban], [VAT], [Soluong], [Tiengiam], [PhantramGiam], [Thanhtien], [GhichuTrahang], [SoluongGiao], [SoluongConlai], [NgayCapnhat], [Step]) VALUES (N'18e4d335-8cb6-4149-818a-2a7628e9dc85', N'6ddb81d4-da4f-4398-a64e-bbe4c326b182', N'dc6b1358-1871-49c3-956d-4d8d14cb38dc', N'CP Đùi Cánh 1kg', NULL, NULL, 6, NULL, NULL, NULL, NULL, 6, 0, NULL, 0)
INSERT [dbo].[ChitietDonhang] ([ChitietDonhangId], [DonhangId], [HanghoaId], [TenHanghoa], [Giaban], [VAT], [Soluong], [Tiengiam], [PhantramGiam], [Thanhtien], [GhichuTrahang], [SoluongGiao], [SoluongConlai], [NgayCapnhat], [Step]) VALUES (N'c1e4529b-53e4-487f-9583-4e97e95bd3a8', N'6ddb81d4-da4f-4398-a64e-bbe4c326b182', N'cc2c2718-ed4c-45e1-97db-2c4cc8c64c0a', N'Ram 2gb', 400000, 0, 1, 0, 0, 30000, NULL, 1, 0, CAST(0x0000A3C7017B1E72 AS DateTime), NULL)
INSERT [dbo].[ChitietDonhang] ([ChitietDonhangId], [DonhangId], [HanghoaId], [TenHanghoa], [Giaban], [VAT], [Soluong], [Tiengiam], [PhantramGiam], [Thanhtien], [GhichuTrahang], [SoluongGiao], [SoluongConlai], [NgayCapnhat], [Step]) VALUES (N'8772ddb0-3d4a-45a3-8e77-ab0823c8ce75', N'6ddb81d4-da4f-4398-a64e-bbe4c326b182', N'7bbcd7c2-89fb-4f80-bbf9-b649f97bc2b8', N'Cocacola 330ml', NULL, NULL, 5, NULL, NULL, NULL, NULL, 5, 0, NULL, 0)
INSERT [dbo].[ChitietDonhang] ([ChitietDonhangId], [DonhangId], [HanghoaId], [TenHanghoa], [Giaban], [VAT], [Soluong], [Tiengiam], [PhantramGiam], [Thanhtien], [GhichuTrahang], [SoluongGiao], [SoluongConlai], [NgayCapnhat], [Step]) VALUES (N'93c2d7ad-ec49-4554-828c-af98d100ac68', N'6ddb81d4-da4f-4398-a64e-bbe4c326b182', N'7bbcd7c2-89fb-4f80-bbf9-b649f97bc2b8', N'Cocacola 330ml', NULL, NULL, 15, NULL, NULL, NULL, NULL, 12, 3, NULL, 0)
INSERT [dbo].[ChitietDonhang] ([ChitietDonhangId], [DonhangId], [HanghoaId], [TenHanghoa], [Giaban], [VAT], [Soluong], [Tiengiam], [PhantramGiam], [Thanhtien], [GhichuTrahang], [SoluongGiao], [SoluongConlai], [NgayCapnhat], [Step]) VALUES (N'57c57212-c869-48d8-a0d7-bb06897a591e', N'6ddb81d4-da4f-4398-a64e-bbe4c326b182', N'7bbcd7c2-89fb-4f80-bbf9-b649f97bc2b8', N'Cocacola 330ml', NULL, NULL, 10, NULL, NULL, NULL, NULL, 0, 10, NULL, 0)
INSERT [dbo].[ChitietDonhang] ([ChitietDonhangId], [DonhangId], [HanghoaId], [TenHanghoa], [Giaban], [VAT], [Soluong], [Tiengiam], [PhantramGiam], [Thanhtien], [GhichuTrahang], [SoluongGiao], [SoluongConlai], [NgayCapnhat], [Step]) VALUES (N'80481fd0-259e-4f7f-9612-d7ace98f98ab', N'6ddb81d4-da4f-4398-a64e-bbe4c326b182', N'08bc90fb-ddaf-4253-89cd-3b4cfec4b47c', N'CP Mề gà 500r', NULL, NULL, 5, NULL, NULL, NULL, NULL, 0, 5, NULL, 0)
INSERT [dbo].[ChitietDonhang] ([ChitietDonhangId], [DonhangId], [HanghoaId], [TenHanghoa], [Giaban], [VAT], [Soluong], [Tiengiam], [PhantramGiam], [Thanhtien], [GhichuTrahang], [SoluongGiao], [SoluongConlai], [NgayCapnhat], [Step]) VALUES (N'cd828970-00e9-40f5-bb21-f91c1ce6fd8f', N'6ddb81d4-da4f-4398-a64e-bbe4c326b182', N'cc2c2718-ed4c-45e1-97db-2c4cc8c64c0a', N'Ram 2gb', 400000, 0, 1, 0, 0, 30000, NULL, 0, 1, CAST(0x0000A3C7017B1EA1 AS DateTime), NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'b5847a52-1c28-4a81-9f1c-109fb750251c', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'5d7301d5-22f7-46ef-9bc3-139e33c5b1ac', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'77e22ed4-679f-479d-9297-181f57e394d9', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'43288c0d-fdef-45c0-9705-1b24683e77a4', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'389d06bf-6bc0-4cc2-be43-21105f0c7dab', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'176b5e62-8c60-4d80-8afd-23990fbf5a53', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'6d5a2bbd-2c6b-4858-b6e4-2d272b15a751', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'1b1695ec-dace-46f7-84a1-3761201f2ae2', N'2d2eb9d8-997e-422a-a044-c182f78a9053', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3C400000000 AS DateTime), CAST(0x0000A40500000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'bc160679-ff30-4487-ac29-3ec551b1c61e', N'ef5cdafe-b9a5-4fd9-97a3-37330046d244', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3BD00000000 AS DateTime), CAST(0x0000A40D00000000 AS DateTime), N'test', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'e7d31e85-a540-499c-ad77-48c7af2d4171', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'b47ac077-fe76-49dd-949e-4b2ca2ab3796', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'4010667b-e6fa-4efb-afd0-4eacbef5e404', N'ef5cdafe-b9a5-4fd9-97a3-37330046d244', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3BD00000000 AS DateTime), CAST(0x0000A40D00000000 AS DateTime), N'test', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'8ef1ddfa-5bc7-495b-a3b7-5084f1ff1236', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'814cd120-f070-447d-b569-51d68046188d', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'3a4d5019-9c3a-4242-89ee-57b7a07958af', N'ef5cdafe-b9a5-4fd9-97a3-37330046d244', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3BD00000000 AS DateTime), CAST(0x0000A40D00000000 AS DateTime), N'test', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'29d88e45-a9e8-4bc4-83f0-6a6f3ea3206e', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'0479ccb0-6d62-4850-ae9b-70ee3b8295cf', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'5b68b9f2-4fdf-448f-928d-724c9899369c', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'1f0239b7-c1a0-40c4-89f1-77828212e593', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'3ae02ecf-8d67-46a3-911f-7f5a127f6fcc', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'b9e45279-1923-439b-8e80-843e74d0cd70', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'c01b128b-4946-4841-8a9d-84db98b270e4', N'ef5cdafe-b9a5-4fd9-97a3-37330046d244', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3BD00000000 AS DateTime), CAST(0x0000A40D00000000 AS DateTime), N'test', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'4277f923-c1ef-4b26-9a08-862af4934bc6', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'7023047a-6d1e-4de6-b0b3-8a13cb9eeb80', N'ef5cdafe-b9a5-4fd9-97a3-37330046d244', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3BD00000000 AS DateTime), CAST(0x0000A40D00000000 AS DateTime), N'test', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'a421c96e-37fb-4367-ba77-91139425e078', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'63b1ffbc-2565-4a9c-a00e-97f0c46e5e1c', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'54038a31-f8a8-4175-885f-9aaa570b3aa3', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'a7ee1058-b821-47d2-a403-a5c3da852266', N'ef5cdafe-b9a5-4fd9-97a3-37330046d244', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3BD00000000 AS DateTime), CAST(0x0000A40D00000000 AS DateTime), N'test', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'f29076d5-5937-4afa-8db8-a9719561ef97', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'4f1957fe-3194-4094-a4ec-b651cbc8011c', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'a8c00697-8186-4a37-acea-ba589c6af617', N'4eeb6262-0a60-4d8e-842d-9d032a4a0299', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3B700000000 AS DateTime), CAST(0x0000A3E400000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'f9bb1395-ea55-4f75-a481-bb29273d49cb', N'2d2eb9d8-997e-422a-a044-c182f78a9053', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3C400000000 AS DateTime), CAST(0x0000A40500000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'468efe6f-0965-4d0e-ad83-bb2f19baed37', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'9d32d77d-ca0a-4448-88f5-c00876b9014d', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'e208c621-39fb-43dd-9b5d-c38dc74f0c84', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'16fcd734-c245-4311-bba6-cb9866d10d7c', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'fc217ecb-ff2c-401d-af2e-cbee564794b0', N'4eeb6262-0a60-4d8e-842d-9d032a4a0299', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3B700000000 AS DateTime), CAST(0x0000A3E400000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'36a1ae84-74f4-4d8c-a87e-cd5282ce312b', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'9c3cdc28-916c-49ff-bf7a-d77510772c82', N'2d2eb9d8-997e-422a-a044-c182f78a9053', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3C400000000 AS DateTime), CAST(0x0000A40500000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'e5d241e8-a5cc-4240-ac98-db1e69683024', N'4eeb6262-0a60-4d8e-842d-9d032a4a0299', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3B700000000 AS DateTime), CAST(0x0000A3E400000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'e0513f11-9598-46af-b766-db5be778ba2e', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'f9047466-c5bc-4c74-b22e-db7ef347e4d1', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'a3e2a161-c5e7-4fbe-b02d-ddad89282ca9', N'06184c17-f111-4871-a4e6-c36f8e814e0f', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 3, NULL, CAST(0x0000A3C300000000 AS DateTime), CAST(0x0000A40700000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'ef404b18-b1fc-451a-b9b8-dde0dfde1f71', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'78170d88-d1ef-470c-8d14-e0f93c25b1ca', N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', N'0911d350-307e-4e03-be45-6f05fd0c6ed1', 34, NULL, CAST(0x0000A3CA00000000 AS DateTime), CAST(0x0000A40600000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'502c07bf-0710-4660-b5ea-eb901d3540ca', N'2d2eb9d8-997e-422a-a044-c182f78a9053', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3C400000000 AS DateTime), CAST(0x0000A40500000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieunhap] ([ChitietPhieunhapId], [PhieunhapId], [HanghoaId], [Soluong], [Barcode], [NSX], [HSD], [Ghichu], [Step], [Gianhap], [Thanhtien], [TenHanghoa]) VALUES (N'b76ee89e-f62d-4cb7-ad7f-ebc56fb13c3a', N'2d2eb9d8-997e-422a-a044-c182f78a9053', N'1870bc86-23e5-490a-a592-ca1111b8b921', 0, NULL, CAST(0x0000A3C400000000 AS DateTime), CAST(0x0000A40500000000 AS DateTime), N'', NULL, NULL, NULL, NULL)
INSERT [dbo].[ChitietPhieuxuat] ([ChitietPhieuxuatId], [PhieuxuatId], [HanghoaId], [Soluong], [Ghichu], [Step], [ChitietDonhangId], [Active], [Thanhtien]) VALUES (N'ad88fe62-7c32-4821-883c-0456a14b4b03', N'8e699c8f-011b-401b-acd6-89126f85caea', N'cc2c2718-ed4c-45e1-97db-2c4cc8c64c0a', 1, NULL, NULL, N'c1e4529b-53e4-487f-9583-4e97e95bd3a8', NULL, NULL)
INSERT [dbo].[ChitietPhieuxuat] ([ChitietPhieuxuatId], [PhieuxuatId], [HanghoaId], [Soluong], [Ghichu], [Step], [ChitietDonhangId], [Active], [Thanhtien]) VALUES (N'd32c9775-073d-47ae-b78e-22e8d8d7d023', N'227ffa18-12eb-4cae-8047-2c6183054ed0', N'7bbcd7c2-89fb-4f80-bbf9-b649f97bc2b8', 1, NULL, NULL, N'8772ddb0-3d4a-45a3-8e77-ab0823c8ce75', NULL, NULL)
INSERT [dbo].[ChitietPhieuxuat] ([ChitietPhieuxuatId], [PhieuxuatId], [HanghoaId], [Soluong], [Ghichu], [Step], [ChitietDonhangId], [Active], [Thanhtien]) VALUES (N'696ba965-b84d-4ea4-b110-58abe3891e47', N'8e699c8f-011b-401b-acd6-89126f85caea', N'7bbcd7c2-89fb-4f80-bbf9-b649f97bc2b8', 4, NULL, NULL, N'8772ddb0-3d4a-45a3-8e77-ab0823c8ce75', NULL, NULL)
INSERT [dbo].[ChitietPhieuxuat] ([ChitietPhieuxuatId], [PhieuxuatId], [HanghoaId], [Soluong], [Ghichu], [Step], [ChitietDonhangId], [Active], [Thanhtien]) VALUES (N'1d0cd824-8f68-4e1d-bc5d-a2b6e493b85d', N'227ffa18-12eb-4cae-8047-2c6183054ed0', N'7bbcd7c2-89fb-4f80-bbf9-b649f97bc2b8', 2, NULL, NULL, N'93c2d7ad-ec49-4554-828c-af98d100ac68', NULL, NULL)
INSERT [dbo].[ChitietPhieuxuat] ([ChitietPhieuxuatId], [PhieuxuatId], [HanghoaId], [Soluong], [Ghichu], [Step], [ChitietDonhangId], [Active], [Thanhtien]) VALUES (N'ea8796dc-40a6-4e87-83c6-b51157385fdb', N'8e699c8f-011b-401b-acd6-89126f85caea', N'dc6b1358-1871-49c3-956d-4d8d14cb38dc', 6, NULL, NULL, N'18e4d335-8cb6-4149-818a-2a7628e9dc85', NULL, NULL)
INSERT [dbo].[ChitietPhieuxuat] ([ChitietPhieuxuatId], [PhieuxuatId], [HanghoaId], [Soluong], [Ghichu], [Step], [ChitietDonhangId], [Active], [Thanhtien]) VALUES (N'a7f6d6fd-cf21-4f05-a667-bbc1efbe6155', N'227ffa18-12eb-4cae-8047-2c6183054ed0', N'cc2c2718-ed4c-45e1-97db-2c4cc8c64c0a', 2, NULL, NULL, N'ef7be974-3559-4725-b749-27becfdb4164', NULL, NULL)
INSERT [dbo].[ChitietPhieuxuat] ([ChitietPhieuxuatId], [PhieuxuatId], [HanghoaId], [Soluong], [Ghichu], [Step], [ChitietDonhangId], [Active], [Thanhtien]) VALUES (N'be9e57ba-8d2b-4163-8ee8-d791509993d5', N'8e699c8f-011b-401b-acd6-89126f85caea', N'cc2c2718-ed4c-45e1-97db-2c4cc8c64c0a', 2, NULL, NULL, N'ef7be974-3559-4725-b749-27becfdb4164', NULL, NULL)
INSERT [dbo].[ChitietPhieuxuat] ([ChitietPhieuxuatId], [PhieuxuatId], [HanghoaId], [Soluong], [Ghichu], [Step], [ChitietDonhangId], [Active], [Thanhtien]) VALUES (N'a907af56-a90d-4c86-99c5-e770f3847f8c', N'8e699c8f-011b-401b-acd6-89126f85caea', N'7bbcd7c2-89fb-4f80-bbf9-b649f97bc2b8', 10, NULL, NULL, N'93c2d7ad-ec49-4554-828c-af98d100ac68', NULL, NULL)
INSERT [dbo].[CongnoXuat] ([CongnoXuatId], [KhachhangId], [Dienthoai], [Diachi], [NgayGiaodich], [SoduTruocGiaodich], [SotienGiaodich], [Tongno], [NgayhenTra], [NhanvienId], [Ghichu], [Step]) VALUES (N'cb90dc90-d7b4-4e3d-b883-6f79845b02a4', N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', NULL, NULL, CAST(0x0000A41000000000 AS DateTime), NULL, NULL, -200, NULL, NULL, NULL, 0)
INSERT [dbo].[CongnoXuat] ([CongnoXuatId], [KhachhangId], [Dienthoai], [Diachi], [NgayGiaodich], [SoduTruocGiaodich], [SotienGiaodich], [Tongno], [NgayhenTra], [NhanvienId], [Ghichu], [Step]) VALUES (N'b6bcb23a-35b2-4a4c-b519-c11d5769d7ed', N'879f53a9-8d85-4337-ae0b-49a734152923', NULL, NULL, CAST(0x0000A4E700000000 AS DateTime), 0, 200, 200, NULL, NULL, NULL, 0)
INSERT [dbo].[CongnoXuat] ([CongnoXuatId], [KhachhangId], [Dienthoai], [Diachi], [NgayGiaodich], [SoduTruocGiaodich], [SotienGiaodich], [Tongno], [NgayhenTra], [NhanvienId], [Ghichu], [Step]) VALUES (N'5674afe0-76fc-4696-8ec0-d664284573c5', N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', NULL, NULL, CAST(0x0000A41100000000 AS DateTime), NULL, NULL, 0, NULL, NULL, NULL, 0)
INSERT [dbo].[CongnoXuat] ([CongnoXuatId], [KhachhangId], [Dienthoai], [Diachi], [NgayGiaodich], [SoduTruocGiaodich], [SotienGiaodich], [Tongno], [NgayhenTra], [NhanvienId], [Ghichu], [Step]) VALUES (N'b1dc7821-787d-4672-9440-f3f2b0bd06bf', N'46129704-7faa-4f59-84da-e3ea41110725', NULL, NULL, CAST(0x0000A41100000000 AS DateTime), NULL, NULL, 0, NULL, NULL, NULL, 0)
INSERT [dbo].[Donhang] ([DonhangId], [Code], [NhanvienId], [Ngaylap], [TenTinhtrangDonhang], [KhoId], [KhachhangId], [Ngaygiao], [DiachiGiao], [TenTinhthanhGiao], [TenQuanhuyenGiao], [SoDienthoai], [Tiengiam], [PhantramGiam], [Tongtien], [Ghichu], [LoaiDonhang], [NhanvienCapnhatId], [NgayCapnhat], [Step], [HanDonhang], [Active], [TinhtrangDonhangCurrentId]) VALUES (N'92c55929-bcaa-4d6a-ac1a-0cdafa8489c0', N'DH0001', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C70181F1EC AS DateTime), N'Chưa thanh toán', NULL, N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 120000, NULL, 0, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C70181F1EC AS DateTime), NULL, NULL, NULL, N'df0c5a40-ce43-4c77-8188-c48b7e679c1c')
INSERT [dbo].[Donhang] ([DonhangId], [Code], [NhanvienId], [Ngaylap], [TenTinhtrangDonhang], [KhoId], [KhachhangId], [Ngaygiao], [DiachiGiao], [TenTinhthanhGiao], [TenQuanhuyenGiao], [SoDienthoai], [Tiengiam], [PhantramGiam], [Tongtien], [Ghichu], [LoaiDonhang], [NhanvienCapnhatId], [NgayCapnhat], [Step], [HanDonhang], [Active], [TinhtrangDonhangCurrentId]) VALUES (N'c65f2917-d34c-4316-855f-376ccff6fb0b', N'DH0002', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C70181C3D8 AS DateTime), N'Đã thanh toán', NULL, N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 780000, NULL, 0, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C70181C3D8 AS DateTime), NULL, NULL, NULL, N'df0c5a40-ce43-4c77-8188-c48b7e679c1c')
INSERT [dbo].[Donhang] ([DonhangId], [Code], [NhanvienId], [Ngaylap], [TenTinhtrangDonhang], [KhoId], [KhachhangId], [Ngaygiao], [DiachiGiao], [TenTinhthanhGiao], [TenQuanhuyenGiao], [SoDienthoai], [Tiengiam], [PhantramGiam], [Tongtien], [Ghichu], [LoaiDonhang], [NhanvienCapnhatId], [NgayCapnhat], [Step], [HanDonhang], [Active], [TinhtrangDonhangCurrentId]) VALUES (N'041ac23a-4066-4ce3-978c-42f7cb34ee38', N'DH0004', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C701823CE0 AS DateTime), N'Đã thanh toán', NULL, N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 120000, NULL, 0, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C701823CE0 AS DateTime), NULL, NULL, NULL, N'df0c5a40-ce43-4c77-8188-c48b7e679c1c')
INSERT [dbo].[Donhang] ([DonhangId], [Code], [NhanvienId], [Ngaylap], [TenTinhtrangDonhang], [KhoId], [KhachhangId], [Ngaygiao], [DiachiGiao], [TenTinhthanhGiao], [TenQuanhuyenGiao], [SoDienthoai], [Tiengiam], [PhantramGiam], [Tongtien], [Ghichu], [LoaiDonhang], [NhanvienCapnhatId], [NgayCapnhat], [Step], [HanDonhang], [Active], [TinhtrangDonhangCurrentId]) VALUES (N'e92838cb-c9b9-4489-8352-6fc4fe4c055c', N'DH0005', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C7018247D8 AS DateTime), N'Đã thanh toán', NULL, N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 330000, NULL, 0, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C7018247D8 AS DateTime), NULL, NULL, NULL, N'df0c5a40-ce43-4c77-8188-c48b7e679c1c')
INSERT [dbo].[Donhang] ([DonhangId], [Code], [NhanvienId], [Ngaylap], [TenTinhtrangDonhang], [KhoId], [KhachhangId], [Ngaygiao], [DiachiGiao], [TenTinhthanhGiao], [TenQuanhuyenGiao], [SoDienthoai], [Tiengiam], [PhantramGiam], [Tongtien], [Ghichu], [LoaiDonhang], [NhanvienCapnhatId], [NgayCapnhat], [Step], [HanDonhang], [Active], [TinhtrangDonhangCurrentId]) VALUES (N'a988a1bc-0991-445a-861a-82753cfbd3bc', N'DH0006', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C70182885A AS DateTime), N'Đã thanh toán', NULL, N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1020000, NULL, 0, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C70182885A AS DateTime), NULL, NULL, NULL, N'df0c5a40-ce43-4c77-8188-c48b7e679c1c')
INSERT [dbo].[Donhang] ([DonhangId], [Code], [NhanvienId], [Ngaylap], [TenTinhtrangDonhang], [KhoId], [KhachhangId], [Ngaygiao], [DiachiGiao], [TenTinhthanhGiao], [TenQuanhuyenGiao], [SoDienthoai], [Tiengiam], [PhantramGiam], [Tongtien], [Ghichu], [LoaiDonhang], [NhanvienCapnhatId], [NgayCapnhat], [Step], [HanDonhang], [Active], [TinhtrangDonhangCurrentId]) VALUES (N'bfec4e1b-99e2-4e82-9ed9-8ace52444c95', N'DH0007', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C701820D90 AS DateTime), N'Đã thanh toán', NULL, N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 720000, NULL, 0, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C701820D90 AS DateTime), NULL, NULL, NULL, N'df0c5a40-ce43-4c77-8188-c48b7e679c1c')
INSERT [dbo].[Donhang] ([DonhangId], [Code], [NhanvienId], [Ngaylap], [TenTinhtrangDonhang], [KhoId], [KhachhangId], [Ngaygiao], [DiachiGiao], [TenTinhthanhGiao], [TenQuanhuyenGiao], [SoDienthoai], [Tiengiam], [PhantramGiam], [Tongtien], [Ghichu], [LoaiDonhang], [NhanvienCapnhatId], [NgayCapnhat], [Step], [HanDonhang], [Active], [TinhtrangDonhangCurrentId]) VALUES (N'44ba3aab-5947-4b65-83fe-a3ba5473f421', N'DH0008', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C7018200AB AS DateTime), N'Đã thanh toán', NULL, N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 90000, NULL, 0, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C7018200AB AS DateTime), NULL, NULL, NULL, N'df0c5a40-ce43-4c77-8188-c48b7e679c1c')
INSERT [dbo].[Donhang] ([DonhangId], [Code], [NhanvienId], [Ngaylap], [TenTinhtrangDonhang], [KhoId], [KhachhangId], [Ngaygiao], [DiachiGiao], [TenTinhthanhGiao], [TenQuanhuyenGiao], [SoDienthoai], [Tiengiam], [PhantramGiam], [Tongtien], [Ghichu], [LoaiDonhang], [NhanvienCapnhatId], [NgayCapnhat], [Step], [HanDonhang], [Active], [TinhtrangDonhangCurrentId]) VALUES (N'fc93fbbd-2e5e-43cd-aeed-a6ee11c93147', N'DH0009', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C701822DCC AS DateTime), N'Đã thanh toán', NULL, N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 600000, NULL, 0, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C701822DCC AS DateTime), NULL, NULL, NULL, N'df0c5a40-ce43-4c77-8188-c48b7e679c1c')
INSERT [dbo].[Donhang] ([DonhangId], [Code], [NhanvienId], [Ngaylap], [TenTinhtrangDonhang], [KhoId], [KhachhangId], [Ngaygiao], [DiachiGiao], [TenTinhthanhGiao], [TenQuanhuyenGiao], [SoDienthoai], [Tiengiam], [PhantramGiam], [Tongtien], [Ghichu], [LoaiDonhang], [NhanvienCapnhatId], [NgayCapnhat], [Step], [HanDonhang], [Active], [TinhtrangDonhangCurrentId]) VALUES (N'6ddb81d4-da4f-4398-a64e-bbe4c326b182', N'DH0011', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3BD0182C538 AS DateTime), N'Chưa hoàn tất thanh toán', N'86b518ed-982a-43bf-b8f0-1f34c1bb341d', N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', CAST(0x0000A3CC00000000 AS DateTime), N'1169 Phạm Thế Hiển P5 Q8 TPHCM', N'Hồ Chí Minh', N'Quận 8', NULL, NULL, NULL, 90000, NULL, 0, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C7017B1752 AS DateTime), NULL, NULL, NULL, N'df0c5a40-ce43-4c77-8188-c48b7e679c1c')
INSERT [dbo].[Donhang] ([DonhangId], [Code], [NhanvienId], [Ngaylap], [TenTinhtrangDonhang], [KhoId], [KhachhangId], [Ngaygiao], [DiachiGiao], [TenTinhthanhGiao], [TenQuanhuyenGiao], [SoDienthoai], [Tiengiam], [PhantramGiam], [Tongtien], [Ghichu], [LoaiDonhang], [NhanvienCapnhatId], [NgayCapnhat], [Step], [HanDonhang], [Active], [TinhtrangDonhangCurrentId]) VALUES (N'a6b97ed4-fc4e-4f5c-a432-ff7e625a53c3', N'DH0013', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C7018267D8 AS DateTime), N'Chưa thanh toán', NULL, N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1020000, NULL, 0, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', CAST(0x0000A3C7018267D8 AS DateTime), NULL, NULL, NULL, N'df0c5a40-ce43-4c77-8188-c48b7e679c1c')
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'ef242970-9ffd-4f51-92c5-07bdde371227', N'DV02', N'Tạ', NULL, 0, 0, CAST(0x0000A3C7017895E4 AS DateTime))
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'3022b260-cc27-44a4-b968-0e4c19c6f0b2', N'DV11', N'Ram', NULL, 1, 0, CAST(0x0000A3C8010C6F17 AS DateTime))
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'b9a5e059-4075-424c-b071-1125b8a46141', N'DV09', N'Hộp', NULL, 1, 0, CAST(0x0000A3C801073AB3 AS DateTime))
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'b2ed0e8c-8adc-47ad-afc6-293113aa9a37', N'DV01', N'Tấn', NULL, 0, 0, CAST(0x0000A3C701787868 AS DateTime))
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'daddb99a-5b59-461c-bc0e-31c1c8421d71', N'DV07', N'Lon', NULL, 1, 0, CAST(0x0000A3C80090AE3B AS DateTime))
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'92a56792-70ea-4f6a-8f69-51861c264c6b', N'DV04', N'Cái', NULL, 1, 0, CAST(0x0000A3C70178B99E AS DateTime))
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'73e3b375-8eaf-43f9-a5c3-54c1ff970d8b', N'DV08', N'Con', NULL, 1, 0, CAST(0x0000A3C80106E80E AS DateTime))
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'78b1474b-b168-46de-bbe5-aded80a22515', N'DV10', N'Gói', NULL, 1, 0, CAST(0x0000A3C80107905E AS DateTime))
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'297c392c-0233-489f-942e-b1e652980463', N'DV06', N'Thùng', NULL, 1, 0, CAST(0x0000A3C701837F5A AS DateTime))
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'c3c1d4ec-791e-4fff-ade1-c52f6120b383', N'DV05', N'Lít', NULL, 1, 0, CAST(0x0000A3C70178C2B7 AS DateTime))
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'199cff0c-c038-434c-b694-d4ae8c4de63c', N'DV03', N'Kí', NULL, 1, 0, CAST(0x0000A3C70178A202 AS DateTime))
INSERT [dbo].[Donvi] ([DonviId], [Code], [TenDonvi], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'49d31378-6898-4bb1-ab81-d4b55e1122bc', N'DV01', N'Chai', NULL, 1, NULL, CAST(0x0000A3D000A00541 AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'868d7f3c-5e33-474c-9dc0-0829fa8db835', N'TP005', N'CP Tim gà 500r', N'55d8d06f-1d8b-4411-aa84-bfa4b398ffe9', 55000, NULL, N'78b1474b-b168-46de-bbe5-aded80a22515', N'E:\Lee_chan\Hoctap\SVN_Repos_22_09_2014\trunk\B2B.Solution\B2B.Main\Images\Hinhhanghoa\CPTimGa500r.jpg', N'Đây là dữ liệu test', 0, NULL, CAST(0x0000A3CF00D1D53B AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'43678c68-ad25-4e29-bc72-1a4a91fd19ce', N'TP004', N'CP Cổ gà 1kg', N'55d8d06f-1d8b-4411-aa84-bfa4b398ffe9', 30000, NULL, N'78b1474b-b168-46de-bbe5-aded80a22515', N'E:\Lee_chan\Hoctap\SVN_Repos_22_09_2014\trunk\B2B.Solution\B2B.Main\Images\Hinhhanghoa\CPCoGaKhongDau1kg.jpg', NULL, 1, NULL, CAST(0x0000A3CF00D1D53B AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'cc2c2718-ed4c-45e1-97db-2c4cc8c64c0a', NULL, N'Ram 2gb', NULL, 400000, NULL, NULL, NULL, NULL, 1, 0, CAST(0x0000A3C800950610 AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'bf2397a1-4db9-42d8-88b5-3229e86b8d64', N'BN01', N'Bông lan', NULL, 12000, NULL, NULL, N'C:\Users\Ga9286\Desktop\SVN_Repos_22_09_2014\trunk\B2B.Solution\B2B.Main\Images\product.png', NULL, 0, NULL, CAST(0x0000A3D5009DFE39 AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'08bc90fb-ddaf-4253-89cd-3b4cfec4b47c', N'TP006', N'CP Mề gà 500r', N'55d8d06f-1d8b-4411-aa84-bfa4b398ffe9', 37000, NULL, N'78b1474b-b168-46de-bbe5-aded80a22515', N'E:\Lee_chan\Hoctap\SVN_Repos_22_09_2014\trunk\B2B.Solution\B2B.Main\Images\Hinhhanghoa\CPMeGa500r.jpg', NULL, 1, NULL, CAST(0x0000A3CF00D1D53B AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'dc6b1358-1871-49c3-956d-4d8d14cb38dc', N'TP001', N'CP Đùi Cánh 1kg', N'55d8d06f-1d8b-4411-aa84-bfa4b398ffe9', 66000, NULL, N'78b1474b-b168-46de-bbe5-aded80a22515', N'E:\Lee_chan\Hoctap\SVN_Repos_22_09_2014\trunk\B2B.Solution\B2B.Main\Images\Hinhhanghoa\CPDuiCanh1kg.jpg', NULL, 1, NULL, CAST(0x0000A3CF00D1D53B AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'd3cef42d-f8f2-4bd4-81bd-51e217a23adc', N'TP002', N'CP Cánh giữa 2kg', N'55d8d06f-1d8b-4411-aa84-bfa4b398ffe9', 105000, NULL, N'78b1474b-b168-46de-bbe5-aded80a22515', N'E:\Lee_chan\Hoctap\SVN_Repos_22_09_2014\trunk\B2B.Solution\B2B.Main\Images\Hinhhanghoa\CPCanhGiua2kg.jpg', NULL, 1, NULL, CAST(0x0000A3CF00D1D53B AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'fa0ae945-ba3b-48c8-b22d-5862e3aeb721', N'TP003', N'CP Cánh nguyên 1 kg', N'55d8d06f-1d8b-4411-aa84-bfa4b398ffe9', 72000, NULL, N'78b1474b-b168-46de-bbe5-aded80a22515', N'E:\Lee_chan\Hoctap\SVN_Repos_22_09_2014\trunk\B2B.Solution\B2B.Main\Images\Hinhhanghoa\CPCanhNguyen1kg.jpg', NULL, 1, NULL, CAST(0x0000A3CF00D1D53B AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'0911d350-307e-4e03-be45-6f05fd0c6ed1', N'TPCN001', N'Thực phẩm chức năng', NULL, 50000, NULL, NULL, NULL, NULL, 1, 0, CAST(0x0000A3D5009DFE39 AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'0911d351-307e-4e03-be45-6f05fd0c6ed1', N'TPCN001', N'Thực phẩm chức năng', NULL, 50000, NULL, NULL, NULL, NULL, 1, 0, CAST(0x0000A3A4000BF0A9 AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'fbf3a5c1-d122-425e-ac37-9a9a40f08294', N'HH03', N'coca', NULL, 67000, NULL, N'49d31378-6898-4bb1-ab81-d4b55e1122bc', NULL, NULL, 1, NULL, CAST(0x0000A3D5009DFE39 AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'7bbcd7c2-89fb-4f80-bbf9-b649f97bc2b8', N'NGK02', N'Cocacola 330ml', N'01bef387-3c5d-4614-b9f7-e74958f01a6f', 9000, NULL, N'daddb99a-5b59-461c-bc0e-31c1c8421d71', N'E:\Lee_chan\Hoctap\SVN_Repos_22_09_2014\trunk\B2B.Solution\B2B.Main\Images\Hinhhanghoa\cocacola300ml.jpg', NULL, 1, NULL, CAST(0x0000A3CF00CFE0E6 AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'1870bc86-23e5-490a-a592-ca1111b8b921', N'MILK001', N'TH Milk', NULL, 85000, NULL, NULL, NULL, NULL, 1, 0, CAST(0x0000A3D5009DFE39 AS DateTime))
INSERT [dbo].[Hanghoa] ([HanghoaId], [Code], [TenHanghoa], [NhomHanghoaId], [Giagoc], [Barcode], [DonviId], [LinkHinhanh], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'4e1bd986-0922-4ea3-9e95-da95a286c98c', N'HOA002', N'Hoa mười giờ', NULL, 110000, NULL, NULL, NULL, NULL, 1, 0, CAST(0x0000A3D5009DFE39 AS DateTime))
INSERT [dbo].[Khachhang] ([KhachhangId], [Code], [HotenKhachhang], [CMND], [Ngaysinh], [Gioitinh], [Diachi], [DiachiGiaohang], [QuanhuyenId], [TinhthanhId], [NhomKhachhangId], [Linkanh], [Congty], [Chucvu], [Email], [DiachiCongty], [PhoneCongty], [Tel], [Mobile], [Fax], [MasoThue], [TenTaikhoan], [SoTaikhoan], [Nganhang], [HanmucCongno], [ThoigianCongno], [ToahangCongno], [Ghichu], [NgayCapnhat], [Active], [Step], [AccountId]) VALUES (N'879f53a9-8d85-4337-ae0b-49a734152923', N'KH0003', N'Nguyễn Minh Trí', N'bé gà', NULL, 1, NULL, N'7 le lai, quan 10', N'c8c769a0-7d48-4d5d-b84d-4ebac3cbc0cf', N'd226207d-bb86-4603-b2fd-499ecbafad4c', NULL, NULL, NULL, NULL, NULL, N'0977777773', N'09666667777', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000A42A011D239F AS DateTime), 1, 0, NULL)
INSERT [dbo].[Khachhang] ([KhachhangId], [Code], [HotenKhachhang], [CMND], [Ngaysinh], [Gioitinh], [Diachi], [DiachiGiaohang], [QuanhuyenId], [TinhthanhId], [NhomKhachhangId], [Linkanh], [Congty], [Chucvu], [Email], [DiachiCongty], [PhoneCongty], [Tel], [Mobile], [Fax], [MasoThue], [TenTaikhoan], [SoTaikhoan], [Nganhang], [HanmucCongno], [ThoigianCongno], [ToahangCongno], [Ghichu], [NgayCapnhat], [Active], [Step], [AccountId]) VALUES (N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', N'KH0001', N'Nguyễn Khôi Nguyên', N'6754321895', CAST(0x0000749400000000 AS DateTime), 1, NULL, NULL, NULL, NULL, N'9527e29a-8527-4ba2-8063-6153c2963639', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000A3A9013BC3AC AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Khachhang] ([KhachhangId], [Code], [HotenKhachhang], [CMND], [Ngaysinh], [Gioitinh], [Diachi], [DiachiGiaohang], [QuanhuyenId], [TinhthanhId], [NhomKhachhangId], [Linkanh], [Congty], [Chucvu], [Email], [DiachiCongty], [PhoneCongty], [Tel], [Mobile], [Fax], [MasoThue], [TenTaikhoan], [SoTaikhoan], [Nganhang], [HanmucCongno], [ThoigianCongno], [ToahangCongno], [Ghichu], [NgayCapnhat], [Active], [Step], [AccountId]) VALUES (N'beecde87-5416-4e77-852c-b9b02e4d88bb', NULL, N'Phạm Xuân Vinh', N'test', CAST(0x0000824500000000 AS DateTime), 1, N'test', N'test', N'3809fb70-8de1-42f9-9fe0-0eba60cddd2c', N'ba1ec8a8-bdbe-4b4b-8441-b8eb3b55b894', NULL, NULL, N'test', N'test', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'34b4f9ab-7d28-49f4-9bc4-27d70c6eba85')
INSERT [dbo].[Khachhang] ([KhachhangId], [Code], [HotenKhachhang], [CMND], [Ngaysinh], [Gioitinh], [Diachi], [DiachiGiaohang], [QuanhuyenId], [TinhthanhId], [NhomKhachhangId], [Linkanh], [Congty], [Chucvu], [Email], [DiachiCongty], [PhoneCongty], [Tel], [Mobile], [Fax], [MasoThue], [TenTaikhoan], [SoTaikhoan], [Nganhang], [HanmucCongno], [ThoigianCongno], [ToahangCongno], [Ghichu], [NgayCapnhat], [Active], [Step], [AccountId]) VALUES (N'46129704-7faa-4f59-84da-e3ea41110725', N'KH0002', N'Phạm Xuân Vinh', N'test', CAST(0x0000824500000000 AS DateTime), 1, NULL, NULL, NULL, NULL, N'9527e29a-8527-4ba2-8063-6153c2963639', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000A3A80140AFFE AS DateTime), 1, NULL, NULL)
INSERT [dbo].[Khachhang] ([KhachhangId], [Code], [HotenKhachhang], [CMND], [Ngaysinh], [Gioitinh], [Diachi], [DiachiGiaohang], [QuanhuyenId], [TinhthanhId], [NhomKhachhangId], [Linkanh], [Congty], [Chucvu], [Email], [DiachiCongty], [PhoneCongty], [Tel], [Mobile], [Fax], [MasoThue], [TenTaikhoan], [SoTaikhoan], [Nganhang], [HanmucCongno], [ThoigianCongno], [ToahangCongno], [Ghichu], [NgayCapnhat], [Active], [Step], [AccountId]) VALUES (N'4b2022a3-337a-4263-b7b7-e8dfffa64e66', NULL, N'test', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'acd0465c-fd17-4056-a41e-84c7d4ea1865')
INSERT [dbo].[Kho] ([KhoId], [Code], [TenKho], [Diachi], [QuanhuyenId], [TinhthanhId], [Ghichu], [NgayCapnhat], [Active], [Step]) VALUES (N'86b518ed-982a-43bf-b8f0-1f34c1bb341d', N'KH03', N'bảo an', N'123 lê duẩn', N'e904a30a-b564-4cba-8cdf-39100e104985', N'916418f4-578b-4c84-b7a9-3aa630449108', NULL, CAST(0x0000A3D0009C2CD3 AS DateTime), 1, NULL)
INSERT [dbo].[Kho] ([KhoId], [Code], [TenKho], [Diachi], [QuanhuyenId], [TinhthanhId], [Ghichu], [NgayCapnhat], [Active], [Step]) VALUES (N'51de065a-b1f3-48c0-8216-6093effd417e', N'KH01', N'vĩnh phát', N'5 cầu dứa', N'f79f2515-dc23-4f04-9321-494c68bc1cf2', N'd226207d-bb86-4603-b2fd-499ecbafad4c', N'cập nhật thông tin kho', CAST(0x0000A3D0009C0D8F AS DateTime), 1, NULL)
INSERT [dbo].[Kho] ([KhoId], [Code], [TenKho], [Diachi], [QuanhuyenId], [TinhthanhId], [Ghichu], [NgayCapnhat], [Active], [Step]) VALUES (N'3df32d79-032b-402b-bac5-60ae8edbca26', N'KH11', N'lưu trữ', N'56 thống nhất', N'03efac9e-ab7d-48cd-9baa-bcf7a2b1b462', N'd226207d-bb86-4603-b2fd-499ecbafad4c', N'kho lưu trữ thiết bị , phụ tùng', CAST(0x0000A3D0009DB9C3 AS DateTime), 1, NULL)
INSERT [dbo].[Kho] ([KhoId], [Code], [TenKho], [Diachi], [QuanhuyenId], [TinhthanhId], [Ghichu], [NgayCapnhat], [Active], [Step]) VALUES (N'3b747b8c-fc0f-429a-9da2-6fd6d07e873b', N'KH04', N'96 lê lai', N'96 lê lai', N'5a93ac00-baf1-44cd-90ac-d22a116f627b', N'd226207d-bb86-4603-b2fd-499ecbafad4c', N'cập nhật', CAST(0x0000A3D0009D6CB0 AS DateTime), 1, NULL)
INSERT [dbo].[Kho] ([KhoId], [Code], [TenKho], [Diachi], [QuanhuyenId], [TinhthanhId], [Ghichu], [NgayCapnhat], [Active], [Step]) VALUES (N'160295af-7791-4416-9f90-8a8ea97af8e0', N'KH13', N'thiết bị', NULL, NULL, NULL, NULL, CAST(0x0000A3D0009D6CB0 AS DateTime), 1, NULL)
INSERT [dbo].[Khuvuc] ([KhuvucId], [Code], [TenKhuvuc], [Active], [Ghichu], [Step], [NgayCapnhat]) VALUES (N'47eca693-a55d-4be2-9e0c-30c80f290a57', N'MN', N'Miền Nam', 0, NULL, 0, CAST(0x0000A38E016007AF AS DateTime))
INSERT [dbo].[Khuvuc] ([KhuvucId], [Code], [TenKhuvuc], [Active], [Ghichu], [Step], [NgayCapnhat]) VALUES (N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', N'MT', N'Miền Trung', 1, NULL, 0, CAST(0x0000A38C017E3B55 AS DateTime))
INSERT [dbo].[Khuvuc] ([KhuvucId], [Code], [TenKhuvuc], [Active], [Ghichu], [Step], [NgayCapnhat]) VALUES (N'0020988d-7765-45b0-8378-f5427a7a4dfe', N'MB', N'Miền Bắc', 1, NULL, 0, CAST(0x0000A38C017E3B55 AS DateTime))
INSERT [dbo].[NguyennhanLydo] ([NguyennhanLydoId], [Code], [Noidung], [Active], [Ghichu], [Step]) VALUES (N'e32c0670-840e-405d-9dff-15cffd0ab115', N'Test', N'Test', 1, NULL, NULL)
INSERT [dbo].[NguyennhanLydo] ([NguyennhanLydoId], [Code], [Noidung], [Active], [Ghichu], [Step]) VALUES (N'1d244606-476f-4366-ae3f-b3d2ea5f5b92', N'lala', N'lala', 1, NULL, NULL)
INSERT [dbo].[NhaCungcap] ([NhaCungcapId], [Code], [TenNhaCungcap], [Diachi], [QuanhuyenId], [TinhthanhId], [TenCongty], [Fax], [Tel], [Mobile], [Email], [Website], [TenTaikhoan], [SoTaikhoan], [Nganhang], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'e32c0670-840e-405d-9dff-15cffd0ab115', N'NCC01', N'Sunrise', N'2 hùng vương', N'6a36ec57-30fd-4e1e-9cbe-5a31a79843ea', N'd226207d-bb86-4603-b2fd-499ecbafad4c', N'Sunrise CO', NULL, N'08899966', N'090556666', N'sunco@gmail.com', NULL, NULL, NULL, NULL, N'Cập nhật thông tin ', 1, NULL, CAST(0x0000A3D0008F71B1 AS DateTime))
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'd835daa9-4744-4031-a033-037ba3b36d48', N'BH007', N'Bảo Trân', N'Nguyễn', N'Nguyễn Bảo Trân', N'', NULL, NULL, NULL, N'baotran@gmail.com', N'090566789', NULL, N'3 lê đại hành', N'bf5ad40f-5489-4b35-8ca9-16b6ed6ef723', N'd226207d-bb86-4603-b2fd-499ecbafad4c', NULL, NULL, CAST(0x0000A3CF0184B771 AS DateTime), N'Nhân viên bán hàng
Nội dung ghi chú:
abc
xyz', 1, NULL, N'C:\Users\Ga9286\Desktop\SVN_Repos_22_09_2014\trunk\B2B.Solution\B2B.Main\Images\Employee_32x32.png', NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', N'BH006', N'Hoàng Yến', N'Đỗ', N'Nguyễn Hoàng Yến', NULL, NULL, N'ae1535fb-ec9d-45a8-bd00-7a7f6f21f2f5', NULL, N'yenhoang@mail.com', N'01222552323', NULL, NULL, NULL, N'dc23cef3-e91b-42ea-a91b-0c9f69ef0667', NULL, NULL, CAST(0x0000A3CF0184B771 AS DateTime), NULL, 1, 2, N'C:\Users\Ga9286\Desktop\B2B\B2B.Solution\B2B.Main\Images\Actor_32x32.png', NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'8a6b4c31-da94-414c-87e1-2140a66cca17', N'BH004', N'Tân', N'Nguyễn', NULL, NULL, NULL, N'c13e3faf-da25-4bc6-9706-a9420488553c', NULL, N'tanpham@gmail.com', N'067743441', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DFE9 AS DateTime), NULL, CAST(0x0000A3CF0184B77F AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'24341424-4731-497f-be36-3708d3761466', N'BH0013', N'Lê my', N'Nguyễn', NULL, NULL, NULL, N'ae1535fb-ec9d-45a8-bd00-7a7f6f21f2f5', NULL, N'yenhoang@mail.com', N'01222552323', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DA06 AS DateTime), NULL, CAST(0x0000A3CF0184B771 AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'167a5880-21d5-443d-9803-48e53cb7b2ba', N'BH005', N'Anh', N'Pham', NULL, NULL, NULL, N'c13e3faf-da25-4bc6-9706-a9420488553c', NULL, N'tanpham@gmail.com', N'067743441', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DFE9 AS DateTime), NULL, CAST(0x0000A3CF0184B77F AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'63c744b8-25ab-46cf-8556-49cf2af8f94d', N'BH009', N'Hùng', N'Hải', NULL, NULL, NULL, N'35426579-2e71-4ee5-8e67-bba212a18bde', NULL, N'baochau@hotmail.com', N'0903332323', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DD2C AS DateTime), NULL, CAST(0x0000A3CF0184B77F AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'07c2363f-8121-43a0-982d-597bfb39c919', N'BH008', N'Bảo Trân', N'Nguyên thị', NULL, NULL, NULL, NULL, NULL, N'baotran@gmail.com', N'090566789', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DFE9 AS DateTime), NULL, CAST(0x0000A3CF0184B771 AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'78d61a68-ae74-44a9-9017-619233e729c7', N'BH012', N'Tân', N'Nguyễn', NULL, NULL, NULL, N'c13e3faf-da25-4bc6-9706-a9420488553c', NULL, N'tanpham@gmail.com', N'067743441', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DD2C AS DateTime), NULL, CAST(0x0000A3CF0184B77F AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'ee948913-f732-4727-bd87-6563454b93f2', N'TK0013', N'Yến', N'Hải', NULL, NULL, NULL, N'35426579-2e71-4ee5-8e67-bba212a18bde', NULL, N'baochau@hotmail.com', N'0903332323', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DFE9 AS DateTime), NULL, CAST(0x0000A3CF0184B77F AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'7b869271-9dbb-45a6-be32-6a1e2540ad44', N'TK0021', N'Phát', N'Đỗ', NULL, NULL, NULL, N'ae1535fb-ec9d-45a8-bd00-7a7f6f21f2f5', NULL, N'yenhoang@mail.com', N'01222552323', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DD2C AS DateTime), NULL, CAST(0x0000A3CF0184B771 AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'8ac750dc-7a3f-4c69-b7b8-6a7abcd8be42', N'TK023', N'Bảo Trân', N'Nguyễn Thành', NULL, NULL, NULL, NULL, NULL, N'baotran@gmail.com', N'090566789', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DFE9 AS DateTime), NULL, CAST(0x0000A3CF0184B771 AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'69aca4e8-af02-4c5b-ab6e-7db1998900ad', N'TK003', N'Trâm', N'Bảo', NULL, NULL, NULL, NULL, NULL, N'baotran@gmail.com', N'090566789', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DFE9 AS DateTime), NULL, CAST(0x0000A3CF0184B771 AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'b6d99c67-c0e7-4271-a51e-97ed4dd58dd1', N'TK001', N'Dung', N'Đặng', NULL, NULL, NULL, NULL, NULL, N'baotran@gmail.com', N'090566789', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DA06 AS DateTime), NULL, CAST(0x0000A3CF0184B771 AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'9df573ed-aa88-439d-886c-9d39cb2bf786', N'TK001', N'Tân', N'Nguyễn', N'Nguyễn Tân', NULL, NULL, N'c13e3faf-da25-4bc6-9706-a9420488553c', NULL, N'tanpham@gmail.com', N'067743441', NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000A3CF0184B77F AS DateTime), NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'c5b698d2-ca04-4318-891c-9e29f6ea6030', N'QL005', N'Hùng', N'Đinh', NULL, NULL, NULL, N'c13e3faf-da25-4bc6-9706-a9420488553c', NULL, N'tanpham@gmail.com', N'067743441', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DA06 AS DateTime), NULL, CAST(0x0000A3CF0184B77F AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'e9ef4742-62bb-4aea-8a3e-b60b4c772378', N'QL002', N'Anh', N'Lê', NULL, NULL, NULL, NULL, NULL, N'baotran@gmail.com', N'090566789', NULL, NULL, NULL, NULL, CAST(0x0000A3CF0186DD2C AS DateTime), NULL, CAST(0x0000A3CF0184B771 AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[Nhanvien] ([NhanvienId], [Code], [TenNhanvien], [HoNhanvien], [HovatenNhanvien], [CMND], [Ngaysinh], [PhongbanId], [Gioitinh], [Email], [Tel], [Mobile], [Diachi], [QuanhuyenId], [TinhthanhId], [NgayBatdau], [NgayKetthuc], [NgayCapnhat], [Ghichu], [Active], [Step], [Linkanh], [AccountId]) VALUES (N'78c93497-cd58-4764-824a-bc1e5e9f7397', N'KT003', N'Lê', N'Trần My', N'Hải Yến', NULL, NULL, N'35426579-2e71-4ee5-8e67-bba212a18bde', NULL, N'baochau@hotmail.com', N'0903332323', N'0122233', NULL, N'8fd90345-a274-4336-ac6a-5c205f7cc0e2', N'd226207d-bb86-4603-b2fd-499ecbafad4c', NULL, NULL, CAST(0x0000A3CF0184B77F AS DateTime), NULL, 1, 0, NULL, NULL)
INSERT [dbo].[NhomHanghoa] ([NhomHanghoaId], [Code], [TenNhomHanghoa], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'b8366e6b-2bd1-498f-ae3e-1ea382026d28', N'NHH005', N'Điện thoại di động', N'Đây là dữ liệu test', 1, NULL, CAST(0x0000A3C8010E685C AS DateTime))
INSERT [dbo].[NhomHanghoa] ([NhomHanghoaId], [Code], [TenNhomHanghoa], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'9fff9fc1-d9ae-4b63-b9a2-86e5dc484c8c', N'NHH006', N'Nguyên liệu', NULL, 1, NULL, CAST(0x0000A3C7017EC456 AS DateTime))
INSERT [dbo].[NhomHanghoa] ([NhomHanghoaId], [Code], [TenNhomHanghoa], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'55d8d06f-1d8b-4411-aa84-bfa4b398ffe9', N'NHH002', N'Thực phẩm', NULL, 1, NULL, CAST(0x0000A3C7017EC456 AS DateTime))
INSERT [dbo].[NhomHanghoa] ([NhomHanghoaId], [Code], [TenNhomHanghoa], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'01bef387-3c5d-4614-b9f7-e74958f01a6f', N'NHH001', N'Nước giải khát', NULL, 1, NULL, CAST(0x0000A3C7017EC455 AS DateTime))
INSERT [dbo].[NhomHanghoa] ([NhomHanghoaId], [Code], [TenNhomHanghoa], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'eddfdcd4-69fe-4746-bb80-eb81643c7ad0', N'NHH003', N'Linh kiện điện tử', NULL, 1, NULL, CAST(0x0000A3C7017EC456 AS DateTime))
INSERT [dbo].[NhomHanghoa] ([NhomHanghoaId], [Code], [TenNhomHanghoa], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'66d18cf4-ac2e-4500-b84b-f0f0a6a820a9', N'NHH004', N'Laptop', NULL, 1, NULL, CAST(0x0000A3C7017EC456 AS DateTime))
INSERT [dbo].[NhomKhachhang] ([NhomKhachhangId], [Code], [TenNhomKhachhang], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'9527e29a-8527-4ba2-8063-6153c2963639', NULL, N'nhom2', NULL, 1, NULL, CAST(0x0000A3A4000BCF69 AS DateTime))
INSERT [dbo].[NhomKhachhang] ([NhomKhachhangId], [Code], [TenNhomKhachhang], [Ghichu], [Active], [Step], [NgayCapnhat]) VALUES (N'5261e52f-b517-473f-90b1-75d5e34a9931', N'', N'nhosm 1', NULL, 1, NULL, CAST(0x0000A3A4000BCF69 AS DateTime))
INSERT [dbo].[Phieunhap] ([PhieunhapId], [Code], [NhanvienId], [KhoId], [NhacungcapId], [Ngaylap], [Ghichu], [Step], [NguyennhanLydo]) VALUES (N'ef5cdafe-b9a5-4fd9-97a3-37330046d244', NULL, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', N'160295af-7791-4416-9f90-8a8ea97af8e0', N'e32c0670-840e-405d-9dff-15cffd0ab115', CAST(0x0000A3D5009BB56F AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Phieunhap] ([PhieunhapId], [Code], [NhanvienId], [KhoId], [NhacungcapId], [Ngaylap], [Ghichu], [Step], [NguyennhanLydo]) VALUES (N'a6e1d7c6-223f-4cc1-820f-4c035b273d29', NULL, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', N'51de065a-b1f3-48c0-8216-6093effd417e', N'e32c0670-840e-405d-9dff-15cffd0ab115', CAST(0x0000A3D5009995AC AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Phieunhap] ([PhieunhapId], [Code], [NhanvienId], [KhoId], [NhacungcapId], [Ngaylap], [Ghichu], [Step], [NguyennhanLydo]) VALUES (N'4eeb6262-0a60-4d8e-842d-9d032a4a0299', NULL, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', N'51de065a-b1f3-48c0-8216-6093effd417e', N'e32c0670-840e-405d-9dff-15cffd0ab115', CAST(0x0000A3D500975E87 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Phieunhap] ([PhieunhapId], [Code], [NhanvienId], [KhoId], [NhacungcapId], [Ngaylap], [Ghichu], [Step], [NguyennhanLydo]) VALUES (N'2d2eb9d8-997e-422a-a044-c182f78a9053', NULL, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', N'160295af-7791-4416-9f90-8a8ea97af8e0', N'e32c0670-840e-405d-9dff-15cffd0ab115', CAST(0x0000A3D5009BC741 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Phieunhap] ([PhieunhapId], [Code], [NhanvienId], [KhoId], [NhacungcapId], [Ngaylap], [Ghichu], [Step], [NguyennhanLydo]) VALUES (N'06184c17-f111-4871-a4e6-c36f8e814e0f', NULL, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', N'86b518ed-982a-43bf-b8f0-1f34c1bb341d', N'e32c0670-840e-405d-9dff-15cffd0ab115', CAST(0x0000A3D50099DE06 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Phieunhap] ([PhieunhapId], [Code], [NhanvienId], [KhoId], [NhacungcapId], [Ngaylap], [Ghichu], [Step], [NguyennhanLydo]) VALUES (N'dcdd9789-72cd-443e-a493-cbd435b60087', NULL, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', N'51de065a-b1f3-48c0-8216-6093effd417e', N'e32c0670-840e-405d-9dff-15cffd0ab115', CAST(0x0000A3D500C2ED72 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Phieuxuat] ([PhieuxuatId], [Code], [NhanvienLapId], [KhoId], [DonhangId], [Ngaylap], [NhanvienGiaohangId], [TenTinhtrangPhieuxuat], [NgayCapnhat], [Ghichu], [Step], [NguyennhanLydo], [TinhtrangPhieuxuatCurrentId], [NhanvienDonhang], [Tongtien]) VALUES (N'227ffa18-12eb-4cae-8047-2c6183054ed0', N'Test2211', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', N'86b518ed-982a-43bf-b8f0-1f34c1bb341d', N'6ddb81d4-da4f-4398-a64e-bbe4c326b182', CAST(0x0000A3EB00B1AAE9 AS DateTime), N'd835daa9-4744-4031-a033-037ba3b36d48', N'Tình trạng đã lập', CAST(0x0000A40C00BED35A AS DateTime), N'Đây là dữ liệu test ngày 22/11', NULL, N'1d244606-476f-4366-ae3f-b3d2ea5f5b92', N'd7b23481-b371-46dc-8d76-ca010774b42b', NULL, 1000000)
INSERT [dbo].[Phieuxuat] ([PhieuxuatId], [Code], [NhanvienLapId], [KhoId], [DonhangId], [Ngaylap], [NhanvienGiaohangId], [TenTinhtrangPhieuxuat], [NgayCapnhat], [Ghichu], [Step], [NguyennhanLydo], [TinhtrangPhieuxuatCurrentId], [NhanvienDonhang], [Tongtien]) VALUES (N'8e699c8f-011b-401b-acd6-89126f85caea', N'TEST', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', N'86b518ed-982a-43bf-b8f0-1f34c1bb341d', N'6ddb81d4-da4f-4398-a64e-bbe4c326b182', CAST(0x0000A3E200F0BA15 AS DateTime), N'd835daa9-4744-4031-a033-037ba3b36d48', N'Test', CAST(0x0000A40C00BED35B AS DateTime), N'Đây là dữ liệu test', NULL, N'e32c0670-840e-405d-9dff-15cffd0ab115', NULL, NULL, 2000000)
INSERT [dbo].[Phongban] ([PhongbanId], [Code], [TenPhongban], [Ghichu], [NgayCapnhat], [Active], [Step]) VALUES (N'ae1535fb-ec9d-45a8-bd00-7a7f6f21f2f5', N'PB005', N'quản lý', NULL, CAST(0x0000A3CF015B0802 AS DateTime), 1, NULL)
INSERT [dbo].[Phongban] ([PhongbanId], [Code], [TenPhongban], [Ghichu], [NgayCapnhat], [Active], [Step]) VALUES (N'1fb1fe79-e770-4567-aebd-8b09b86743a6', N'PB002', N'bán hàng', N'test dữ liệu
', CAST(0x0000A3CF015B0803 AS DateTime), 1, NULL)
INSERT [dbo].[Phongban] ([PhongbanId], [Code], [TenPhongban], [Ghichu], [NgayCapnhat], [Active], [Step]) VALUES (N'c13e3faf-da25-4bc6-9706-a9420488553c', N'PB007', N'Thủ kho', N'demo', CAST(0x0000A3CF015B0803 AS DateTime), 1, NULL)
INSERT [dbo].[Phongban] ([PhongbanId], [Code], [TenPhongban], [Ghichu], [NgayCapnhat], [Active], [Step]) VALUES (N'35426579-2e71-4ee5-8e67-bba212a18bde', N'PB001', N'Phòng kế toán', N'Thêm phòng kế toán cho dữ liệu nền', CAST(0x0000A3CF015B0803 AS DateTime), 1, NULL)
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'80e6e363-5d51-4089-8451-001bf2a7e043', N'3206', N'H Triệu Phong', 1, NULL, N'8c8f0507-588c-4c51-843f-41dec2f2d0e7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9b750782-f97f-4c75-891a-0029bccafb31', N'6003', N'H Hồng Dân', 1, NULL, N'2c1152a3-d2f7-42c7-a4e7-85a4eb519e29', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1da7c019-f747-4957-adec-006adc5620b8', N'1308', N'H Trạm Tấu', 1, NULL, N'b5edd6e0-91bf-4294-ade4-33ad54c993bf', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b4426f59-b801-477f-99b3-00bf33fc9ad0', N'3505', N'H Sơn Tịnh', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'304ac0be-cf75-45aa-9ae5-00f2de359417', N'3502', N'H Lý Sơn', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'349a7186-5780-4107-97e8-0151dbcef5a9', N'4405', N'H Dĩ An', 1, NULL, N'218bf6a8-128a-4282-b628-091a28c7ba72', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2809c2bd-2743-4185-ab80-016a66e65008', N'6103', N'H U Minh', 1, NULL, N'340f9b94-1df9-4ae5-9fee-61cd234ca532', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'cb409f33-1f36-4eba-8b3c-02b6089365a3', N'3514', N'H Tây Trà', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f23f4f98-16de-47d5-abb9-02f013613e77', N'0704', N'H Sìn Hồ', 1, NULL, N'112c407c-448c-411d-a1c5-50d16d4980a1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'49676557-c969-43df-9f40-02f8cb8feeb6', N'0218', N'Q Thủ Đức', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c21b1f56-1dc5-42c4-a7b0-02f98c155a35', N'2912', N'H Diễn Châu', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0ef9436b-4125-4357-9678-038236f96d05', N'5608', N'H Thạnh Phú', 1, NULL, N'cfb493d0-47f9-4528-bdf1-b5b42d2a7440', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'edf40721-72ca-48ea-bfbe-03e431c72f10', N'4802', N'H Vĩnh Cửu', 1, NULL, N'21ea9975-e024-45eb-89d5-3d4b1d44e656', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1f6cffa1-f653-4419-b291-0422b201bc03', N'3606', N'H Kon Plong', 1, NULL, N'03ccc7fc-d0be-4e51-9ab3-186515080313', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'bf6e7091-86d6-4eff-8a2c-04450e72f937', N'1907', N'H Gia Bình', 1, NULL, N'58a665e3-85d3-4dd0-b01d-f7a5ddcb2114', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'eed30151-2f38-4634-9b26-044620ac90ae', N'4911', N'H Tân Trụ', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'750254ff-a5a3-482b-bb1b-05a6137121d8', N'3812', N'H Ia Grai', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8f0ad4eb-dd44-470b-97f2-0616e166682e', N'2706', N'H Yên Mô', 1, NULL, N'56ee4087-9b4b-41c8-965f-da43f3fedc21', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a9ff7c53-bd46-4cde-b419-06cf056f977c', N'3905', N'H Sơn Hòa', 1, NULL, N'36d607e5-3d4a-41c6-85f1-f101a555c654', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'44ed863f-1bef-47c9-82b8-06fff1e2eb00', N'5607', N'H Ba Tri', 1, NULL, N'cfb493d0-47f9-4528-bdf1-b5b42d2a7440', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'27cefc56-a2ac-49b9-9ca0-07006f1b02c6', N'5908', N'H Cù Lao Dung', 1, NULL, N'ceeb3bb7-3959-45a3-a6c7-657408731438', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'69e6311f-d4c2-4271-9219-073c8dd31722', N'5308', N'H Gò Công Đông', 1, NULL, N'673308b5-dc96-4e1e-b578-3e5691a68f1e', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd63afb23-7d18-4f77-b32a-07b0d583bb29', N'3001', N'TX Hà Tĩnh', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3bc189dd-cefb-46b1-a1db-0820607a8c1b', N'5806', N'H Trà Cú', 1, NULL, N'72a67ef4-0a80-4bc3-a047-435f64b76a53', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8ac21751-e462-41ab-b837-08928af55492', N'1307', N'H Trấn Yên', 1, NULL, N'b5edd6e0-91bf-4294-ade4-33ad54c993bf', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'751ee33c-fb50-432f-ae04-09428ea37a6f', N'1303', N'H Văn Yên', 1, NULL, N'b5edd6e0-91bf-4294-ade4-33ad54c993bf', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c3487b20-3e99-4df3-b596-09dbff27b72e', N'0301', N'Q Hồng Bàng', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'36f0bf3e-04bb-47e5-80f5-09fdc9b9d165', N'1906', N'H Thuận Thành', 1, NULL, N'58a665e3-85d3-4dd0-b01d-f7a5ddcb2114', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'78988b55-4b9d-4eba-b186-0a3782ed8773', N'3417', N'H Phú Ninh', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'46e62981-b230-44d0-a610-0ad567a63a19', N'1306', N'H Văn Chấn', 1, NULL, N'b5edd6e0-91bf-4294-ade4-33ad54c993bf', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a2e993a4-9b56-47b1-b2ec-0b50b6a6d2b9', N'0208', N'Quận 8', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f83a695f-c424-42f2-8533-0b79b8042c43', N'0509', N'H Xín Mần', 1, NULL, N'54498638-d285-4aa1-b84b-972ebe00f78d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ab3ac22d-48c0-4ac6-8373-0d50b76b29d5', N'4202', N'TX Bảo Lộc', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'79f337a7-0985-4f36-876e-0e02f53ab1ba', N'3208', N'H Hướng Hóa', 1, NULL, N'8c8f0507-588c-4c51-843f-41dec2f2d0e7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6adb0127-a3ab-48db-bb0e-0e358eb7a41b', N'4209', N'H Cát Tiên', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3809fb70-8de1-42f9-9fe0-0eba60cddd2c', N'5203', N'H Xuyên Mộc', 1, NULL, N'ba1ec8a8-bdbe-4b4b-8441-b8eb3b55b894', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e1b200f1-1db8-42c2-9026-0f33b46dcf70', N'0219', N'Q Bình Tân', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4a24aab6-322f-421d-8d74-0fe8eb29c8f1', N'5706', N'H Trà ôn', 1, NULL, N'35d84f30-2ee0-4fb6-b408-4a438b472abc', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'513c791e-3669-448d-a450-1006c5a07805', N'4009', N'H M''Đrăk', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1ed28e25-015e-453c-af80-10d1683948c7', N'2707', N'H Kim Sơn', 1, NULL, N'56ee4087-9b4b-41c8-965f-da43f3fedc21', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ad5c1047-a6f2-4bc3-8cd2-10ff00cef931', N'4109', N'H Cam Lâm', 1, NULL, N'5dcda423-8bc0-405c-b111-7b4129ee9129', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'31c1781a-3cb6-49ce-9aa3-11fbab67b7f7', N'4006', N'H Cư M Gar', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7ce75cc7-3e9b-435a-b5c8-127d89539a12', N'1401', N'TX Sơn La', 1, NULL, N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fe6494a2-c0da-43fb-a1a2-12cd2ce65521', N'2306', N'H Kỳ Sơn', 1, NULL, N'89952828-32e3-4b69-9d02-f58dc73fe1b1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'18efa86d-4d35-480d-91fa-1314dfe5d4a3', N'1009', N'H Chi Lăng', 1, NULL, N'5bad1676-5593-4b79-af80-cd9a1739bdb4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a92b387d-82d2-4f23-a97a-134929be707d', N'3003', N'H Hương Sơn', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'22aab689-2b20-4541-be69-1434d7fd144b', N'5009', N'H Tháp Mười', 1, NULL, N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'86212ab6-9ed4-4087-adde-1435f2bf4557', N'0109', N'Q Long Biên', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ce3e015c-f6c0-4737-882b-14ea4c049478', N'5402', N'TX Hà Tiên', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'440aeea0-cca0-4f67-ad0f-1585eaccf9ca', N'2301', N'TX Hòa Bình', 1, NULL, N'89952828-32e3-4b69-9d02-f58dc73fe1b1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'096ef069-1b2e-4164-893a-15cf2c9e4792', N'6401', N'TX Vị Thanh', 1, NULL, N'207a629f-6eed-4352-8eb5-d398d72cad67', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'85ff1ad0-59f7-47ff-8ebb-164c0dcfcfdf', N'0404', N'Q Ngũ Hành Sơn', 1, NULL, N'c29aa669-3b60-4950-bdde-2ba6a00c2507', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'71e1e206-e054-4565-82b9-169d3b45c07d', N'1701', N'TP Hạ Long', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'bf5ad40f-5489-4b35-8ca9-16b6ed6ef723', N'0206', N'Quận 6', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'47eb808f-3033-47c9-bea4-171c01bf4d66', N'5702', N'H Long Hồ', 1, NULL, N'35d84f30-2ee0-4fb6-b408-4a438b472abc', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b4a3d8a0-f1bf-47c7-9c23-172ab556bb60', N'2810', N'H Như Thanh', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3c823556-ef54-4c94-b1a6-173d4c404c81', N'4302', N'H Đồng Phú', 1, NULL, N'648cd679-d07b-44c4-8ef6-ce4f45aaad4f', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b5c8fb75-30c1-4dba-bd77-175ffc25f1dc', N'3814', N'H Ia Pa', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'67f72b97-272c-4f6f-9638-178d044abf3d', N'2602', N'H Quỳnh Phụ', 1, NULL, N'd3b03a88-e912-409d-ba98-f46022c21d1c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'646ffa87-69bb-46f5-8565-1822eea50ce2', N'5409', N'H An Biên', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'69622141-f941-4caf-a537-183849d76add', N'1810', N'H Yên Dũng', 1, NULL, N'912ceefc-bbf6-4f1c-8dbf-a35d1408e2ff', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f3d9d354-c1ad-4474-be21-1844b3272794', N'0505', N'H Quản Bạ', 1, NULL, N'54498638-d285-4aa1-b84b-972ebe00f78d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c3f3a7ca-5226-404f-bde8-189415180a31', N'4201', N'TP Đà Lạt', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8e61a3fd-2236-4eb1-8018-18d63089683f', N'2508', N'H Trực Ninh', 1, NULL, N'34ab5555-3bee-40a5-a974-32c5b808f03b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a6c264d8-a8aa-49db-85c9-198f6ca64d48', N'3012', N'H Lộc Hà', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1a3e9d94-43b7-47b6-9329-1a02c5559d71', N'6206', N'H Tủa Chùa', 1, NULL, N'f8147816-2225-43a6-8662-e3770fc549bd', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c03a9ae0-9b88-4d34-b6d1-1a13f6903216', N'5407', N'H Giồng Riềng', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3535135a-9887-452c-9f63-1a5a0b73f3b5', N'0903', N'H Chiêm Hóa', 1, NULL, N'53a568c0-2ae3-461e-9588-e9b8f821a01c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2ad579a0-da12-4d97-86fa-1a99e1c409b1', N'0116', N'TX Sơn Tây', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2565a65d-3b18-401b-bf4a-1b15919bc5d1', N'4401', N'TX Thủ Dầu Một', 1, NULL, N'218bf6a8-128a-4282-b628-091a28c7ba72', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'770196aa-00a6-4e78-8e66-1bbd0290b984', N'2310', N'H Yên Thủy', 1, NULL, N'89952828-32e3-4b69-9d02-f58dc73fe1b1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a286c807-d22e-4fed-83d5-1c30b8a42843', N'0311', N'H Tiên Lãng', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ab4d859a-a9b3-4d7c-92f4-1d34b2217e4c', N'4807', N'H Xuân Lộc', 1, NULL, N'21ea9975-e024-45eb-89d5-3d4b1d44e656', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'70e7e264-cb79-4870-a56d-1daed2a71557', N'4804', N'H Định Quán', 1, NULL, N'21ea9975-e024-45eb-89d5-3d4b1d44e656', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e3120ef5-8cb3-4147-b5ff-1e03896b837a', N'5906', N'H Long Phú', 1, NULL, N'ceeb3bb7-3959-45a3-a6c7-657408731438', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'93de7383-3ca4-4d07-a9a0-1e1471c870c4', N'1601', N'TX Vĩnh Yên', 1, NULL, N'21fbf0a7-7939-4ff7-aee4-822e7869ddd2', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd2b5e92f-c984-4608-af3f-20113b5e66c4', N'1714', N'H Cô Tô', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f2fe0136-f45b-4b6a-95ae-20d50935d793', N'3202', N'TX Quảng Trị.', 1, NULL, N'8c8f0507-588c-4c51-843f-41dec2f2d0e7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3e87a3f6-8989-4a8d-a85f-214be82b1d4a', N'3101', N'TX Đồng Hới', 1, NULL, N'ccfeec9e-e27f-4a60-b5d4-8a638b798a3b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'57cc9b0a-e812-4684-8ed6-215f7ab3ce74', N'1603', N'H Lập Thạch', 1, NULL, N'21fbf0a7-7939-4ff7-aee4-822e7869ddd2', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'54b528ad-23bb-40d7-b19d-22160fa04193', N'3608', N'H Kon Rộy', 1, NULL, N'03ccc7fc-d0be-4e51-9ab3-186515080313', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4a5be936-96d5-4ad3-bf07-22716189d5bc', N'0402', N'Q Thanh Khê', 1, NULL, N'c29aa669-3b60-4950-bdde-2ba6a00c2507', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'03c9edfa-df01-4e3e-b466-239d6418feab', N'2205', N'H Yên Mỹ', 1, NULL, N'13f07126-2fd4-4954-9f65-7c3409f8bd35', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd0f62b36-55ac-49c2-84e4-24a1c27da60c', N'0101', N'Q Ba Đình', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3bc8a824-8629-42c3-8066-25bbb5ef019c', N'3507', N'H Tư Nghĩa', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2ed766c8-5653-4ec1-8cc4-261f4c7ee8cb', N'2906', N'H Quỳnh Lưu', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'67f4be80-c4cd-4eea-abc4-2653495b5dc6', N'1005', N'H Bắc Sơn', 1, NULL, N'5bad1676-5593-4b79-af80-cd9a1739bdb4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ec53c4e5-a091-44b6-839b-2676be468239', N'3410', N'H Tiên Phước', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6f252e30-718e-4cf8-b5ce-267b4bdda063', N'2402', N'H Duy Tiên', 1, NULL, N'791c45b8-1d33-4728-b08b-83b4027c8cb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'db4c778d-5335-4c73-b460-267fae747e69', N'1501', N'TP Việt Trì', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3de884b7-eb04-435e-9bbb-274119f178ad', N'2914', N'H Đô Lương', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4b725def-2334-4a4d-be22-27ad5ca284f9', N'0203', N'Quận 3', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4e8c40c1-a021-440e-9a01-28880e3e1ace', N'5601', N'TX Bến Tre', 1, NULL, N'cfb493d0-47f9-4528-bdf1-b5b42d2a7440', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ca14a93b-5490-435f-8f89-28b2fb59305b', N'3405', N'H Đại Lộc', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8b379756-beb1-4d24-9d0e-2900e50ebde2', N'0613', N'H Phục Hoà', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c446e6e3-33a8-4baa-9d5e-2995fe45999a', N'4602', N'H Tân Biên', 1, NULL, N'66c4231e-f04c-4687-954f-300eb34991c4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f5e521e1-df33-43f7-b468-29d90ee7f9a3', N'4208', N'H Đạ Tẻh', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7144739c-c1ad-4884-a6d9-2a19659e877c', N'0806', N'H Văn Bàn', 1, NULL, N'9ad6a6c6-b93a-462c-bf42-4618ddc3860d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'dc50d1ac-1094-409b-9646-2a29570e540f', N'1201', N'TP Thái Nguyên', 1, NULL, N'a676a9f5-145d-4d5f-ac80-21e58935203c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e868d1e2-2da7-4cb7-9dd0-2ac4d08b31f4', N'5502', N'Q Bình Thuỷ', 1, NULL, N'a88db316-ed46-4f90-8996-165ac1b3b19d', 0, CAST(0x0000A38C017EE903 AS DateTime))
GO
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3b5cd6a5-0283-4272-a268-2aeb9036c280', N'4404', N'H Thuận An', 1, NULL, N'218bf6a8-128a-4282-b628-091a28c7ba72', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b54070c6-703c-4a6a-a208-2b6c399fd59f', N'2303', N'H Mai Châu', 1, NULL, N'89952828-32e3-4b69-9d02-f58dc73fe1b1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'652a5402-ba44-4225-b0b3-2bac70b6151e', N'3704', N'H Hoài Nhơn', 1, NULL, N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'288b96a4-38aa-49a6-81ee-2bada88a1bdf', N'1011', N'H Hữu Lũng', 1, NULL, N'5bad1676-5593-4b79-af80-cd9a1739bdb4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3f3af56d-b2f6-4b06-9842-2be72b9b2beb', N'1512', N'H Thanh Thuỷ', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e4c79405-9fa6-449b-ae68-2c0c6c3d3ec3', N'4906', N'H Đức Huệ', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'80e90882-6e24-40b5-a442-2c1419a489d0', N'0129', N'H Mê Linh', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2a5e416a-265a-4100-9c3b-2c39ae01f391', N'5110', N'H Châu Thành', 1, NULL, N'75452825-bf11-4d5a-baa2-ab4905a5349d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2a61c65f-5b51-49e1-be05-2c42902618b4', N'1107', N'H Chợ Mới', 1, NULL, N'5e798e9e-675e-4c85-b518-456c7915474d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'051ddaf1-a9ef-40a5-b19f-2c783b1fb0f9', N'1801', N'TX Bắc Giang', 1, NULL, N'912ceefc-bbf6-4f1c-8dbf-a35d1408e2ff', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'19b3e682-d23d-4aee-bd00-2cdd816dde07', N'3804', N'H KBang', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'569c8a30-8755-4666-9284-2e4f331dfdd8', N'3409', N'H Núi Thành', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'edc5a384-c6ac-4817-8c39-2e53457e092d', N'2606', N'H Kiến Xương', 1, NULL, N'd3b03a88-e912-409d-ba98-f46022c21d1c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a54a4d01-d6be-4daf-83dc-2e6fde36e3bb', N'0110', N'H Từ Liêm', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ca332ad2-e995-47ef-a5e1-2e84a91d0cba', N'1406', N'H Phù Yên', 1, NULL, N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6159045c-7ec3-426e-aec5-2edc6e9a0842', N'4808', N'H Long Thành', 1, NULL, N'21ea9975-e024-45eb-89d5-3d4b1d44e656', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'337fea45-f0b3-4adf-bfc8-2ee0d30e8eac', N'3708', N'H Tây Sơn', 1, NULL, N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6530492b-d92e-4f04-9be4-2f17d10d0dbb', N'3307', N'H Phú Lộc', 1, NULL, N'74f1f256-ad11-40d2-ad59-26c36c4ca939', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8065bdc2-0371-4ed3-94a8-2fcf391ab118', N'5302', N'TX Gò Công', 1, NULL, N'673308b5-dc96-4e1e-b578-3e5691a68f1e', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a64240d9-05f2-4206-87e6-30791cc5d35f', N'3513', N'H Sơn Tây', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f3c184a9-3176-4f96-9dbe-3085fe120b2d', N'0128', N'H Phú Xuyên', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c39349c4-3c80-4e56-beb5-311de40cacc7', N'3107', N'H Lệ Thủy', 1, NULL, N'ccfeec9e-e27f-4a60-b5d4-8a638b798a3b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5350db8c-30d8-4b3d-aed9-315bf5e67e88', N'2918', N'H Hưng Nguyên', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9a99941a-de9f-41f4-acc6-315f70848d61', N'5412', N'H Phú Quốc', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6e05e55e-ecb6-41fa-81f4-31647b00b1a5', N'0612', N'H Bảo Lâm', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0693dfd1-dfa5-49b8-9638-322988fb464c', N'1905', N'H Từ Sơn', 1, NULL, N'58a665e3-85d3-4dd0-b01d-f7a5ddcb2114', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6583e557-3b1d-48cf-a37f-322c42aab358', N'4011', N'H Krông Bông', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f6194eb1-8802-48ac-baa8-326a377ce9a7', N'4710', N'TX LaGi', 1, NULL, N'b5835ce9-45c2-4d0d-9b6b-3c74ec479bee', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'baf3a0dc-2601-48a8-ae46-32775addbd69', N'6109', N'H Tân Phú', 1, NULL, N'340f9b94-1df9-4ae5-9fee-61cd234ca532', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'68b7ef97-6742-4308-897f-3364a7e45224', N'3304', N'H Hương Trà', 1, NULL, N'74f1f256-ad11-40d2-ad59-26c36c4ca939', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2c1454ad-c518-4727-9ebb-3455d0d04008', N'2206', N'H Tiên Lữ', 1, NULL, N'13f07126-2fd4-4954-9f65-7c3409f8bd35', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'792dbb65-6686-4aad-8f52-34c7dc453075', N'1505', N'H Hạ Hòa', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'57a30a7d-224a-43a8-be83-3512f2a3cba8', N'0123', N'H Hoài Đức', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9bd8cc59-4f7a-4e23-b19c-3549415439e4', N'5902', N'H Kế Sách', 1, NULL, N'ceeb3bb7-3959-45a3-a6c7-657408731438', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5d26a270-ebd3-4abd-b02b-35a30e0b7d78', N'1602', N'H Tam Dương', 1, NULL, N'21fbf0a7-7939-4ff7-aee4-822e7869ddd2', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b37e17f3-ddbe-45fd-ad3a-35c4fd24f99c', N'2911', N'H Yên Thành', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'799602bc-9684-4b64-b443-35eea51487f0', N'3906', N'H Sông Hinh', 1, NULL, N'36d607e5-3d4a-41c6-85f1-f101a555c654', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1d89465e-7171-4264-8cae-362450942fa8', N'1104', N'H Na Rì', 1, NULL, N'5e798e9e-675e-4c85-b518-456c7915474d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c1fd6ded-f626-4855-86b5-3636358ed483', N'4903', N'H Mộc Hóa', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'44917f8b-075f-4df9-9670-36c3d2d88a03', N'2915', N'H Thanh Chương', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'aa38fb81-743f-49a9-baa1-370fa47cd4ec', N'1102', N'H Chợ Đồn', 1, NULL, N'5e798e9e-675e-4c85-b518-456c7915474d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'200377d2-6051-437c-84db-3748022390d3', N'3909', N'Huyện Tây Hoà', 1, NULL, N'36d607e5-3d4a-41c6-85f1-f101a555c654', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fea4cc55-bba0-4532-a324-3798eb467919', N'0706', N'H Than Uyên', 1, NULL, N'112c407c-448c-411d-a1c5-50d16d4980a1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f224c341-c820-4305-8bed-37c350bb6159', N'0502', N'H Đồng Văn', 1, NULL, N'54498638-d285-4aa1-b84b-972ebe00f78d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'bbcde8cc-df54-4745-bcd6-38831fa2013e', N'1703', N'TX Uông Bí', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2a00195b-1b41-435a-980b-390f91f16c83', N'3609', N'H Tu Mơ Rông', 1, NULL, N'03ccc7fc-d0be-4e51-9ab3-186515080313', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e904a30a-b564-4cba-8cdf-39100e104985', N'2811', N'H Lang Chánh', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fe32461d-5352-4ed6-b776-3a34180bc335', N'1106', N'H Ba Bể', 1, NULL, N'5e798e9e-675e-4c85-b518-456c7915474d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'45de6681-218b-49f2-aece-3a62b76056a3', N'0510', N'H Bắc Quang', 1, NULL, N'54498638-d285-4aa1-b84b-972ebe00f78d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd512cc88-4633-4d53-a18d-3a65f8eec603', N'6406', N'H Châu Thành A', 1, NULL, N'207a629f-6eed-4352-8eb5-d398d72cad67', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8c2bbf81-4e16-4199-9167-3b0b74200c7e', N'0108', N'Q Hoàng Mai', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fcf6555b-a8c2-4e53-9ba6-3b7dabd28a00', N'0605', N'H Trà Lĩnh', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c52f5f55-885e-47ef-9758-3bb316eabd24', N'5006', N'H Thanh Bình', 1, NULL, N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c09b47c8-25b6-40bb-ad15-3ca386068e88', N'2209', N'H Văn Lâm', 1, NULL, N'13f07126-2fd4-4954-9f65-7c3409f8bd35', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6d312343-5b3c-4a93-ba43-3cc835fef976', N'1908', N'H.Lương Tài', 1, NULL, N'58a665e3-85d3-4dd0-b01d-f7a5ddcb2114', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e8b113c7-f598-440f-9f25-3d07f80bff1c', N'0103', N'Q Hai Bà Trưng', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e21b70d7-814d-4214-a386-3de8ff0de864', N'3801', N'TP Pleiku', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'da871071-7330-46a3-9d98-3e0a0d45715b', N'4707', N'H Đức Linh', 1, NULL, N'b5835ce9-45c2-4d0d-9b6b-3c74ec479bee', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c7d634e9-8106-4edb-ac71-3f47c5f4e6d5', N'0302', N'Q Lê Chân', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'175a92b2-9ea8-4e0c-9065-3f8a29ccfaf4', N'3806', N'H Kông Chro', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6f8c1f0f-033d-432b-8607-3ffadbd52767', N'1105', N'H Ngân Sơn', 1, NULL, N'5e798e9e-675e-4c85-b518-456c7915474d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0c6ce11d-cb7b-4b61-b0fe-4054ae5366fa', N'1713', N'H Vân Đồn', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a0500189-b5be-4a6d-b3ad-407f7b3dbc8f', N'0313', N'H Cát Hải', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8dd7e79f-a161-448b-96a5-40e7a72c4e54', N'2607', N'H Tiền Hải', 1, NULL, N'd3b03a88-e912-409d-ba98-f46022c21d1c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b0e7969b-5286-4588-b8d0-4172e2598700', N'3301', N'TP Huế', 1, NULL, N'74f1f256-ad11-40d2-ad59-26c36c4ca939', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ff3cf22d-f885-4b58-9021-421171f34546', N'3102', N'H Tuyên Hóa', 1, NULL, N'ccfeec9e-e27f-4a60-b5d4-8a638b798a3b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c43ee506-a238-483f-a06c-4212a743f9e3', N'1304', N'H Yên Bình', 1, NULL, N'b5edd6e0-91bf-4294-ade4-33ad54c993bf', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'212c3bf8-9b3a-44c7-8999-42efdf3cf6f0', N'0118', N'H Phúc Thọ', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'cf677495-47ae-4f75-ae53-43da55196954', N'5309', N'H Tân Phước', 1, NULL, N'673308b5-dc96-4e1e-b578-3e5691a68f1e', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a8e3669b-84db-4093-b8ad-441469ba2b56', N'5411', N'H Vĩnh Thuận', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f3bbe48e-b95a-4940-9e4d-4447b6afcaa3', N'5606', N'H Bình Đại', 1, NULL, N'cfb493d0-47f9-4528-bdf1-b5b42d2a7440', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2c9a8796-94b4-45c6-b644-4542caf23d12', N'4102', N'H Vạn Ninh', 1, NULL, N'5dcda423-8bc0-405c-b111-7b4129ee9129', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5ad3fa95-2c0a-4a0b-9ff0-459097eac83b', N'6204', N'H Tuần Giáo', 1, NULL, N'f8147816-2225-43a6-8662-e3770fc549bd', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8148e412-78e9-4f89-b381-45d7849ca3b6', N'1803', N'H Lục Ngạn', 1, NULL, N'912ceefc-bbf6-4f1c-8dbf-a35d1408e2ff', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c0ee4f42-ecff-4d4b-b4ca-45dc56417783', N'2509', N'H Nghĩa Hưng', 1, NULL, N'34ab5555-3bee-40a5-a974-32c5b808f03b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4149ffda-fbca-4a94-936f-46af01e77ec6', N'5305', N'H Châu Thành', 1, NULL, N'673308b5-dc96-4e1e-b578-3e5691a68f1e', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7833815f-6bd9-4a8a-8eb0-4745cd219aa2', N'5103', N'H An Phú', 1, NULL, N'75452825-bf11-4d5a-baa2-ab4905a5349d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7ff78256-2874-43f3-bb51-47d93a408e82', N'4205', N'H Đơn Dương', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'460fb8bb-62ee-44b8-aefb-47efc93b9c51', N'4908', N'H Bến Lức', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'695fdf58-b520-4e27-af1a-48be312d9618', N'1405', N'H Bắc Yên', 1, NULL, N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'214c14e5-6163-4590-bbf3-48cbf9eb7aa1', N'2901', N'TP Vinh', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0600d7aa-c2f4-4282-9304-48d3a14e8915', N'4002', N'H Ea H leo', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5b0acc14-cca1-4cc7-b7e9-48f2cb340787', N'4502', N'H Ninh Sơn', 1, NULL, N'98da7653-c483-4540-8d8a-ba468b43cc8b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f79f2515-dc23-4f04-9321-494c68bc1cf2', N'0212', N'Quận 12', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd13b8efd-6d43-4b95-82cb-49b4c493c404', N'3603', N'H Ngọc Hồi', 1, NULL, N'03ccc7fc-d0be-4e51-9ab3-186515080313', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'14f1d92f-8036-42fe-bf77-49c7b9d01aa5', N'1809', N'H Việt Yên', 1, NULL, N'912ceefc-bbf6-4f1c-8dbf-a35d1408e2ff', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6cf2e6f3-83f6-4302-8e53-49d817e284fe', N'4304', N'H Bình Long', 1, NULL, N'648cd679-d07b-44c4-8ef6-ce4f45aaad4f', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'cb73f1a5-8371-46fb-8c30-49dae9319348', N'1510', N'H Lâm Thao', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0df0fbcd-53b7-4f04-a7d9-49f425a84d96', N'0303', N'Q Ngô Quyền', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'70b70dad-6e21-4257-853e-4a4424fea9e0', N'5108', N'H Châu Phú', 1, NULL, N'75452825-bf11-4d5a-baa2-ab4905a5349d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'47acb55a-fead-41ba-8935-4ab825e9183e', N'0122', N'H Đan Phượng', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd5a4202d-4397-403f-9069-4b320a76feee', N'5903', N'H Mỹ Tý', 1, NULL, N'ceeb3bb7-3959-45a3-a6c7-657408731438', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'43d4d435-4be4-429b-80c1-4bbb440130b1', N'6005', N'H Phước Long', 1, NULL, N'2c1152a3-d2f7-42c7-a4e7-85a4eb519e29', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'50021490-8dec-431b-9577-4bc1c45453e1', N'4012', N'H Lăk', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'dc2e7d2a-8eb5-4b9d-8e02-4c00229b5bf7', N'0312', N'H Vĩnh Bảo', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'129658d3-8292-45d0-824b-4cadb73242a0', N'1007', N'H Cao Lộc', 1, NULL, N'5bad1676-5593-4b79-af80-cd9a1739bdb4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1e7705bf-522d-44d4-95ac-4caed0835a93', N'6407', N'TX Tân Hiệp', 1, NULL, N'207a629f-6eed-4352-8eb5-d398d72cad67', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'86452e65-5864-4620-9b23-4cecbc650a25', N'2822', N'H Hoằng Hóa', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'298e7189-1898-42ff-9962-4cff1b8ab2c2', N'5410', N'H An Minh', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'93b6ddfe-b30a-4965-bcad-4d60cc132eac', N'3907', N'H Đông Hòa', 1, NULL, N'36d607e5-3d4a-41c6-85f1-f101a555c654', 0, CAST(0x0000A38C017EE903 AS DateTime))
GO
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'da0f6263-f9c0-4412-b8a4-4dcb476c4c91', N'5204', N'H Long Điền', 1, NULL, N'ba1ec8a8-bdbe-4b4b-8441-b8eb3b55b894', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'729e52c7-1d8c-4e0d-aee0-4ded896b42ce', N'6001', N'TX Bạc Liêu', 1, NULL, N'2c1152a3-d2f7-42c7-a4e7-85a4eb519e29', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6ddbc17b-75b9-4487-a659-4e262a1f9034', N'2102', N'H Chí Linh', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c8c769a0-7d48-4d5d-b84d-4ebac3cbc0cf', N'0202', N'Quận 2', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b2034a1e-3b40-4591-894f-4f5801f59761', N'5501', N'Q Ninh Kiều', 1, NULL, N'a88db316-ed46-4f90-8996-165ac1b3b19d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4d4db8e6-11c1-491c-ba12-4f9e3a2c76d1', N'5504', N'H ô Môn', 1, NULL, N'a88db316-ed46-4f90-8996-165ac1b3b19d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6799ea9c-5f8a-4af9-83ac-4fc2549e38d7', N'5310', N'H Tân Phú Đông', 1, NULL, N'673308b5-dc96-4e1e-b578-3e5691a68f1e', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3407c0fb-845b-4591-8674-500f77765cf5', N'3204', N'H Gio Linh', 1, NULL, N'8c8f0507-588c-4c51-843f-41dec2f2d0e7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'597fe1ae-87fb-401c-9787-504cd96a307f', N'0308', N'H Kiến Thụy', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'be2879fc-93f5-4805-96cb-504f8ddb6042', N'4913', N'H Cần Giuộc', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'98e3c5cc-949b-4751-b3ac-5059d763731f', N'0102', N'Q Hoàn Kiếm', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6ffaaf6c-ae64-43e6-9d03-50fae35ea5c5', N'3413', N'H Nam Giang', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9faf2185-37c6-46c3-a05f-5185c5200858', N'1702', N'TX Cẩm Phả', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4b8f539d-d1ab-4514-b43e-51e699ef3660', N'5102', N'TX Châu Đốc', 1, NULL, N'75452825-bf11-4d5a-baa2-ab4905a5349d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5d7bd8d6-ab94-46e2-ae25-52caff439934', N'1407', N'H Mai Sơn', 1, NULL, N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'16de3c52-66d5-4ec5-87d0-538ea984d4e5', N'0506', N'H Vị Xuyên', 1, NULL, N'54498638-d285-4aa1-b84b-972ebe00f78d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'823513f2-c803-4ae2-b754-5399fcf5be4a', N'2505', N'H ý Yên', 1, NULL, N'34ab5555-3bee-40a5-a974-32c5b808f03b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8c36c6d3-4f4f-4b59-aeae-5450fe0e3835', N'5909', N'H Ngã Năm', 1, NULL, N'ceeb3bb7-3959-45a3-a6c7-657408731438', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2f0f2880-87a9-4a21-b27c-54c34e8250ea', N'2108', N'H Ninh Giang', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'dd7a9deb-bdba-4bba-a557-551676a92171', N'2202', N'H Kim Động', 1, NULL, N'13f07126-2fd4-4954-9f65-7c3409f8bd35', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b433d91d-da8f-48ae-aa46-5570e58f96b8', N'5304', N'H Cai Lậy', 1, NULL, N'673308b5-dc96-4e1e-b578-3e5691a68f1e', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'373794d9-269d-4868-a2eb-557b97b53648', N'2701', N'TX Ninh Bình', 1, NULL, N'56ee4087-9b4b-41c8-965f-da43f3fedc21', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3d35b001-4c61-480a-8bbe-55a0f6efbe0a', N'1708', N'H Tiên Yên', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'44c2b77f-61e5-4165-895a-55ec025d1d95', N'1609', N'H Tam Đảo', 1, NULL, N'21fbf0a7-7939-4ff7-aee4-822e7869ddd2', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7b430a32-47a4-43b2-b6c0-561d6329b16d', N'2106', N'H Tứ Kỳ', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'52f1fa87-b1ea-4a56-9490-5632b03b870b', N'5507', N'H Vĩnh Thanh', 1, NULL, N'a88db316-ed46-4f90-8996-165ac1b3b19d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a5c27020-4d66-4953-8904-564505257748', N'4605', N'H Châu Thành', 1, NULL, N'66c4231e-f04c-4687-954f-300eb34991c4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e4024e20-fe39-426d-976b-565e227907af', N'1004', N'H Văn Lãng', 1, NULL, N'5bad1676-5593-4b79-af80-cd9a1739bdb4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5c1975bf-108d-423a-8671-56ff622e17f9', N'4003', N'H Krông Buk', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'558a175c-aec7-4748-88c2-57049e5cf030', N'5405', N'H Tân Hiệp', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'78ebf522-dd58-4563-b154-57476f1c2ea0', N'4805', N'H Thống Nhất', 1, NULL, N'21ea9975-e024-45eb-89d5-3d4b1d44e656', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5f22f716-c417-43e9-85c9-5784b132a548', N'0803', N'H Bát Xát', 1, NULL, N'9ad6a6c6-b93a-462c-bf42-4618ddc3860d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2ef9ab1d-ccab-4f53-8382-57872a136241', N'0315', N'Q Dương Kinh', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'767de12c-e0c2-4432-87a8-57fc468c0091', N'4104', N'H Diên Khánh', 1, NULL, N'5dcda423-8bc0-405c-b111-7b4129ee9129', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'23b09ce6-428a-46e2-9973-580927dc9830', N'0705', N'H Mường Tè', 1, NULL, N'112c407c-448c-411d-a1c5-50d16d4980a1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0e2a7810-0107-442e-9b87-585ef618e368', N'1805', N'H Lục Nam', 1, NULL, N'912ceefc-bbf6-4f1c-8dbf-a35d1408e2ff', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8745fe6b-604d-4115-b878-5911396eed7b', N'1003', N'H Bình Gia', 1, NULL, N'5bad1676-5593-4b79-af80-cd9a1739bdb4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6ceecf13-be3b-464a-9021-596f8d43fcab', N'49081', N'H Bến Lức', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0a5613a4-98b2-40ae-992a-59b9846f5c04', N'2601', N'TP Thái Bình', 1, NULL, N'd3b03a88-e912-409d-ba98-f46022c21d1c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0cb9a21f-de78-4b37-9159-59c06a65eef3', N'0117', N'H Ba Vì', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'85de3d5a-7075-463b-b27a-59ef1d9a6d5f', N'2827', N'H Yên Định', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6a36ec57-30fd-4e1e-9cbe-5a31a79843ea', N'0204', N'Quận 4', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'cc2f1733-330e-4f9f-b0e9-5acd03148bc1', N'2820', N'H Đông Sơn', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fcf6bfdd-675f-4c53-823b-5ae2260b8bb1', N'4106', N'H Cam Ranh', 1, NULL, N'5dcda423-8bc0-405c-b111-7b4129ee9129', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'37b320ce-ce23-4a76-a8a6-5b450974e201', N'2705', N'H Hoa Lư', 1, NULL, N'56ee4087-9b4b-41c8-965f-da43f3fedc21', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'aac1f41a-619b-49bb-a108-5b524730215e', N'4015', N'TX Buôn Hồ', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'81f9e98c-027a-419e-9a0c-5b5631eade1c', N'0602', N'H Bảo Lạc', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a8e949b0-47ed-4dc5-a088-5b572c787942', N'4803', N'H Tân Phú', 1, NULL, N'21ea9975-e024-45eb-89d5-3d4b1d44e656', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e0513d28-1988-4d00-b0ce-5b86940e5b5b', N'1808', N'H Lạng Giang', 1, NULL, N'912ceefc-bbf6-4f1c-8dbf-a35d1408e2ff', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a9ee3634-950e-46ba-8c51-5bddb0e9e6db', N'4701', N'TP Phan Thiết', 1, NULL, N'b5835ce9-45c2-4d0d-9b6b-3c74ec479bee', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a32c00b7-abd1-4d11-929e-5bf0e1339136', N'4905', N'H Thạnh Hóa', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c215fcd8-a8b8-46f9-9a84-5bf854b94684', N'0209', N'Quận 9', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8fd90345-a274-4336-ac6a-5c205f7cc0e2', N'0211', N'Quận 11', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6ce32ac0-ff52-4239-bcad-5c21f3cca64a', N'5603', N'H Chợ Lách', 1, NULL, N'cfb493d0-47f9-4528-bdf1-b5b42d2a7440', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6f5d5dcd-e50f-4983-803d-5c6bb0c6f842', N'4708', N'H Tánh Linh', 1, NULL, N'b5835ce9-45c2-4d0d-9b6b-3c74ec479bee', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a2934b24-06ff-4458-98a8-5c75f2d17422', N'1604', N'H Vĩnh Tường', 1, NULL, N'21fbf0a7-7939-4ff7-aee4-822e7869ddd2', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f5cc328e-3a88-4293-be00-5cee8349115c', N'5011', N'H Châu Thành', 1, NULL, N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'bc61e7fd-b1b7-4788-8afd-5d1420cfd51c', N'4709', N'H Phú Quý', 1, NULL, N'b5835ce9-45c2-4d0d-9b6b-3c74ec479bee', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd9009028-4832-44fd-9a23-5d58ba245db3', N'0805', N'H Sa Pa', 1, NULL, N'9ad6a6c6-b93a-462c-bf42-4618ddc3860d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b477c9ca-55fa-432c-94aa-5d7e849ba37c', N'0703', N'H Phong Thổ', 1, NULL, N'112c407c-448c-411d-a1c5-50d16d4980a1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'41ee7a6e-66d5-4faa-acd4-5de991457ff4', N'2405', N'H Thanh Liêm', 1, NULL, N'791c45b8-1d33-4728-b08b-83b4027c8cb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f52cacfa-fe57-4c18-b34b-5ded6153ec51', N'0120', N'H Quốc Oai', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'618a8598-9c43-41fd-8254-5e478847bee3', N'6104', N'H Trần Văn Thời', 1, NULL, N'340f9b94-1df9-4ae5-9fee-61cd234ca532', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ead20620-ce92-4f78-b8ef-5f0850764d3a', N'4507', N'H. Thuận Nam', 1, NULL, N'98da7653-c483-4540-8d8a-ba468b43cc8b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'93dd6f0a-503b-4d5a-85c8-5fa977938131', N'3706', N'H Phù Cát', 1, NULL, N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'149144fe-9164-4a64-a64c-60176014580c', N'6203', N'H Điện Biên', 1, NULL, N'f8147816-2225-43a6-8662-e3770fc549bd', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd2585b67-d49a-4f27-8b84-606293fc2b0b', N'0125', N'H Mỹ Đức', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9bea3f41-e22d-4f7d-8577-611ab252ab3e', N'5505', N'H Phong Điền', 1, NULL, N'a88db316-ed46-4f90-8996-165ac1b3b19d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'35d98515-e6b9-49c4-a920-618cddc5e669', N'4310', N'H Bù Gia Mập', 1, NULL, N'648cd679-d07b-44c4-8ef6-ce4f45aaad4f', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c3c21402-a1f3-4fb2-8fe4-620de917d9e9', N'0604', N'H Hà Quảng', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'45556a49-8bf3-42d8-9039-6254ea5717d5', N'5105', N'H Phú Tân', 1, NULL, N'75452825-bf11-4d5a-baa2-ab4905a5349d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a4c19d72-a1e1-43bd-8a70-629068ff4ca9', N'1904', N'H Tiên Du', 1, NULL, N'58a665e3-85d3-4dd0-b01d-f7a5ddcb2114', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f1255aeb-1af3-45cc-bd62-62c573ce4104', N'2813', N'H Thạch Thành', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7e6d33f7-0ef8-4436-90a1-62ec50531199', N'1409', N'H Sông Mã', 1, NULL, N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd60c476d-5d8f-4382-a274-63182663b38f', N'3813', N'H Đăk Đoa', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'dc1631d9-466d-4edf-a0fd-638b2e892371', N'2812', N'H Ngọc Lặc', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'60a1b969-1871-4799-8ff4-63c49809402d', N'2308', N'H Kim Bôi', 1, NULL, N'89952828-32e3-4b69-9d02-f58dc73fe1b1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e89d4f52-5e3f-4701-adc7-63e6b3e1ef91', N'1010', N'H Đình Lập', 1, NULL, N'5bad1676-5593-4b79-af80-cd9a1739bdb4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3efc3c1e-2336-4fae-a30a-643e907bd390', N'1705', N'H Bình Liêu', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e18fa7a0-5172-4d93-8f8b-644fb4a3fd6e', N'3308', N'H Nam Đông', 1, NULL, N'74f1f256-ad11-40d2-ad59-26c36c4ca939', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6e67c8dc-e33a-4d60-a01d-6483998f9273', N'2103', N'H Nam Sách', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a607625b-7c8f-4369-89e8-649501daca06', N'3811', N'H Krông Pa', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'676f9568-9e51-4c5d-b2e2-64aa70b62b1d', N'3303', N'H Quảng Điền', 1, NULL, N'74f1f256-ad11-40d2-ad59-26c36c4ca939', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'56d7e105-9798-43aa-8024-64c1669e23d2', N'2826', N'H Tĩnh Gia', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'592f3c50-72c2-4ac3-a6c4-64f3120e53d3', N'1301', N'TX Yên Bái', 1, NULL, N'b5edd6e0-91bf-4294-ade4-33ad54c993bf', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fcbdebb8-d0cd-40d8-8aab-64fb0513d844', N'6006', N'H Đông Hải', 1, NULL, N'2c1152a3-d2f7-42c7-a4e7-85a4eb519e29', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b3155a46-dfa4-4d80-9b35-658262f1faac', N'4203', N'H Đức Trọng', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f7a2f536-b935-406b-9d6f-65f3168bd444', N'3707', N'H Vĩnh Thạnh', 1, NULL, N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'eadd794d-826c-4c01-b5b5-6615913f8274', N'1607', N'H Mê Linh', 1, NULL, N'21fbf0a7-7939-4ff7-aee4-822e7869ddd2', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'105dbe7a-d192-440e-86da-669ed7cf2697', N'2919', N'H Quế Phong', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'189126aa-b1f2-48f9-bc15-675e60c0ab71', N'1502', N'TX Phú Thọ', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a75ed5a1-9495-49bf-960c-6838b82a093f', N'1008', N'H Lộc Bình', 1, NULL, N'5bad1676-5593-4b79-af80-cd9a1739bdb4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5d014ba2-0d6c-40b8-b66d-6880939f91f3', N'1509', N'H Phù Ninh', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b9b2300e-9d6d-4dae-a363-69165b10583d', N'1707', N'H Hải Hà', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2f0b52eb-cb45-421d-8638-6a30579aaa99', N'3908', N'H Phú Hòa', 1, NULL, N'36d607e5-3d4a-41c6-85f1-f101a555c654', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'aa995e2a-b3c3-42a2-91fa-6a4fbfcb590b', N'3004', N'H Đức Thọ', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e00a46c5-fd40-49f1-9c59-6aa0a0a4b4a1', N'2403', N'H Kim Bảng', 1, NULL, N'791c45b8-1d33-4728-b08b-83b4027c8cb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8d6f8224-b77a-4bbc-b638-6acb13ee147b', N'1804', N'H Sơn Động', 1, NULL, N'912ceefc-bbf6-4f1c-8dbf-a35d1408e2ff', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'af8d9721-3ea2-49c3-8c7b-6b15bc43b3ed', N'0207', N'Quận 7', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9eeb579b-d968-49ee-8b0d-6b6c650df8dc', N'0105', N'Q Tây Hồ', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
GO
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8897f3d4-a80c-42e3-a1af-6bf2c5cb826d', N'2204', N'H Khoái Châu', 1, NULL, N'13f07126-2fd4-4954-9f65-7c3409f8bd35', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'69a7eb3b-0b19-44e0-a645-6c02ffac31cb', N'3408', N'H Thăng Bình', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b2281af0-fd04-444f-adc6-6c476b83efef', N'3809', N'H Chư Sê', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0f05b0bc-2afc-42b9-9dc7-6c8c080ace32', N'2608', N'H Thái Thụy', 1, NULL, N'd3b03a88-e912-409d-ba98-f46022c21d1c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b41cd7e8-ac1f-4256-a4e5-6cdbe81a25fd', N'4705', N'H Hàm Thuận Nam', 1, NULL, N'b5835ce9-45c2-4d0d-9b6b-3c74ec479bee', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fed20259-a2cf-4c38-adbd-6d71368cba23', N'0124', N'H Thanh Oai', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f7710735-b747-44e5-a7bd-6d94566d2d5e', N'6402', N'H Vị Thuỷ', 1, NULL, N'207a629f-6eed-4352-8eb5-d398d72cad67', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'faf9bbfc-7093-489a-9851-6df244309344', N'5109', N'H Chợ Mới', 1, NULL, N'75452825-bf11-4d5a-baa2-ab4905a5349d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fd4dde66-d616-410f-8d1d-6e9b75d9aa84', N'2311', N'H Cao Phong', 1, NULL, N'89952828-32e3-4b69-9d02-f58dc73fe1b1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'767a514c-e76b-4506-bded-6ecfacc9bd67', N'2909', N'H Con Cuông', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'97972bbd-c3ff-4297-9a36-6f7c123eb31d', N'1208', N'H Phú Bình', 1, NULL, N'a676a9f5-145d-4d5f-ac80-21e58935203c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ac1b64c5-2fdb-4d86-8ab9-6fcf960a824b', N'3810', N'H Ayunpa', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8c9be14d-9560-4e9b-a80f-705b70a5f129', N'0611', N'H Hạ Lang', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c06512c6-d35e-4ed2-b03e-70844c7fd6e5', N'5703', N'H Măng Thít', 1, NULL, N'35d84f30-2ee0-4fb6-b408-4a438b472abc', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'08bb24b0-91e2-4645-aa5d-70ad2c622579', N'4211', N'H Bảo Lâm', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1cc4d8ab-f42d-44c9-aaba-712ae216d75d', N'4506', N'H Tuy Phong', 1, NULL, N'98da7653-c483-4540-8d8a-ba468b43cc8b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a70a1c3b-6f67-4244-9b15-71706acacf34', N'2111', N'H Kim Thành', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ce6615a1-841a-4a1c-a1bd-71732469fc33', N'6307', N'H Đăk Gloong', 1, NULL, N'05e01cd8-6539-4dfe-9505-64d332006bb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'325902a5-077b-4828-a35e-71e4cfc6798e', N'6108', N'H Năm Căn', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ed07d916-645c-4060-99e4-725ae03a7470', N'5010', N'H Lai Vung', 1, NULL, N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'71b747f6-7b2a-4d4c-a23d-72be69b268d7', N'2910', N'H Tân Kỳ', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c45335c8-ddd2-49c6-b2d3-72cc9d9fc4e7', N'3602', N'H Đăk Glei', 1, NULL, N'03ccc7fc-d0be-4e51-9ab3-186515080313', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e2641bda-b392-4b88-9899-73346d7e9475', N'0114', N'H Sóc Sơn', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd5ea8a87-f0ef-4e9f-b597-73694254452f', N'0508', N'H Hoàng Su Phì', 1, NULL, N'54498638-d285-4aa1-b84b-972ebe00f78d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'32301423-ba5e-4ebf-bf62-738c8628f5a8', N'0222', N'H Hóc Môn', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'77ee8679-231d-49f8-a6a5-73ea3a89c6f4', N'0214', N'Q Tân Bình', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c4b75765-a06c-4c7c-982d-73f75d4fa2c6', N'4402', N'H Bến Cát', 1, NULL, N'218bf6a8-128a-4282-b628-091a28c7ba72', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'93c65e5f-cc55-48b5-a26e-741c11fdaaa3', N'2307', N'H Lương Sơn', 1, NULL, N'89952828-32e3-4b69-9d02-f58dc73fe1b1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6fa336f9-ce0a-4d96-93cf-7435c03eb618', N'5805', N'H Châu Thành', 1, NULL, N'72a67ef4-0a80-4bc3-a047-435f64b76a53', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'35ededa2-e5f4-4b19-8d54-7486cb116c2c', N'1710', N'H Đông Triều', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'13aa9e59-a143-44a3-9a52-74f1d4f5addf', N'2112', N'H Bình Giang', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'53bc58d0-a4ab-4118-ba16-756ac30e581d', N'0905', N'H Yên Sơn', 1, NULL, N'53a568c0-2ae3-461e-9588-e9b8f821a01c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c546ddf1-997a-452c-b9ba-7633982400ac', N'2104', N'H Kinh Môn', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3bac5304-ac2f-4409-8f82-76eb1c963a2f', N'3415', N'H Nam Trà My', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a41cd526-bd52-44a1-ba4f-771bf9b5302d', N'3305', N'H Phú Vang', 1, NULL, N'74f1f256-ad11-40d2-ad59-26c36c4ca939', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9b46d91b-94af-452f-ab95-77dec10b54dc', N'3703', N'H Hoài ân', 1, NULL, N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5f34a81c-ecb5-49d4-86db-784f36e88619', N'6405', N'H Châu Thành', 1, NULL, N'207a629f-6eed-4352-8eb5-d398d72cad67', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'54538d1e-1862-4a0d-9d27-786ef54eb3ba', N'6305', N'H.Đăk Song', 1, NULL, N'05e01cd8-6539-4dfe-9505-64d332006bb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'37dc9452-7a8d-4ead-9282-78b68f227679', N'0901', N'TX Tuyên Quang', 1, NULL, N'53a568c0-2ae3-461e-9588-e9b8f821a01c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f2d6cb2e-afac-408f-a555-78e0bbad2207', N'3008', N'H Thạch Hà', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3f404dd4-e3cf-4a1e-ba19-78e96bb2856f', N'2916', N'H Nghi Lộc', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'948c0194-72ba-4f16-8a30-78edb1ef931f', N'0701', N'TX Lai Châu', 1, NULL, N'112c407c-448c-411d-a1c5-50d16d4980a1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ff6ad8e9-5272-49a1-a27a-79401443dd67', N'1903', N'H Quế Võ', 1, NULL, N'58a665e3-85d3-4dd0-b01d-f7a5ddcb2114', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'bba46321-b6e3-4409-bfa8-79bae27ef985', N'0511', N'H Quang Bình', 1, NULL, N'54498638-d285-4aa1-b84b-972ebe00f78d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'af5d6ccf-e519-4c8e-bdc6-79efe51aea33', N'2902', N'TX Cửa Lò', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f8eb11cb-b8f3-4398-a9ee-79fcd75559db', N'5404', N'H Hòn Đất', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'24e3a8fc-fe28-4fce-95ab-7a1b48f2bed7', N'0216', N'Q Bình Thạnh', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7de7f520-67ce-4f3c-9ae4-7a1b8cb8f5f7', N'3711', N'H Tuy Phước', 1, NULL, N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'380f9a54-b1eb-4386-aac7-7a97c4c8e261', N'5104', N'H Tân Châu', 1, NULL, N'75452825-bf11-4d5a-baa2-ab4905a5349d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'64c3f9e0-4ba8-41ba-b611-7c24e7632fff', N'2605', N'H Vũ Thư', 1, NULL, N'd3b03a88-e912-409d-ba98-f46022c21d1c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'378336cf-1d10-46b2-ba2a-7c50e54cb8b2', N'3205', N'H Cam Lộ', 1, NULL, N'8c8f0507-588c-4c51-843f-41dec2f2d0e7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'12d46852-ca9c-4e07-8f28-7d33b8e099c1', N'4809', N'H Nhơn Trạch', 1, NULL, N'21ea9975-e024-45eb-89d5-3d4b1d44e656', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'41aeafb6-14f9-4574-9ea6-7dacad27042b', N'1411', N'H Sốp Cộp', 1, NULL, N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9311240a-1f84-488a-8612-7dbbcc8de951', N'5202', N'TX Bà Rịa', 1, NULL, N'ba1ec8a8-bdbe-4b4b-8441-b8eb3b55b894', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c48f0a0b-5b1f-48e8-a2de-7e130baf2d7c', N'3805', N'TX An Khê', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'90ddc780-e978-4a25-8cc1-7e5012e9e773', N'0406', N'H Cẩm Lệ', 1, NULL, N'c29aa669-3b60-4950-bdde-2ba6a00c2507', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'cf04d8de-7d8c-4a69-8f5e-7e55627a75b7', N'4303', N'H Châu Thành', 1, NULL, N'648cd679-d07b-44c4-8ef6-ce4f45aaad4f', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'709a7dbb-619f-4807-a7f7-7e7d6a54ec80', N'6106', N'H Đầm Dơi', 1, NULL, N'340f9b94-1df9-4ae5-9fee-61cd234ca532', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c9163d52-871e-4fef-ad24-7e86b945338b', N'6304', N'H Cư Jút', 1, NULL, N'05e01cd8-6539-4dfe-9505-64d332006bb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'827f3e2b-6ab4-4bf5-a0eb-7eac4bb0d6e3', N'5206', N'H Tân Thành', 1, NULL, N'ba1ec8a8-bdbe-4b4b-8441-b8eb3b55b894', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'596dfc9d-4df9-4cc4-a1c6-7fc1f4581e15', N'3705', N'H Phù Mỹ', 1, NULL, N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f2b0d43b-f65e-47f2-83c6-800aea2d2a6c', N'4606', N'H Hoà Thành', 1, NULL, N'66c4231e-f04c-4687-954f-300eb34991c4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'041159ab-86e9-4840-80e3-8105bcecfb79', N'0314', N'H Bạch Long Vĩ', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'58554b64-5396-4787-9d6a-810afdaae84d', N'4910', N'H Châu Thành', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'940c5681-0fd6-42ee-8f5f-812c0d8841f0', N'1806', N'H Tân Yên', 1, NULL, N'912ceefc-bbf6-4f1c-8dbf-a35d1408e2ff', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'eb88f09c-1e8b-42b5-a9db-818fde916124', N'4105', N'H Khánh Vĩnh', 1, NULL, N'5dcda423-8bc0-405c-b111-7b4129ee9129', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e2e41a68-2623-46f4-b69c-81c6d7d870e2', N'2803', N'TX Sầm Sơn', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd10204f5-e85e-495c-807b-823e2e8003d7', N'3802', N'H Chư Păh', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ba10e9c3-ef33-4c9c-a793-82f01a562407', N'1402', N'H Quỳnh Nhai', 1, NULL, N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c1d53b25-65c8-4a74-a2b9-831044c32ab4', N'3306', N'H Hương Thủy', 1, NULL, N'74f1f256-ad11-40d2-ad59-26c36c4ca939', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd4365e33-1270-4116-a28a-837a38cc359a', N'4912', N'H Cần Đước', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a1b582d9-9dc2-4de2-952b-84e1ab9ac4a3', N'0608', N'H Hoà An', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2530a8e5-0d83-465d-bbd9-85e64bd35122', N'2309', N'H Lạc Thủy', 1, NULL, N'89952828-32e3-4b69-9d02-f58dc73fe1b1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0d5ce294-8c82-4987-86f2-86afb428f10b', N'5208', N'H Đất Đỏ', 1, NULL, N'ba1ec8a8-bdbe-4b4b-8441-b8eb3b55b894', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'76274d3e-a46f-4b4e-810f-86dfc47c729f', N'3807', N'H Đức Cơ', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'55e0bcf0-86fc-4cbe-932e-8731a6e98eb1', N'3416', N'H Tây Giang', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'cbb1e842-7360-42e3-9769-878bd503355c', N'5201', N'TP Vũng Tàu', 1, NULL, N'ba1ec8a8-bdbe-4b4b-8441-b8eb3b55b894', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f4cedc2a-1783-4975-a9a9-885a24ed87b5', N'3002', N'TX Hồng Lĩnh', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'46e77fcc-012d-4c3b-887c-88d3697c3f93', N'4107', N'H Khánh Sơn', 1, NULL, N'5dcda423-8bc0-405c-b111-7b4129ee9129', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'dc477340-bb97-441e-aa26-8913d48dff56', N'1305', N'H Mù Cang Chải', 1, NULL, N'b5edd6e0-91bf-4294-ade4-33ad54c993bf', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3013f1e4-0179-400a-a202-891f428d564a', N'6007', N'H. Hòa Bình', 1, NULL, N'2c1152a3-d2f7-42c7-a4e7-85a4eb519e29', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b9eebe0f-d24d-4024-a28b-89429ec6d96f', N'5907', N'H Vĩnh Châu', 1, NULL, N'ceeb3bb7-3959-45a3-a6c7-657408731438', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4c134eec-394d-46cd-9007-895c1fea2290', N'0906', N'H Sơn Dương', 1, NULL, N'53a568c0-2ae3-461e-9588-e9b8f821a01c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'118b5609-fa76-4303-9310-8961f57dc0a3', N'5408', N'H Gò Quao', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'abd4b561-9c6f-4f8c-81de-89f2da1df2aa', N'2815', N'H Thọ Xuân', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'53867fc3-f4b0-4797-8e96-8b4a0edb72b2', N'0801', N'TX Lào Cai', 1, NULL, N'9ad6a6c6-b93a-462c-bf42-4618ddc3860d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'88da18e9-d84a-4552-9db5-8bd1ab31ab7a', N'4305', N'H Lộc Ninh', 1, NULL, N'648cd679-d07b-44c4-8ef6-ce4f45aaad4f', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'30d33bb6-37e1-4904-ae38-8bdfc264e8ec', N'3901', N'TX Tuy Hòa', 1, NULL, N'36d607e5-3d4a-41c6-85f1-f101a555c654', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'cafcf20e-a4ea-45f7-8241-8c02c3f9888f', N'4505', N'H Bác ái', 1, NULL, N'98da7653-c483-4540-8d8a-ba468b43cc8b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c2ce083a-3817-4a16-a12a-8d3451eab54f', N'2203', N'H ân Thi', 1, NULL, N'13f07126-2fd4-4954-9f65-7c3409f8bd35', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f27b6558-d2c4-47a9-903e-8dc275f7d838', N'0224', N'H Cần Giờ', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1ad9e178-7f52-430c-9974-8dde727006a0', N'3302', N'H Phong Điền', 1, NULL, N'74f1f256-ad11-40d2-ad59-26c36c4ca939', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7812b6fb-54a3-49c9-afb2-8e1aa0cae784', N'2510', N'H Hải Hậu', 1, NULL, N'34ab5555-3bee-40a5-a974-32c5b808f03b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fc3541b0-0228-4894-be00-8e5d2ad66fba', N'3701', N'TP Qui Nhơn', 1, NULL, N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0d031663-b484-47d7-9349-8f4b22a0436a', N'5508', N'H Thốt Nốt', 1, NULL, N'a88db316-ed46-4f90-8996-165ac1b3b19d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'68c5bad4-1127-48a3-ad31-8f53e90653d3', N'1302', N'TX Nghĩa Lộ', 1, NULL, N'b5edd6e0-91bf-4294-ade4-33ad54c993bf', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'37121889-6072-477c-89b5-8f892bb1065d', N'4210', N'H Lâm Hà', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a1aa709b-5d74-4304-8394-8f8ec5f861dd', N'0221', N'H Củ Chi', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1cfbf358-fcf8-417b-b010-8fb0f293a8c0', N'0306', N'TX Đồ Sơn', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f91ac90c-afbe-4d04-b6b7-8fd005ab7b49', N'0603', N'H Thông Nông', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
GO
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'376ff2a8-8d24-44ac-aaf5-9046868505a8', N'5005', N'H Tam Nông', 1, NULL, N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7c51de01-696a-4c29-810c-905295d1bff1', N'0610', N'H Thạch An', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5d503a93-29dc-4134-89bf-906386a28226', N'2604', N'H Đông Hưng', 1, NULL, N'd3b03a88-e912-409d-ba98-f46022c21d1c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'dfac0c98-b13e-4c20-bef1-909dd033e72b', N'3902', N'H Đồng Xuân', 1, NULL, N'36d607e5-3d4a-41c6-85f1-f101a555c654', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'711877e4-49a7-4a3a-9c65-90cdac997c54', N'1001', N'TP. Lạng Sơn', 1, NULL, N'5bad1676-5593-4b79-af80-cd9a1739bdb4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'837153bf-1eb4-40ad-b7e8-9132f397a92c', N'0304', N'Q Kiến An', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fbe2a229-cb44-4022-ab3b-91d53ad568f2', N'2913', N'H Anh Sơn', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b12d2434-5df4-424b-8cf5-920996eea264', N'1408', N'H Yên Châu', 1, NULL, N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3ab87fe1-35a8-4e1b-984e-930bcb817dab', N'4914', N'H Tân Hưng', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0fdfb4ad-3af9-4a6b-83e9-947855c12258', N'1206', N'H Đại Từ', 1, NULL, N'a676a9f5-145d-4d5f-ac80-21e58935203c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4ffe1758-1be3-4933-9650-94b3f1a006dd', N'3506', N'H Sơn Hà', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'bc13a709-f7f8-4536-9652-951be2e5b81c', N'4901', N'TX Tân An', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5ca33cc8-3741-461a-a344-953b8b931649', N'0403', N'Q Sơn Trà', 1, NULL, N'c29aa669-3b60-4950-bdde-2ba6a00c2507', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9d13dc0c-2d1f-4a9c-9867-9552312720aa', N'6102', N'H Thới Bình', 1, NULL, N'05e01cd8-6539-4dfe-9505-64d332006bb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0145d591-0ed3-43a8-bcd6-9703acf7d3b4', N'5701', N'TX Vĩnh Long', 1, NULL, N'35d84f30-2ee0-4fb6-b408-4a438b472abc', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7c19d725-9231-41db-90b4-97298bf26ef4', N'1507', N'H Yên Lập', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6e116dc0-2555-4a92-bb6d-976ba03c2ba7', N'5101', N'TP Long Xuyên', 1, NULL, N'75452825-bf11-4d5a-baa2-ab4905a5349d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd5c12137-9d68-4acd-8cd9-9806c053c35b', N'3509', N'H Minh Long', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'feed817b-0d44-4e5a-bd45-982ba7cecc54', N'6301', N'TX Gia Nghĩa', 1, NULL, N'05e01cd8-6539-4dfe-9505-64d332006bb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9318475c-c761-43ea-8fab-989bff1dba92', N'0904', N'H Hàm yên', 1, NULL, N'53a568c0-2ae3-461e-9588-e9b8f821a01c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5ead6a7f-8ee2-4698-85f8-98ab529e8086', N'2603', N'H Hưng Hà', 1, NULL, N'd3b03a88-e912-409d-ba98-f46022c21d1c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a2e4b95d-dc8b-472b-8a29-98c632b4e83a', N'3201', N'TX Đông Hà', 1, NULL, N'8c8f0507-588c-4c51-843f-41dec2f2d0e7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b60c745c-354e-4aa0-bb48-98fe1d2e7894', N'1902', N'H Yên Phong', 1, NULL, N'58a665e3-85d3-4dd0-b01d-f7a5ddcb2114', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e1d8628f-184d-459b-9022-991f8d69d09c', N'0405', N'Q Liên Chiểu', 1, NULL, N'c29aa669-3b60-4950-bdde-2ba6a00c2507', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c90a6289-b9a9-4d9b-8f26-99463b89c4b6', N'5503', N'Q Cái Răng', 1, NULL, N'a88db316-ed46-4f90-8996-165ac1b3b19d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'242f9df7-fe89-4dde-bb07-999807d39f4a', N'0115', N'Q. Hà Đông', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4a4fca48-52a2-4f5b-9d0e-9a20fe5a1b4e', N'3006', N'H Can Lộc', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0e688497-f08a-40b6-b35b-9a27b975cc43', N'2809', N'H Như Xuân', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3cb0961b-d62f-44e8-a708-9a2ab335c82d', N'3503', N'H Bình Sơn', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7979e258-01cb-4ac9-a06a-9aa9ba7af4ca', N'4204', N'H Di Linh', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'dcd8ce30-b090-470e-9d0c-9aacd92b682d', N'4801', N'TP Biên Hòa', 1, NULL, N'21ea9975-e024-45eb-89d5-3d4b1d44e656', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4c7ada6d-3932-4147-b4a4-9ad348ba244a', N'4704', N'H Hàm Thuận Bắc', 1, NULL, N'b5835ce9-45c2-4d0d-9b6b-3c74ec479bee', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8dfd6697-dc26-483a-aaba-9ada76a38037', N'4013', N'H Buôn Đôn', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'452c013d-6a47-412b-aa49-9b305fdb36f3', N'5111', N'H Thoại Sơn', 1, NULL, N'75452825-bf11-4d5a-baa2-ab4905a5349d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3558df8a-7938-4ef0-9ad9-9ba733a20f9f', N'2904', N'H Quỳ Hợp', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd0d41154-74e8-4bb3-9fe5-9c16a11c1bde', N'5807', N'H Cầu Ngang', 1, NULL, N'72a67ef4-0a80-4bc3-a047-435f64b76a53', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b596d5b7-01c1-474c-b41f-9cadfad62e50', N'2917', N'H Nam Đàn', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b4cb6820-cdeb-43c5-94c3-9ce52ce548b7', N'4010', N'H Krông Ana', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e8b7802e-0783-406f-9635-9d07b9b993e1', N'5008', N'H Lấp Vò', 1, NULL, N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3a6d85c0-d06a-4ffc-8871-9dc62b5d24e4', N'6302', N'H Đăk R''Lấp', 1, NULL, N'05e01cd8-6539-4dfe-9505-64d332006bb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'35d016b8-9a42-4b7b-b68a-9e1f046d1f9b', N'6004', N'H Giá Rai', 1, NULL, N'2c1152a3-d2f7-42c7-a4e7-85a4eb519e29', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ea853791-9b52-4e09-93c2-9e6990b5fca9', N'0106', N'Q Cầu Giấy', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9635582d-790f-4d91-afed-9fb49fca56fa', N'1506', N'H Cẩm Khê', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7d01e810-8df0-4414-9479-a09487a04ee9', N'4604', N'H Dương Minh Châu', 1, NULL, N'66c4231e-f04c-4687-954f-300eb34991c4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd688d91d-4f85-42f6-9ab5-a0f95cafbb8c', N'2908', N'H Tương Dương', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'85fb41c1-7c4c-40cd-af29-a149bca0361f', N'4504', N'H Ninh Phước', 1, NULL, N'98da7653-c483-4540-8d8a-ba468b43cc8b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'643d4f96-52d3-43cb-9ed5-a174112a482c', N'5605', N'H Giồng Trôm', 1, NULL, N'cfb493d0-47f9-4528-bdf1-b5b42d2a7440', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9cc2fcae-9894-4ed3-8069-a18ce86bed34', N'1511', N'H Tam Nông', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1dce8b8d-4fe2-46de-9b98-a1a49a6bd63e', N'0127', N'H Thường Tín', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a159be12-0736-4ceb-89bc-a260cc35e8c2', N'0205', N'Quận 5', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b08a229d-dfc3-4b17-a7b3-a31434ea2d41', N'5003', N'H Tân Hồng', 1, NULL, N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ab577831-af6e-4d42-9c75-a363dd5af108', N'1207', N'H Đồng Hỷ', 1, NULL, N'a676a9f5-145d-4d5f-ac80-21e58935203c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fb395ca0-133d-4810-be33-a36f98fc837a', N'2210', N'H Văn Giang', 1, NULL, N'13f07126-2fd4-4954-9f65-7c3409f8bd35', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'67490e0a-ccf2-4a56-95cc-a39ff293019c', N'6002', N'H Vĩnh Lợi', 1, NULL, N'2c1152a3-d2f7-42c7-a4e7-85a4eb519e29', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'38c193d6-548c-4656-9974-a3f111d74db4', N'2808', N'H Thường Xuân', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'edd8b420-68b8-4274-a94a-a42d8381fd10', N'1202', N'TX Sông Công', 1, NULL, N'a676a9f5-145d-4d5f-ac80-21e58935203c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fc1fa895-83af-40c0-9b0b-a4cc0f913e2e', N'2708', N'H Yên Khánh', 1, NULL, N'56ee4087-9b4b-41c8-965f-da43f3fedc21', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'431ba866-a00e-4f5b-a932-a5276061003e', N'1901', N'TX Bắc Ninh', 1, NULL, N'58a665e3-85d3-4dd0-b01d-f7a5ddcb2114', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'bf14dcdf-d32f-4707-a724-a54b99849628', N'2703', N'H Nho Quan', 1, NULL, N'56ee4087-9b4b-41c8-965f-da43f3fedc21', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'959ae422-ffc0-4654-80b2-a6329592e71b', N'3007', N'H Hương Khê', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a1d59378-fbc0-4708-8d01-a6556f4a4a1e', N'0126', N'H Ứng Hòa', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9d9830ad-5d3e-4c49-a1c4-a6b5c5cc172a', N'1503', N'H Đoan Hùng', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7dfdf367-c612-42b9-bfdd-a6da226d98e1', N'4904', N'H Tân Thạnh', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fc5db219-b797-48a5-affd-a71f259f9d52', N'2507', N'H Nam Trực', 1, NULL, N'34ab5555-3bee-40a5-a974-32c5b808f03b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'77d7353a-bcbf-4c9a-8b38-a75e12f23f8e', N'2105', N'H Gia Lộc', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fbd02e31-c545-4da0-953b-a8220831d652', N'1606', N'H Bình Xuyên', 1, NULL, N'21fbf0a7-7939-4ff7-aee4-822e7869ddd2', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd9250697-88c1-484b-b5b6-a8fdb86bdb2e', N'2208', N'H Mỹ Hào', 1, NULL, N'13f07126-2fd4-4954-9f65-7c3409f8bd35', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ccab91be-4a21-4f1c-a0d6-a94dd7c8604c', N'5910', N'H Châu Thành', 1, NULL, N'ceeb3bb7-3959-45a3-a6c7-657408731438', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'73acdfea-68e3-4492-a118-a97f592c7b02', N'0607', N'H Nguyên Bình', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'effcf329-a5d9-4a40-8652-aa3d7c1d3208', N'5004', N'H Hồng Ngự', 1, NULL, N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b9070f2b-7b7c-4551-9416-aa838ceb57f0', N'4607', N'H Bến Cầu', 1, NULL, N'66c4231e-f04c-4687-954f-300eb34991c4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'74ad6b67-57b8-4512-b003-ac5ef9ccc1b3', N'4308', N'H Bù Đăng', 1, NULL, N'648cd679-d07b-44c4-8ef6-ce4f45aaad4f', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8fd2cac9-f437-4cd3-a0c9-ac695e4fc11d', N'4103', N'H Ninh Hòa', 1, NULL, N'5dcda423-8bc0-405c-b111-7b4129ee9129', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f7833417-7bc5-45f4-b322-acb54c430f37', N'2302', N'H Đà Bắc', 1, NULL, N'89952828-32e3-4b69-9d02-f58dc73fe1b1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'18d0e414-e496-43bc-bdf6-ade538814f90', N'2907', N'H Kỳ Sơn', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'062e3226-62b6-4e0d-8775-ade7d0f530d5', N'3607', N'H Đăk Hà', 1, NULL, N'03ccc7fc-d0be-4e51-9ab3-186515080313', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f245e6de-57b0-41d9-b77f-adef22c1e9a7', N'3511', N'H Đức Phổ', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fb2bc23b-1545-470a-b66c-ae15927ebf1e', N'1605', N'H Yên Lạc', 1, NULL, N'21fbf0a7-7939-4ff7-aee4-822e7869ddd2', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'59e52d6d-37b1-44cf-8882-aebb09a58470', N'6201', N'Tp Điện Biên', 1, NULL, N'f8147816-2225-43a6-8662-e3770fc549bd', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7e8c925f-7a74-471c-81cc-aed54c6ba562', N'4909', N'H Thủ Thừa', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'07b1d722-bff3-4da5-9ef3-af2945cb00d6', N'3103', N'H Minh Hóa', 1, NULL, N'ccfeec9e-e27f-4a60-b5d4-8a638b798a3b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9fd74098-94d5-4912-8e0d-afcdc27489ea', N'1709', N'H Ba Chẽ', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ed326b99-8327-4097-966b-afe137fc9d0f', N'3009', N'H Cẩm Xuyên', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'514cf6df-1473-4f8e-b8ed-b020a4414bcb', N'4907', N'H Đức Hòa', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c65519c2-bb21-4087-a674-b085f1fc3bf2', N'3403', N'H Duy Xuyên', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ae452659-bd6e-469a-ba74-b111e5671983', N'0804', N'H Bảo Thắng', 1, NULL, N'9ad6a6c6-b93a-462c-bf42-4618ddc3860d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd497fa1c-8762-4648-8f44-b136113e8cce', N'0107', N'Q Thanh Xuân', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b2cab3a3-faf1-4fa3-9023-b1780a307935', N'4608', N'H Gò Dầu', 1, NULL, N'66c4231e-f04c-4687-954f-300eb34991c4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'38d82abd-2516-4c27-bfa9-b19e998665df', N'1309', N'H Lục Yên', 1, NULL, N'b5edd6e0-91bf-4294-ade4-33ad54c993bf', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ee9f32a7-7a90-426c-b6fa-b2f68f7758c1', N'4601', N'TX Tây Ninh', 1, NULL, N'66c4231e-f04c-4687-954f-300eb34991c4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8275c77a-d7b0-45ab-837e-b335980aac9e', N'5001', N'TX Cao Lãnh', 1, NULL, N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e56fccac-58cd-4840-b188-b3791b33599d', N'2905', N'H Nghĩa Đàn', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'02e5c40b-3a4f-462f-bf70-b3ac863412a8', N'2821', N'H Hà Trung', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'caf2fdfb-bf4a-4215-834e-b3f815beb276', N'2824', N'H Hậu Lộc', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2ddc7988-e929-4ada-b3b8-b3fcc7f0e874', N'4309', N'H Hớn Quản', 1, NULL, N'648cd679-d07b-44c4-8ef6-ce4f45aaad4f', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ad7dcdfc-1d7a-4be5-9409-b4670ddcab08', N'6306', N'H KrôngNô', 1, NULL, N'05e01cd8-6539-4dfe-9505-64d332006bb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'aca90ac7-18c4-4c45-be40-b4b4353c8cf5', N'4206', N'H Lạc Dương', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'421e16bd-f41e-42c7-8bed-b60e71284568', N'2903', N'H Quỳ Châu', 1, NULL, N'8e27702f-f742-4702-a42e-ce083343163a', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6249ffac-9a5a-4fd1-a910-b71f03feea57', N'4007', N'H Krông Pắc', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a76cd88a-4368-4e20-8b64-b752d935abfd', N'4503', N'H Ninh Hải', 1, NULL, N'98da7653-c483-4540-8d8a-ba468b43cc8b', 0, CAST(0x0000A38C017EE903 AS DateTime))
GO
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd7d9efbb-4293-4268-b54b-b7d071d251b4', N'5704', N'H Bình Minh', 1, NULL, N'35d84f30-2ee0-4fb6-b408-4a438b472abc', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8e4d6278-e472-46d9-9641-b8a1c888c476', N'3815', N'H Đăk Pơ', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b927c01f-42bc-49d9-8058-b8b40947f23f', N'5804', N'H Tiểu Cần', 1, NULL, N'72a67ef4-0a80-4bc3-a047-435f64b76a53', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'cbdd1d87-2ebc-492d-a560-b8d828132934', N'4806', N'TX Long Khánh', 1, NULL, N'21ea9975-e024-45eb-89d5-3d4b1d44e656', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a2cdbc38-d1a4-443f-bee6-b9a352f48405', N'3903', N'H Sông Cầu', 1, NULL, N'36d607e5-3d4a-41c6-85f1-f101a555c654', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'881611c8-c013-47c0-abf7-ba60e1159a58', N'4406', N'H Phú Giáo', 1, NULL, N'218bf6a8-128a-4282-b628-091a28c7ba72', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'86bcf56b-6c7d-429f-8b91-babb623287fe', N'3709', N'H Vân Canh', 1, NULL, N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3b92fad0-6655-4854-9852-bae0b627ea57', N'3401', N'TX Tam Kỳ', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4b269353-af31-4d29-9367-bb5be71ce99d', N'4004', N'H Krông Năng', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'afff37db-f7f8-4610-914f-bbbdb5bac753', N'0104', N'Q Đống Đa', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b89f0f9f-4c2b-427d-8637-bcafede6020e', N'0309', N'H Thủy Nguyên', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'03efac9e-ab7d-48cd-9baa-bcf7a2b1b462', N'0220', N'H Bình Chánh', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e6bb7910-c367-499c-ad4c-bdcca1dca6b3', N'1403', N'H Mương La', 1, NULL, N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b44ded75-e825-4faa-8faf-be0f6d9a78a0', N'1108', N'H Pắc Nặm', 1, NULL, N'5e798e9e-675e-4c85-b518-456c7915474d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b0aeee9c-6edd-43bc-a55a-be359b33c376', N'3601', N'TX Kon Tum', 1, NULL, N'03ccc7fc-d0be-4e51-9ab3-186515080313', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5e0cddf8-057e-4056-9092-be5e74bae3d3', N'5803', N'H Cầu Kè', 1, NULL, N'72a67ef4-0a80-4bc3-a047-435f64b76a53', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'3cc4ef12-3ac3-4476-b2bf-bef094dfa756', N'0305', N'H Hải An', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e8693ced-d49d-499f-946c-bef27b1c47ff', N'0802', N'H Xi Ma Cai', 1, NULL, N'9ad6a6c6-b93a-462c-bf42-4618ddc3860d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b0dafa59-70ca-4491-9f77-bf4a5deee543', N'0507', N'H Bắc Mê', 1, NULL, N'54498638-d285-4aa1-b84b-972ebe00f78d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8518c23b-9026-4bf5-b5d0-bf5ed021360c', N'3702', N'H An Lão', 1, NULL, N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8c97de1b-fdb5-45ea-b8dc-bf8993f0272b', N'1404', N'H Thuận Châu', 1, NULL, N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a7e77d92-3be4-4911-bbc1-bf8f32c091da', N'0503', N'H Mèo Vạc', 1, NULL, N'54498638-d285-4aa1-b84b-972ebe00f78d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2a32f369-2549-4822-81bc-c02b304dd4ec', N'4501', N'TX Phan Rang-Tháp Chàm', 1, NULL, N'98da7653-c483-4540-8d8a-ba468b43cc8b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ae3bdbb2-0842-413a-bdec-c0b4441d3516', N'2825', N'H Quảng Xương', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'26d57155-c2c5-4ffa-a2a1-c1161294728c', N'0119', N'H Thạch Thất', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'63880d20-36dd-40f8-8f41-c123ee0448e4', N'1508', N'H Thanh Sơn', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'08308e3d-ed87-4ac2-957e-c176231505b4', N'2107', N'H Thanh Miện', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'74e99145-098e-48ff-bb69-c1869ca1d980', N'6308', N'H Tuy Đức', 1, NULL, N'05e01cd8-6539-4dfe-9505-64d332006bb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ce0172e6-592b-4a61-b99f-c187bf4ad45b', N'4212', N'H Đam Rông', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ea409b6a-f17d-49b0-bd4e-c1e451815c6d', N'2704', N'H Gia Viễn', 1, NULL, N'56ee4087-9b4b-41c8-965f-da43f3fedc21', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b7dafeaa-1f05-4fa8-b64a-c1eb020948b4', N'3407', N'H Hiệp Đức', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f53fd6f2-566e-48ee-9c0d-c20dea4c8456', N'3404', N'H Điện Bàn', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'79a190e6-0668-488f-9215-c2a0e96e1e78', N'5301', N'TP Mỹ Tho', 1, NULL, N'673308b5-dc96-4e1e-b578-3e5691a68f1e', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'de2a4ae8-3d2a-4b36-89c1-c3198dfaee15', N'0808', N'H Bắc Hà', 1, NULL, N'9ad6a6c6-b93a-462c-bf42-4618ddc3860d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b75f485f-7d6d-4870-aed4-c333d0c79ea0', N'3411', N'H Trà My', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'be96713f-609a-4e0a-8c61-c34a3fd02a63', N'4301', N'H Đồng Xoài', 1, NULL, N'648cd679-d07b-44c4-8ef6-ce4f45aaad4f', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a0c36ab6-91e1-4247-b84f-c38128dbf43b', N'2501', N'TP Nam Định', 1, NULL, N'34ab5555-3bee-40a5-a974-32c5b808f03b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5373f77c-c8e5-4fab-a1fa-c456b622ac21', N'1807', N'H Hiệp Hòa', 1, NULL, N'912ceefc-bbf6-4f1c-8dbf-a35d1408e2ff', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd19045c6-164c-4ee1-9181-c46d2bd857f9', N'0401', N'Q Hải Châu', 1, NULL, N'c29aa669-3b60-4950-bdde-2ba6a00c2507', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c040cabd-f7d3-4c7a-91e1-c479bac3a882', N'4101', N'TP Nha Trang', 1, NULL, N'5dcda423-8bc0-405c-b111-7b4129ee9129', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f598add8-6467-4d96-ae2d-c4bfb7901a76', N'3203', N'H Vĩnh Linh', 1, NULL, N'8c8f0507-588c-4c51-843f-41dec2f2d0e7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6ea96fff-7750-45fe-af6c-c5467483f205', N'1712', N'H Hoành Bồ', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4023ab5d-5f70-4a25-9c48-c5597ffaa9d8', N'5002', N'TX Sa Đéc', 1, NULL, N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'461a9dab-0b5c-433d-a19a-c736e3887ce3', N'3011', N'H Vũ Quang', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'572b4c27-d1d9-4e9b-b866-c7433715905d', N'0702', N'H Tam Đường', 1, NULL, N'112c407c-448c-411d-a1c5-50d16d4980a1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6035235a-ec2b-4cd9-b716-c74d22364c14', N'3710', N'H An Nhơn', 1, NULL, N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'07b93686-23ed-49de-ae03-c7a17ba14b68', N'0215', N'Q Tân Phú', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0c79b269-dee5-46c2-bfc1-c7d4b9963e65', N'3412', N'H Đông Giang', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'15e45f05-3172-4286-a46f-c8e01e1b82fa', N'0606', N'H Trùng Khánh', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a1125f61-ae0a-4846-862a-c8ed075018c2', N'4008', N'H Ea Kar', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd010a78e-6778-4d89-919f-c901e8a266b6', N'5604', N'H Mỏ Cày', 1, NULL, N'cfb493d0-47f9-4528-bdf1-b5b42d2a7440', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'f8bbae1d-f865-4b68-8385-c90e11fa847b', N'0807', N'H Bảo Yên', 1, NULL, N'9ad6a6c6-b93a-462c-bf42-4618ddc3860d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'adc9c09e-4c56-46ce-8c4a-c95e0a226001', N'6105', N'H Cái Nước', 1, NULL, N'340f9b94-1df9-4ae5-9fee-61cd234ca532', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5623c159-fa54-4dda-a020-c96bf846f058', N'5413', N'H Kiên Hải', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'66ce4f1a-aef2-497c-946a-c9ca759f7fcf', N'6404', N'H Phụng Hiệp', 1, NULL, N'207a629f-6eed-4352-8eb5-d398d72cad67', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'147a5e0c-1eba-4817-a121-cad3c15c061a', N'5107', N'H Tri Tôn', 1, NULL, N'75452825-bf11-4d5a-baa2-ab4905a5349d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c5e229d4-5abd-4500-9f47-cbd3972c1d6f', N'5306', N'H Chợ Gạo', 1, NULL, N'673308b5-dc96-4e1e-b578-3e5691a68f1e', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'68de577a-1d15-40b4-89db-cbe3cc7e58d5', N'2816', N'H Vĩnh Lộc', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd92bdf56-6d2b-4786-9953-cc44f7152618', N'2814', N'H Thiệu Hóa', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'25265df3-be67-42b6-8db4-cc74bf69cd7c', N'5007', N'H Cao Lãnh', 1, NULL, N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'2bc69580-1b62-414a-9cf2-ccb0b61656d6', N'1504', N'H Thanh Ba', 1, NULL, N'e5538bfe-4592-4eef-95c7-c146b589c089', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'034bd4ba-85fd-4914-914b-ccd23fb8c373', N'0307', N'H An Lão', 1, NULL, N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'02049e14-bc74-43bf-ba59-cd46b1553184', N'1802', N'H Yên Thế', 1, NULL, N'912ceefc-bbf6-4f1c-8dbf-a35d1408e2ff', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4a222d71-0e2e-4348-802e-cdb78c424240', N'1711', N'H Yên Hưng', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'21328962-ce1e-43f8-8458-cea0de9dbbf1', N'2305', N'H Lạc Sơn', 1, NULL, N'89952828-32e3-4b69-9d02-f58dc73fe1b1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7a5c9c25-18c9-4edd-9727-cef97c48a245', N'0213', N'Q Gò Vấp', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8379159c-e7d8-4884-9e95-cf7cb2d09511', N'4902', N'H Vĩnh Hưng', 1, NULL, N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'44a0818b-7452-419e-a4d4-d00baed8dd9b', N'6403', N'H Long Mỹ', 1, NULL, N'207a629f-6eed-4352-8eb5-d398d72cad67', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'94157c6d-5dc6-458d-a616-d041a1354374', N'1410', N'H Mộc Châu', 1, NULL, N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd43e9fd0-50c8-4291-920c-d099d9da6634', N'4609', N'H Trảng Bàng', 1, NULL, N'66c4231e-f04c-4687-954f-300eb34991c4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6209d3e6-d908-4537-8e56-d1cdc0892025', N'0809', N'H Mường Khương', 1, NULL, N'9ad6a6c6-b93a-462c-bf42-4618ddc3860d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'89510961-9685-4108-aab3-d1da175cf445', N'4603', N'H Tân Châu', 1, NULL, N'66c4231e-f04c-4687-954f-300eb34991c4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5a93ac00-baf1-44cd-90ac-d22a116f627b', N'0210', N'Quận 10', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c02c6c3d-1ec7-4a63-862a-d26743509e32', N'0217', N'Q Phú Nhuận', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5030d3fe-730c-4c77-9c67-d2e63d37657b', N'0112', N'H Gia Lâm', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd05b4c29-b918-4778-9230-d50a6098b92b', N'0201', N'Quận 1', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'079c1e27-8dd6-49cd-8705-d5967ab9b01d', N'0111', N'H Thanh Trì', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd2518be9-dcc5-4568-b693-d5f1b4094205', N'1704', N'TX Móng Cái', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b9545390-c2a1-46b3-b45a-d6874cac5433', N'2503', N'H Xuân Trường', 1, NULL, N'34ab5555-3bee-40a5-a974-32c5b808f03b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'16b39eaa-01eb-419b-a5f8-d6c3428b4669', N'3803', N'H Mang Yang', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e54de740-efa8-44d5-8cea-d74fc7703ecc', N'0609', N'H Quảng Uyên', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c709ccdb-20a7-4995-997e-d7c29a66fec8', N'3406', N'H Quế Sơn', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ffc68310-64d6-416b-83d7-d7fe4ff11241', N'2207', N'H Phù Cừ', 1, NULL, N'13f07126-2fd4-4954-9f65-7c3409f8bd35', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'590a0528-fe24-43f8-a38b-d863961870b4', N'5602', N'H Châu Thành', 1, NULL, N'cfb493d0-47f9-4528-bdf1-b5b42d2a7440', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'cb0638a0-5c8a-4ff8-8e0e-d87f2c0ad230', N'0223', N'H Nhà Bè', 1, NULL, N'd226207d-bb86-4603-b2fd-499ecbafad4c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e6c0cfef-015e-4a4f-ad25-d90b34fc3295', N'2818', N'H Triệu Sơn', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8108af9c-a7d8-43a1-a139-d965ecf3a3c9', N'3402', N'TX Hội An', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6d298d7b-ed01-4167-969b-d99c6e9ab6d2', N'4811', N'H Cẩm Mỹ', 1, NULL, N'21ea9975-e024-45eb-89d5-3d4b1d44e656', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'efde42cc-9865-4215-8242-d9bb1dd3533f', N'5705', N'H Tam Bình', 1, NULL, N'35d84f30-2ee0-4fb6-b408-4a438b472abc', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'26766db4-de06-42a6-ac9c-da0cc5b586ee', N'2406', N'H Bình Lục', 1, NULL, N'791c45b8-1d33-4728-b08b-83b4027c8cb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a1ad06fd-10f8-42db-b6d4-da3ee74740da', N'1204', N'H Phú Lương', 1, NULL, N'a676a9f5-145d-4d5f-ac80-21e58935203c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'eec9b17a-b59d-41c4-b144-da486cffa1e6', N'6303', N'H Đăk Mil', 1, NULL, N'05e01cd8-6539-4dfe-9505-64d332006bb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5ae3c6a2-84b2-491d-bae5-dbdd83bbb981', N'5609', N'H Mỏ Cày Nam', 1, NULL, N'cfb493d0-47f9-4528-bdf1-b5b42d2a7440', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a45e543f-502b-4131-bd87-dc0efe593302', N'4005', N'H Ea Súp', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'4338973c-a2b2-4e79-81ca-dc7b59739033', N'3414', N'H Phước Sơn', 1, NULL, N'6d77f418-ff02-46e6-bf57-51c457b345d3', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'cd8ac08a-2a43-4267-95c1-dcab7efa2d75', N'0121', N'H Chương Mỹ', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ff5ac916-4ac5-4e65-88ff-dcd73213ff1a', N'4706', N'H Hàm Tân', 1, NULL, N'b5835ce9-45c2-4d0d-9b6b-3c74ec479bee', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'049c5210-b227-415c-a5b9-dcf01bf48e4f', N'2819', N'H Nông Cống', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'124e8761-35cd-4107-b949-dd17b595c77f', N'3808', N'H Chư Prông', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7096b13f-1797-4e31-a989-dda6ff6d219e', N'4014', N'H Cư Kuin', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
GO
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd1ca358d-e7a8-46fb-beb1-ddbcd72836eb', N'3605', N'H Sa Thầy', 1, NULL, N'03ccc7fc-d0be-4e51-9ab3-186515080313', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'14aea0cf-387b-4afa-9311-ddff33b6336b', N'2804', N'H Quan Hóa', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'85fcbc97-73ad-4695-b99d-de0a7dcbc881', N'4108', N'H Trường Sa', 1, NULL, N'5dcda423-8bc0-405c-b111-7b4129ee9129', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ecb2ee46-2ef9-4337-9c68-dec407b0feda', N'2201', N'TX Hưng Yên', 1, NULL, N'13f07126-2fd4-4954-9f65-7c3409f8bd35', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd179e6ce-e9ec-4a95-98c7-ded044348f64', N'6208', N'H Mường Nhé', 1, NULL, N'f8147816-2225-43a6-8662-e3770fc549bd', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c48e8147-366a-4144-92c3-df1d598d357e', N'1706', N'H Đầm Hà', 1, NULL, N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c00560f5-2181-4af1-bbc1-df50a9666614', N'0407', N'H Hòa Vang', 1, NULL, N'c29aa669-3b60-4950-bdde-2ba6a00c2507', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a4a1ee6d-2ec2-44f9-8224-dfa5e0ce3e07', N'2101', N'TP Hải Dương', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'35a63ec7-a0d5-4b0e-a124-e1242abd0e6b', N'5905', N'H Thạnh Trị', 1, NULL, N'ceeb3bb7-3959-45a3-a6c7-657408731438', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'dbbad394-0cfb-4b13-83c1-e16cea4e2eca', N'1103', N'H Bạch Thông', 1, NULL, N'5e798e9e-675e-4c85-b518-456c7915474d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fd180cac-09c2-4951-a0e6-e1e7d03c45c8', N'2807', N'H Bá Thước', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'508e707d-a819-4f9a-8f34-e2e067925f57', N'5506', N'H Cờ Đỏ', 1, NULL, N'a88db316-ed46-4f90-8996-165ac1b3b19d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'44ceb3f4-feab-4c00-9489-e2fa99268911', N'4703', N'H Bắc Bình', 1, NULL, N'b5835ce9-45c2-4d0d-9b6b-3c74ec479bee', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8390efbf-f929-47a6-9057-e336541872f1', N'3510', N'H Mộ Đức', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0dfbcfa3-2e65-49e6-a5c5-e352edda8c78', N'3010', N'H Kỳ Anh', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e8e8c6d0-3e8a-46a4-a5ef-e3598be48cff', N'6207', N'H Điện Biên Đông', 1, NULL, N'f8147816-2225-43a6-8662-e3770fc549bd', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1d201993-cb67-4497-a602-e35dc318bd02', N'5707', N'H Vũng Liêm', 1, NULL, N'35d84f30-2ee0-4fb6-b408-4a438b472abc', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'47751e3d-f927-4672-abb1-e429fa2909bb', N'5403', N'H Kiên Lương', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1ded52db-37a3-46f1-a6c6-e45ee50a3340', N'1203', N'H Định Hóa', 1, NULL, N'a676a9f5-145d-4d5f-ac80-21e58935203c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'92ee5549-8687-42a0-8914-e525d42a3a65', N'2805', N'H Quan Sơn', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e4b2f727-5b26-4086-8084-e766b1421c41', N'2802', N'TX Bỉm Sơn', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8b77e254-2442-4b4a-bc4e-e77e2b927709', N'1006', N'H Văn Quan', 1, NULL, N'5bad1676-5593-4b79-af80-cd9a1739bdb4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'23cb9e86-01c6-4ba6-8722-e7e684bb0501', N'2109', N'H Cẩm Giàng', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6f026a23-e864-42e9-9c82-e89d85557ee4', N'4306', N'H Bù Đốp', 1, NULL, N'648cd679-d07b-44c4-8ef6-ce4f45aaad4f', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'58327ea9-38d3-43aa-b4f4-e8dda66e6e1b', N'5205', N'H Côn Đảo', 1, NULL, N'ba1ec8a8-bdbe-4b4b-8441-b8eb3b55b894', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'17a1ce90-f44d-4856-a03a-e91035bd707b', N'0113', N'H Đông Anh', 1, NULL, N'1e382657-b8b7-41ca-b49e-f3a9d114794c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'774f2422-826f-44f2-a342-e93bee4f0f35', N'3207', N'H Hải Lăng', 1, NULL, N'8c8f0507-588c-4c51-843f-41dec2f2d0e7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fe9ed550-9d1f-4476-b774-e98381189d53', N'2304', N'H Tân Lạc', 1, NULL, N'89952828-32e3-4b69-9d02-f58dc73fe1b1', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6c76d7c5-7424-45b8-8a7f-e9c60803aed3', N'5406', N'H Châu Thành', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'04a28c02-dbaa-4a1b-8847-e9d172362938', N'0601', N'TX Cao Bằng', 1, NULL, N'7c2c5fc2-74b7-4588-9826-0200865e13b9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'cb16b4fe-ee6f-46c6-8864-eaef4a7910df', N'3604', N'H Đăk Tô', 1, NULL, N'03ccc7fc-d0be-4e51-9ab3-186515080313', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'efebbf9d-f401-46c3-b6c3-eb3605a04c13', N'5401', N'TX Rạch Giá', 1, NULL, N'ae427114-0002-4769-95b1-76b5b6616a26', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8ab1ec80-4fb8-45f7-ab49-eb65de37c428', N'6205', N'H Mường Lay', 1, NULL, N'f8147816-2225-43a6-8662-e3770fc549bd', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ee1a5a0d-6f13-4282-9ffb-eb671dd8d455', N'2401', N'TX Phủ Lý', 1, NULL, N'791c45b8-1d33-4728-b08b-83b4027c8cb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9a8cdf58-1a8d-4a3b-aa2c-ec17f9acdf86', N'6209', N'H Mường Ảnh', 1, NULL, N'f8147816-2225-43a6-8662-e3770fc549bd', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'20f471b2-402e-4bbc-9653-ec6ad5a8d4de', N'3106', N'H Quảng Ninh', 1, NULL, N'ccfeec9e-e27f-4a60-b5d4-8a638b798a3b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'bba85394-df8d-4c49-b89a-ec83a52ee1ae', N'2502', N'H Mỹ Lộc', 1, NULL, N'34ab5555-3bee-40a5-a974-32c5b808f03b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fc18f8cd-48ff-4df6-a570-ecacc2a1d80f', N'6101', N'TP Cà Mau', 1, NULL, N'340f9b94-1df9-4ae5-9fee-61cd234ca532', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7c6ed39c-880f-49fd-bced-ecfbd44d68a0', N'4307', N'H Phước Long', 1, NULL, N'648cd679-d07b-44c4-8ef6-ce4f45aaad4f', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'924e8746-b394-4031-baca-ed0be1b95c8d', N'1608', N'TX Phúc Yên', 1, NULL, N'21fbf0a7-7939-4ff7-aee4-822e7869ddd2', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'be1ec00d-2a3b-4886-96ba-ed461a016768', N'3904', N'H Tuy An', 1, NULL, N'36d607e5-3d4a-41c6-85f1-f101a555c654', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ce1f057c-709a-4618-bc39-ed5ce03a5d0b', N'3309', N'H A Lưới', 1, NULL, N'74f1f256-ad11-40d2-ad59-26c36c4ca939', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a981cbab-192e-4353-bb2d-edc946c73a43', N'3210', N'H Đảo Cồn Cỏ', 1, NULL, N'8c8f0507-588c-4c51-843f-41dec2f2d0e7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'11a1e38b-0253-4de1-bda3-ee0e564cff58', N'1101', N'TX Bắc Kạn', 1, NULL, N'5e798e9e-675e-4c85-b518-456c7915474d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8b280096-ba2f-4ba0-8eea-ee384eae2519', N'2823', N'H Nga Sơn', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'652af9e9-f226-4e00-8793-eea5bf570fed', N'4407', N'H Dầu Tiếng', 1, NULL, N'218bf6a8-128a-4282-b628-091a28c7ba72', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c3eeb2c6-9fad-4439-a47e-efda7a0da024', N'4810', N'Trảng Bom', 1, NULL, N'21ea9975-e024-45eb-89d5-3d4b1d44e656', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'6bdfae7b-cb14-49a1-84b8-f0a3a8643115', N'2110', N'H Thanh Hà', 1, NULL, N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'18d3f36c-ded1-4604-b8c6-f115a66090bd', N'5106', N'H Tịnh Biên', 1, NULL, N'75452825-bf11-4d5a-baa2-ab4905a5349d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5b309cc9-77e1-4539-80b3-f1482d04e9f9', N'2404', N'H Lý Nhân', 1, NULL, N'791c45b8-1d33-4728-b08b-83b4027c8cb7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'8c576dc2-3cca-4e81-930a-f185af168d69', N'3105', N'H Bố Trạch', 1, NULL, N'ccfeec9e-e27f-4a60-b5d4-8a638b798a3b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'81c726e3-39b5-4e23-82b8-f1f0e8022665', N'2801', N'TP Thanh Hóa', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'821741fb-3243-449f-b0e2-f27ed1264ec3', N'4702', N'H Tuy Phong', 1, NULL, N'b5835ce9-45c2-4d0d-9b6b-3c74ec479bee', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'114d3b8d-56af-42dc-8cfe-f29b3d84dd11', N'2504', N'H Giao Thủy', 1, NULL, N'34ab5555-3bee-40a5-a974-32c5b808f03b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'195e7686-6648-4661-9af4-f2d6167bfd43', N'0501', N'TX Hà Giang', 1, NULL, N'54498638-d285-4aa1-b84b-972ebe00f78d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'9abcb63d-80be-46c2-b7aa-f2f276c8ba92', N'5207', N'H Châu Đức', 1, NULL, N'ba1ec8a8-bdbe-4b4b-8441-b8eb3b55b894', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0eea971b-2191-43d4-91fd-f406d7fa4b1e', N'5801', N'TX Trà Vinh', 1, NULL, N'72a67ef4-0a80-4bc3-a047-435f64b76a53', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'a871acdb-c091-4688-beb1-f414216d1945', N'0504', N'H Yên Minh', 1, NULL, N'54498638-d285-4aa1-b84b-972ebe00f78d', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'61621203-c85a-4783-91d1-f52bed826eec', N'5808', N'H Duyên Hải', 1, NULL, N'72a67ef4-0a80-4bc3-a047-435f64b76a53', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'd2edbac2-e4d9-49f9-9a96-f59b2098caa6', N'5303', N'H Cái Bè', 1, NULL, N'673308b5-dc96-4e1e-b578-3e5691a68f1e', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'da49f942-9dfc-41f7-899e-f5adcea2a6d2', N'2702', N'TX Tam Điệp', 1, NULL, N'56ee4087-9b4b-41c8-965f-da43f3fedc21', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'edd4be25-a4a6-419e-bffc-f5b7031057cd', N'3512', N'H Ba Tơ', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'1593d902-118d-4891-b03b-f633bbe172f3', N'0902', N'H Na Hang', 1, NULL, N'53a568c0-2ae3-461e-9588-e9b8f821a01c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'e36292ab-ab47-42ab-9cb0-f6fe96fc1132', N'6107', N'H Ngọc Hiển', 1, NULL, N'340f9b94-1df9-4ae5-9fee-61cd234ca532', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'ae6aa620-960a-41db-a737-f730c9e306dd', N'3504', N'H Trà Bồng', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'14637d14-94a4-4a8a-90a8-f765ec8ba091', N'5802', N'H Càng Long', 1, NULL, N'72a67ef4-0a80-4bc3-a047-435f64b76a53', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'17ce0e48-91dd-4025-bf44-f7a46f777ed3', N'5904', N'H Mỹ Xuyên', 1, NULL, N'ceeb3bb7-3959-45a3-a6c7-657408731438', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'73acaa62-ca22-4a32-ba3f-f82cf1bd81b5', N'3209', N'H Đăk Rông', 1, NULL, N'8c8f0507-588c-4c51-843f-41dec2f2d0e7', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c4bc57ac-1152-48c1-965d-f8ab32cfc7d5', N'3816', N'H Phú Thiện', 1, NULL, N'b134a219-51b7-4903-ac2c-d852b18a5e34', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'0ba0a429-f7ef-458f-9063-f8dc5d9abc15', N'4403', N'H Tân Uyên', 1, NULL, N'218bf6a8-128a-4282-b628-091a28c7ba72', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'aafd4db8-0574-48e0-9387-f9ad08e1f464', N'1002', N'H Tràng Định', 1, NULL, N'5bad1676-5593-4b79-af80-cd9a1739bdb4', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5d219f03-ac45-4001-8e5f-fa0c504c6f27', N'5307', N'H Gò Công Tây', 1, NULL, N'673308b5-dc96-4e1e-b578-3e5691a68f1e', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'903dfd4a-1c18-4c5d-bb6a-fa3d7ca8996e', N'3508', N'H Nghĩa Hành', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'18c2ab69-7040-4ccc-aa0c-fb168c890a46', N'5901', N'TX Sóc Trăng', 1, NULL, N'ceeb3bb7-3959-45a3-a6c7-657408731438', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'37c8627d-4674-4d25-9c66-fbf7b1399975', N'3501', N'TX Quảng Ngãi', 1, NULL, N'2467dcd2-bf39-4a22-8bee-d97d33408f41', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5491529e-b01d-496c-8d55-fcaa2208d7df', N'2506', N'H Vụ Bản', 1, NULL, N'34ab5555-3bee-40a5-a974-32c5b808f03b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'b47eee28-2f0e-49b8-b6b2-fd1438a0aa15', N'1205', N'H Võ Nhai', 1, NULL, N'a676a9f5-145d-4d5f-ac80-21e58935203c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'858112ad-e6a8-4b77-8ae3-febe07e51872', N'4001', N'TP Buôn Ma Thuột', 1, NULL, N'fd751ec0-e827-450d-8b9a-b87ac0352a86', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'dcbcf3b1-f7bd-488c-9e51-fed5bdf9998f', N'3104', N'H Quảng Trạch', 1, NULL, N'ccfeec9e-e27f-4a60-b5d4-8a638b798a3b', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'7671d62e-fd92-425e-ad92-feff3ad49ef5', N'4207', N'H Đạ Huoai', 1, NULL, N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'5333605b-fab8-4199-b18c-ff201e762238', N'2806', N'H Mường Lát', 1, NULL, N'916418f4-578b-4c84-b7a9-3aa630449108', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'c346021f-423f-406f-9b97-ff4ed99e619a', N'3005', N'H Nghi Xuân', 1, NULL, N'805b7e99-8304-4296-a6fa-c7b0d4eec554', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Quanhuyen] ([QuanhuyenId], [Code], [TenQuanhuyen], [Active], [Ghichu], [TinhthanhId], [Step], [NgayCapnhat]) VALUES (N'fea0d5d8-86d5-4006-8c04-ff79e268a4b1', N'1209', N'H Phổ Yên', 1, NULL, N'a676a9f5-145d-4d5f-ac80-21e58935203c', 0, CAST(0x0000A38C017EE903 AS DateTime))
INSERT [dbo].[Thuchi] ([ThuchiId], [NhanvienId], [PhieunhapId], [PhieuxuatId], [Tongtien], [Vaoluc], [Ngay], [Thang], [Nam], [Ghichu], [Step], [NhannopTienId], [TenNhannopTien]) VALUES (N'd7f75daa-11fa-48dd-b345-d18eed19a301', N'd835daa9-4744-4031-a033-037ba3b36d48', NULL, N'227ffa18-12eb-4cae-8047-2c6183054ed0', 1000000, CAST(0x0000A42800000000 AS DateTime), 22, 1, 2015, NULL, 0, N'f7cdeec5-8f34-4bd0-811f-7e7e8d9668e3', N'Test')
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'aa3346c2-2c24-4533-a756-013e4da84cfc', N'71', N'Nghệ Tĩnh', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'7c2c5fc2-74b7-4588-9826-0200865e13b9', N'06', N'Cao Bằng', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'b8d9cf2f-95c7-4e1c-9e4d-032fbc3a799d', N'46', N'Tây Ninh', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'4d952eed-2cf4-4857-bb59-08b2b616765e', N'36', N'Kon Tum', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'218bf6a8-128a-4282-b628-091a28c7ba72', N'44', N'Bình Dương', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'c96b683f-b7dc-42e0-bcdb-0b99839feb63', N'14', N'Sơn La', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'dc23cef3-e91b-42ea-a91b-0c9f69ef0667', N'33', N'Thừa Thiên Huế', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'ac4f7f2c-3e7a-4c91-8f04-105d04d7b866', N'62', N'Điện Biên', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'e503bf7a-bca6-4f07-833d-129ca9439aee', N'31', N'Quảng Bình', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'afdcaa65-a165-468f-8bf8-15a9d681beae', N'53', N'Tiền Giang', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'c32dd878-0b6f-47ba-8bee-15d030d85f2b', N'37', N'Bình Định', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'a88db316-ed46-4f90-8996-165ac1b3b19d', N'55', N'Cần Thơ', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'03ccc7fc-d0be-4e51-9ab3-186515080313', N'36', N'Kon Tum', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'8a534170-26ef-4e9c-b6cf-1da770e44782', N'14', N'Sơn La', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'a676a9f5-145d-4d5f-ac80-21e58935203c', N'12', N'Thái Nguyên', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'd48a3a56-0aaa-4ddd-b471-263649770238', N'17', N'Quảng Ninh', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'74f1f256-ad11-40d2-ad59-26c36c4ca939', N'33', N'Thừa Thiên Huế', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'91d3ad98-2871-485e-a458-2721ead6143a', N'21', N'Hải Dương', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'ea944d8a-9a08-42ee-8ac8-27289a243e7b', N'39', N'Phú Yên', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'833d6d53-7148-427f-8ad5-2aed8f956900', N'08', N'Lào Cai', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'a58bf29b-f0cd-4b07-82d2-2b6e37034e64', N'24', N'Hà Nam', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'c29aa669-3b60-4950-bdde-2ba6a00c2507', N'04', N'Đà Nẵng', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'66c4231e-f04c-4687-954f-300eb34991c4', N'46', N'Tây Ninh', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'8c002c7a-7d3d-4c92-bc1b-326b1d18d83c', N'25', N'Nam Định', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'b994ed44-88e4-4511-af7c-329d8f664535', N'22', N'Hưng Yên', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'34ab5555-3bee-40a5-a974-32c5b808f03b', N'25', N'Nam Định', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'b5edd6e0-91bf-4294-ade4-33ad54c993bf', N'13', N'Yên Bái', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'b5df594c-0541-4a8d-be77-358688835aa5', N'13', N'Yên Bái', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'916418f4-578b-4c84-b7a9-3aa630449108', N'28', N'Thanh Hóa', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'b5835ce9-45c2-4d0d-9b6b-3c74ec479bee', N'47', N'Bình Thuận', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'fa4f3ea7-4fe6-4ef7-9ea2-3cf2ab546bcc', N'23', N'Hoà Bình', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'21ea9975-e024-45eb-89d5-3d4b1d44e656', N'48', N'Đồng Nai', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'4c8332cc-0447-4bc6-b149-3dfaab80933c', N'49', N'Long An', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'673308b5-dc96-4e1e-b578-3e5691a68f1e', N'53', N'Tiền Giang', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'8c8f0507-588c-4c51-843f-41dec2f2d0e7', N'32', N'Quảng Trị', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'6f1c2408-2906-4266-becd-42c0cc3d3ef9', N'42', N'Lâm Đồng', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'72a67ef4-0a80-4bc3-a047-435f64b76a53', N'58', N'Trà Vinh', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'454ef3b3-673a-41df-99d3-446a5089cca1', N'27', N'Ninh Bình', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'5e798e9e-675e-4c85-b518-456c7915474d', N'11', N'Bắc Kạn', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'9ad6a6c6-b93a-462c-bf42-4618ddc3860d', N'08', N'Lào Cai', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'd226207d-bb86-4603-b2fd-499ecbafad4c', N'02', N'TP. Hồ Chí Minh', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'35d84f30-2ee0-4fb6-b408-4a438b472abc', N'57', N'Vĩnh Long', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38D0188AB34 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'b556bc3c-0ae3-46b7-9028-4d7683a99469', N'55', N'Cần Thơ', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'd4076c8e-67ed-486d-b8b1-4fe0cc2eccdb', N'11', N'Bắc Kạn', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'112c407c-448c-411d-a1c5-50d16d4980a1', N'07', N'Lai Châu', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'f9cd0a67-efa5-4cf5-aa66-5104e4ad535a', N'54', N'Kiên Giang', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'6d77f418-ff02-46e6-bf57-51c457b345d3', N'34', N'Quảng Nam', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'4343c8a3-e709-4a9c-bf50-576533579d76', N'26', N'Thái Bình', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'3eff6b50-b6b3-4a70-9efb-5adc4e85085e', N'34', N'Quảng Nam', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'a931407f-fcff-4894-8c0c-5e7febb8c8c1', N'17', N'Quảng Ninh', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'3319ea3a-ce7d-49fe-bf85-5f5f06794142', N'21', N'Hải Dương', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'c041436d-1d7b-4410-b673-5f75d4c6df20', N'30', N'Hà Tĩnh', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'acc9c1c1-5aab-46c4-937a-60161fdb027e', N'40', N'Đăk Lăk', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'71d56b3a-518e-49ca-9e1e-60c8296865e3', N'38', N'Gia Lai', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'340f9b94-1df9-4ae5-9fee-61cd234ca532', N'61', N'Cà Mau', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'614a7134-273b-4cf5-b974-61d7bfcf8697', N'05', N'Hà Giang', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'05e01cd8-6539-4dfe-9505-64d332006bb7', N'63', N'Đăk Nông', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'ceeb3bb7-3959-45a3-a6c7-657408731438', N'59', N'Sóc Trăng', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'a03e899c-fbfd-400d-aaa3-666ec00d1172', N'56', N'Bến Tre', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'f93b4d44-0ba6-450e-8dd9-6d3d739de0d3', N'50', N'Đồng Tháp', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'67df1060-59a8-4931-9454-72cb906c47cd', N'09', N'Tuyên Quang', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'ae427114-0002-4769-95b1-76b5b6616a26', N'54', N'Kiên Giang', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'c93e589a-1649-460f-836e-7892df4b430a', N'10', N'Lạng Sơn', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'bcc970be-8812-4fee-9c5e-7916658d6356', N'45', N'Ninh Thuận', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'a6443f5c-839f-41e8-93f3-794983714258', N'18', N'Bắc Giang', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'1e33b9ad-e1cf-4450-83e5-7af6dabb0e1d', N'29', N'Nghệ An', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'5dcda423-8bc0-405c-b111-7b4129ee9129', N'41', N'Khánh Hòa', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'13f07126-2fd4-4954-9f65-7c3409f8bd35', N'22', N'Hưng Yên', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'90f7cfd5-d27d-46a8-8718-7ceed59b6b3d', N'63', N'Đăk Nông', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'd7917059-a803-45af-be73-7daa6c2ef1d2', N'47', N'Bình Thuận', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'21fbf0a7-7939-4ff7-aee4-822e7869ddd2', N'16', N'Vĩnh Phúc', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'791c45b8-1d33-4728-b08b-83b4027c8cb7', N'24', N'Hà Nam', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'2c1152a3-d2f7-42c7-a4e7-85a4eb519e29', N'60', N'Bạc Liêu', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'674b2c0e-1d7f-4f9d-bf73-876295f51017', N'41', N'Khánh Hòa', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'1c2bcbce-6b78-4311-afd8-8907a3a27e86', N'64', N'Hậu Giang', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'ccfeec9e-e27f-4a60-b5d4-8a638b798a3b', N'31', N'Quảng Bình', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'2a5212a2-9095-4c30-8a0b-8d92ce5b8c67', N'43', N'Bình Phước', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'5d86322c-5d9f-4f9a-a5ce-96936e83d038', N'32', N'Quảng Trị', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'54498638-d285-4aa1-b84b-972ebe00f78d', N'05', N'Hà Giang', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'ecf7b647-be92-4338-8f22-a157187a3bc3', N'48', N'Đồng Nai', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'912ceefc-bbf6-4f1c-8dbf-a35d1408e2ff', N'18', N'Bắc Giang', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'c78ddb6e-b42f-48ed-aa89-a3c916ef3cb1', N'12', N'Thái Nguyên', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'60459233-2a08-4680-82c1-a407ec4d4f39', N'51', N'An Giang', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'75452825-bf11-4d5a-baa2-ab4905a5349d', N'51', N'An Giang', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'a2a9dee4-79cc-47d4-822b-b134e2b9cf65', N'01', N'Hà Nội', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'89f4fa2c-6c0e-41a6-9aef-b17da7abb6f4', N'19', N'Bắc Ninh', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'fa1b79e5-e515-4e28-a1e0-b3c690240a5e', N'42', N'Lâm Đồng', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'e1b14715-90eb-4963-a540-b4b8ccf3f84b', N'15', N'Phú Thọ', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'cfb493d0-47f9-4528-bdf1-b5b42d2a7440', N'56', N'Bến Tre', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'65798a1b-66ed-45eb-9694-b610a27f0ede', N'50', N'Đồng Tháp', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'b9b3edca-0648-4ae8-bfa4-b6f8f9718dee', N'71', N'Nghệ Tĩnh', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'7b684f52-8140-46a4-b3dd-b82f90f772d7', N'28', N'Thanh Hóa', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'fd751ec0-e827-450d-8b9a-b87ac0352a86', N'40', N'Đăk Lăk', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'ba1ec8a8-bdbe-4b4b-8441-b8eb3b55b894', N'52', N'Bà Rịa - Vũng Tàu', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'98da7653-c483-4540-8d8a-ba468b43cc8b', N'45', N'Ninh Thuận', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'0776cad5-0463-4162-9282-bbb095128fde', N'16', N'Vĩnh Phúc', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'f87c0ef3-a6d2-406e-93c4-bdb63c868775', N'03', N'Hải Phòng', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'e5538bfe-4592-4eef-95c7-c146b589c089', N'15', N'Phú Thọ', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'd167a507-1bba-4e48-9a8b-c51859497cf1', N'59', N'Sóc Trăng', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'805b7e99-8304-4296-a6fa-c7b0d4eec554', N'30', N'Hà Tĩnh', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
GO
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'ff5fcd76-160d-46a0-b4dc-ca98d7903ef0', N'44', N'Bình Dương', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'cab452fb-7e5a-425b-ad3b-cbdd9e4c5ec5', N'07', N'Lai Châu', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'5bad1676-5593-4b79-af80-cd9a1739bdb4', N'10', N'Lạng Sơn', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'8e27702f-f742-4702-a42e-ce083343163a', N'29', N'Nghệ An', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'648cd679-d07b-44c4-8ef6-ce4f45aaad4f', N'43', N'Bình Phước', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'207a629f-6eed-4352-8eb5-d398d72cad67', N'64', N'Hậu Giang', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'026a0896-952b-474d-a27c-d77647d6dc1c', N'57', N'Vĩnh Long', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'b134a219-51b7-4903-ac2c-d852b18a5e34', N'38', N'Gia Lai', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'76e4aec4-23ca-4696-98d3-d8a5c8b15b30', N'49', N'Long An', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'2467dcd2-bf39-4a22-8bee-d97d33408f41', N'35', N'Quảng Ngãi', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'56ee4087-9b4b-41c8-965f-da43f3fedc21', N'27', N'Ninh Bình', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'96a73764-84c1-48f4-b510-dcdb72007acf', N'60', N'Bạc Liêu', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'07fa8f5e-2c90-441d-97f8-dd024ed93222', N'61', N'Cà Mau', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'0edc32d6-5ed9-43f1-a165-df6b1d175d67', N'35', N'Quảng Ngãi', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'13d7b10d-a50b-48b7-8b26-e117cfa7ad42', N'37', N'Bình Định', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'792fb57d-c109-4c56-8240-e2940bb723c9', N'03', N'Hải Phòng', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'f8147816-2225-43a6-8662-e3770fc549bd', N'62', N'Điện Biên', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'53a568c0-2ae3-461e-9588-e9b8f821a01c', N'09', N'Tuyên Quang', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'082902cd-ff38-4ff1-a3df-eda0218ad6c7', N'58', N'Trà Vinh', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'df7d8bde-ae40-4740-9886-f00c66369582', N'06', N'Cao Bằng', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'36d607e5-3d4a-41c6-85f1-f101a555c654', N'39', N'Phú Yên', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'1e382657-b8b7-41ca-b49e-f3a9d114794c', N'01', N'Hà Nội', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'894ff4fc-9b5d-4101-9502-f3d8e6bac796', N'52', N'Bà Rịa - Vũng Tàu', NULL, 1, 0, N'47eca693-a55d-4be2-9e0c-30c80f290a57', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'd3b03a88-e912-409d-ba98-f46022c21d1c', N'26', N'Thái Bình', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'89952828-32e3-4b69-9d02-f58dc73fe1b1', N'23', N'Hoà Bình', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'bc3f764b-f6f8-4f35-8774-f610c308c501', N'04', N'Đà Nẵng', NULL, 1, 0, N'265a50a8-2d71-48fc-8ac2-94bfbac6051e', CAST(0x0000A38C017EBB1E AS DateTime))
INSERT [dbo].[Tinhthanh] ([TinhthanhId], [Code], [TenTinhthanh], [Ghichu], [Active], [Step], [KhuvucId], [NgayCapnhat]) VALUES (N'58a665e3-85d3-4dd0-b01d-f7a5ddcb2114', N'19', N'Bắc Ninh', NULL, 1, 0, N'0020988d-7765-45b0-8378-f5427a7a4dfe', CAST(0x0000A38C017E3B59 AS DateTime))
INSERT [dbo].[Tinhtrang] ([TinhtrangId], [Code], [TenTinhtrang], [Ghichu], [Active], [NgayCapnhat], [Step], [CanDelete]) VALUES (N'7abe17ab-59af-4e02-9cb5-193cdde3b73a', N'TTPX003', N'Hủy', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[Tinhtrang] ([TinhtrangId], [Code], [TenTinhtrang], [Ghichu], [Active], [NgayCapnhat], [Step], [CanDelete]) VALUES (N'ef7be974-3559-4725-b749-27becfdb4164', N'Test', N'Test', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Tinhtrang] ([TinhtrangId], [Code], [TenTinhtrang], [Ghichu], [Active], [NgayCapnhat], [Step], [CanDelete]) VALUES (N'52ff5061-4571-4b1d-91be-5a39e1c7004b', N'TTDH06', N'Chốt', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Tinhtrang] ([TinhtrangId], [Code], [TenTinhtrang], [Ghichu], [Active], [NgayCapnhat], [Step], [CanDelete]) VALUES (N'8e699c8f-011b-401b-acd6-89126f85caea', N'TTPX001', N'Đã lập', NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Tinhtrang] ([TinhtrangId], [Code], [TenTinhtrang], [Ghichu], [Active], [NgayCapnhat], [Step], [CanDelete]) VALUES (N'df0c5a40-ce43-4c77-8188-c48b7e679c1c', N'TTDH01', N'Đã lập', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[Tinhtrang] ([TinhtrangId], [Code], [TenTinhtrang], [Ghichu], [Active], [NgayCapnhat], [Step], [CanDelete]) VALUES (N'dd3df484-5d41-4db5-a62b-c78a7930612d', N'TTDH03', N'Hủy', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[Tinhtrang] ([TinhtrangId], [Code], [TenTinhtrang], [Ghichu], [Active], [NgayCapnhat], [Step], [CanDelete]) VALUES (N'd7b23481-b371-46dc-8d76-ca010774b42b', N'TTPX002', N'Chốt', NULL, 1, NULL, NULL, 1)
INSERT [dbo].[Tinhtrang] ([TinhtrangId], [Code], [TenTinhtrang], [Ghichu], [Active], [NgayCapnhat], [Step], [CanDelete]) VALUES (N'055ac5df-a0d4-473d-bc8b-d33997ec45e0', N'TTPN01', N'Đã lập', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[TinhtrangPhieuxuat] ([TinhtrangPhieuxuatId], [PhieuxuatId], [TinhtrangId], [NgayCapnhat], [NhanvienCapnhatId], [GhichuLydo]) VALUES (N'b4826e9d-cc0e-4ecb-9727-92a27fe96446', N'8e699c8f-011b-401b-acd6-89126f85caea', N'ef7be974-3559-4725-b749-27becfdb4164', CAST(0x0000A3E200F0BBE8 AS DateTime), N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', NULL)
INSERT [dbo].[TinhtrangPhieuxuat] ([TinhtrangPhieuxuatId], [PhieuxuatId], [TinhtrangId], [NgayCapnhat], [NhanvienCapnhatId], [GhichuLydo]) VALUES (N'e50ad465-e90a-4ec3-80da-ab1086092ad2', N'227ffa18-12eb-4cae-8047-2c6183054ed0', N'ef7be974-3559-4725-b749-27becfdb4164', CAST(0x0000A3EB00B1E7DE AS DateTime), NULL, NULL)
INSERT [dbo].[Tonkho] ([TonkhoId], [HanghoaId], [KhoId], [Ngay], [Thang], [Nam], [NgayCapnhat], [GioCapnhat], [SoduDauky], [SoluongNhap], [SoluongXuat], [SoluongTon], [NhanvienCapnhat], [Step], [Active], [SoluongTonDukien], [ThanhtienNhap], [ThanhtienXuat]) VALUES (N'cc2c2718-ed4c-45e1-97db-2c4cc8c64c0a', N'cc2c2718-ed4c-45e1-97db-2c4cc8c64c0a', N'86b518ed-982a-43bf-b8f0-1f34c1bb341d', NULL, NULL, NULL, CAST(0x0000A3E900B63424 AS DateTime), NULL, 100, NULL, NULL, 100, NULL, NULL, 1, 100, NULL, NULL)
INSERT [dbo].[Tonkho] ([TonkhoId], [HanghoaId], [KhoId], [Ngay], [Thang], [Nam], [NgayCapnhat], [GioCapnhat], [SoduDauky], [SoluongNhap], [SoluongXuat], [SoluongTon], [NhanvienCapnhat], [Step], [Active], [SoluongTonDukien], [ThanhtienNhap], [ThanhtienXuat]) VALUES (N'dc6b1358-1871-49c3-956d-4d8d14cb38dc', N'dc6b1358-1871-49c3-956d-4d8d14cb38dc', N'86b518ed-982a-43bf-b8f0-1f34c1bb341d', NULL, NULL, NULL, CAST(0x0000A3E900B63424 AS DateTime), NULL, 200, NULL, NULL, 200, NULL, NULL, 1, 200, NULL, NULL)
INSERT [dbo].[Tonkho] ([TonkhoId], [HanghoaId], [KhoId], [Ngay], [Thang], [Nam], [NgayCapnhat], [GioCapnhat], [SoduDauky], [SoluongNhap], [SoluongXuat], [SoluongTon], [NhanvienCapnhat], [Step], [Active], [SoluongTonDukien], [ThanhtienNhap], [ThanhtienXuat]) VALUES (N'c86e681a-30d7-4f1d-8634-8a509bc7d837', N'cc2c2718-ed4c-45e1-97db-2c4cc8c64c0a', N'86b518ed-982a-43bf-b8f0-1f34c1bb341d', 6, 1, 2015, CAST(0x0000A41801540288 AS DateTime), CAST(0x0000A41801540288 AS DateTime), 100, 0, 3, 100, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', NULL, 1, 97, NULL, 60000)
INSERT [dbo].[Tonkho] ([TonkhoId], [HanghoaId], [KhoId], [Ngay], [Thang], [Nam], [NgayCapnhat], [GioCapnhat], [SoduDauky], [SoluongNhap], [SoluongXuat], [SoluongTon], [NhanvienCapnhat], [Step], [Active], [SoluongTonDukien], [ThanhtienNhap], [ThanhtienXuat]) VALUES (N'63d1e454-5511-4061-90a0-ad155a29986e', N'dc6b1358-1871-49c3-956d-4d8d14cb38dc', N'86b518ed-982a-43bf-b8f0-1f34c1bb341d', 6, 1, 2015, CAST(0x0000A418015402A4 AS DateTime), CAST(0x0000A418015402A4 AS DateTime), 200, 0, 1, 200, N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', NULL, 1, 199, NULL, 0)
INSERT [dbo].[User] ([UserId], [_Username], [_Password], [NhanvienId], [Active], [Step]) VALUES (N'3ce4f27c-40ae-49cf-9157-a926d279ac34', N'08a4415e9d594ff960030b921d42b91e', N'8fa14cdd754f91cc6554c9e71929cce7', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', 1, NULL)
INSERT [dbo].[User] ([UserId], [_Username], [_Password], [NhanvienId], [Active], [Step]) VALUES (N'8388c725-faed-451b-8d86-e196c3b52350', N'5bbd9309a81809aab0298d3c105d8fce', N'5bbd9309a81809aab0298d3c105d8fce', N'12419f4a-fb9b-48aa-8843-137cbbc61e7e', 1, 0)
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Quanhuyen_Unique_Code]    Script Date: 06/04/2015 12:46:30 PM ******/
ALTER TABLE [dbo].[Quanhuyen] ADD  CONSTRAINT [IX_Quanhuyen_Unique_Code] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_AccountId]  DEFAULT (newid()) FOR [AccountId]
GO
ALTER TABLE [dbo].[ChitietDonhang] ADD  CONSTRAINT [DF_ChitietDonhang_ChitietDonhangId]  DEFAULT (newid()) FOR [ChitietDonhangId]
GO
ALTER TABLE [dbo].[ChitietDonhang] ADD  CONSTRAINT [DF_ChitietDonhang_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[ChitietPhieunhap] ADD  CONSTRAINT [DF_ChitietPhieunhap_ChitietPhieunhapId]  DEFAULT (newid()) FOR [ChitietPhieunhapId]
GO
ALTER TABLE [dbo].[ChitietPhieunhap] ADD  CONSTRAINT [DF_ChitietPhieunhap_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[ChitietPhieuxuat] ADD  CONSTRAINT [DF_ChitietPhieuxuat_ChitietPhieuxuatId]  DEFAULT (newid()) FOR [ChitietPhieuxuatId]
GO
ALTER TABLE [dbo].[ChitietPhieuxuat] ADD  CONSTRAINT [DF_ChitietPhieuxuat_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[CongnoNhap] ADD  CONSTRAINT [DF_CongnoNhap_CongnoNhapId]  DEFAULT (newid()) FOR [CongnoNhapId]
GO
ALTER TABLE [dbo].[CongnoNhap] ADD  CONSTRAINT [DF_CongnoNhap_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[CongnoXuat] ADD  CONSTRAINT [DF_CongnoXuat_CongnoXuatId]  DEFAULT (newid()) FOR [CongnoXuatId]
GO
ALTER TABLE [dbo].[CongnoXuat] ADD  CONSTRAINT [DF_CongnoXuat_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Dongia] ADD  CONSTRAINT [DF_Dongia_DongiaId]  DEFAULT (newid()) FOR [DongiaId]
GO
ALTER TABLE [dbo].[Dongia] ADD  CONSTRAINT [DF_Dongia_CapnhatMoinhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[Dongia] ADD  CONSTRAINT [DF_Dongia_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Dongia] ADD  CONSTRAINT [DF_Dongia_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Donhang] ADD  CONSTRAINT [DF_Donhang_DonhangId]  DEFAULT (newid()) FOR [DonhangId]
GO
ALTER TABLE [dbo].[Donhang] ADD  CONSTRAINT [DF_Donhang_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Donvi] ADD  CONSTRAINT [DF_Donvi_DonviId]  DEFAULT (newid()) FOR [DonviId]
GO
ALTER TABLE [dbo].[Donvi] ADD  CONSTRAINT [DF_Donvi_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Donvi] ADD  CONSTRAINT [DF_Donvi_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Donvi] ADD  CONSTRAINT [DF_Donvi_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[Hanghoa] ADD  CONSTRAINT [DF_Hanghoa_HanghoaId]  DEFAULT (newid()) FOR [HanghoaId]
GO
ALTER TABLE [dbo].[Hanghoa] ADD  CONSTRAINT [DF_Hanghoa_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Hanghoa] ADD  CONSTRAINT [DF_Hanghoa_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Hanghoa] ADD  CONSTRAINT [DF_Hanghoa_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[HanghoaNhaCungcap] ADD  CONSTRAINT [DF_HanghoaNhaCungcap_HanghoaNhaCungcapId]  DEFAULT (newid()) FOR [HanghoaNhaCungcapId]
GO
ALTER TABLE [dbo].[Khachhang] ADD  CONSTRAINT [DF_Khachhang_KhachhangId]  DEFAULT (newid()) FOR [KhachhangId]
GO
ALTER TABLE [dbo].[Khachhang] ADD  CONSTRAINT [DF_Khachhang_Gioitinh]  DEFAULT ((1)) FOR [Gioitinh]
GO
ALTER TABLE [dbo].[Khachhang] ADD  CONSTRAINT [DF_Khachhang_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[Khachhang] ADD  CONSTRAINT [DF_Khachhang_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Khachhang] ADD  CONSTRAINT [DF_Khachhang_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Kho] ADD  CONSTRAINT [DF_Kho_KhoId]  DEFAULT (newid()) FOR [KhoId]
GO
ALTER TABLE [dbo].[Kho] ADD  CONSTRAINT [DF_Kho_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[Kho] ADD  CONSTRAINT [DF_Kho_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Kho] ADD  CONSTRAINT [DF_Kho_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Khuvuc] ADD  CONSTRAINT [DF_Khuvuc_KhuvucId]  DEFAULT (newid()) FOR [KhuvucId]
GO
ALTER TABLE [dbo].[Khuvuc] ADD  CONSTRAINT [DF_Khuvuc_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Khuvuc] ADD  CONSTRAINT [DF_Khuvuc_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Khuvuc] ADD  CONSTRAINT [DF_Khuvuc_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[LoHanghoa] ADD  CONSTRAINT [DF_LoHanghoa_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[LoHanghoa] ADD  CONSTRAINT [DF_LoHanghoa_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[LoHanghoa] ADD  CONSTRAINT [DF_LoHanghoa_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[NguyennhanLydo] ADD  CONSTRAINT [DF_NguyennhanLydo_NguyennhanLydoId]  DEFAULT (newid()) FOR [NguyennhanLydoId]
GO
ALTER TABLE [dbo].[NhaCungcap] ADD  CONSTRAINT [DF_NhaCungcap_NhaCungcapId]  DEFAULT (newid()) FOR [NhaCungcapId]
GO
ALTER TABLE [dbo].[NhaCungcap] ADD  CONSTRAINT [DF_NhaCungcap_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[NhaCungcap] ADD  CONSTRAINT [DF_NhaCungcap_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[NhaCungcap] ADD  CONSTRAINT [DF_NhaCungcap_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[Nhanvien] ADD  CONSTRAINT [DF_Nhanvien_NhanvienId]  DEFAULT (newid()) FOR [NhanvienId]
GO
ALTER TABLE [dbo].[Nhanvien] ADD  CONSTRAINT [DF_Nhanvien_NgayBatdau]  DEFAULT (getdate()) FOR [NgayBatdau]
GO
ALTER TABLE [dbo].[Nhanvien] ADD  CONSTRAINT [DF_Nhanvien_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[Nhanvien] ADD  CONSTRAINT [DF_Nhanvien_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Nhanvien] ADD  CONSTRAINT [DF_Nhanvien_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[NhanvienKho] ADD  CONSTRAINT [DF_NhanvienKho_NhanvienKhoId]  DEFAULT (newid()) FOR [NhanvienKhoId]
GO
ALTER TABLE [dbo].[NhanvienKho] ADD  CONSTRAINT [DF_NhanvienKho_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[NhomHanghoa] ADD  CONSTRAINT [DF_NhomHanghoa_NhomHanghoaId]  DEFAULT (newid()) FOR [NhomHanghoaId]
GO
ALTER TABLE [dbo].[NhomHanghoa] ADD  CONSTRAINT [DF_NhomHanghoa_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[NhomHanghoa] ADD  CONSTRAINT [DF_NhomHanghoa_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[NhomHanghoa] ADD  CONSTRAINT [DF_NhomHanghoa_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[NhomKhachhang] ADD  CONSTRAINT [DF_NhomKhachhang_NhomKhachhangId]  DEFAULT (newid()) FOR [NhomKhachhangId]
GO
ALTER TABLE [dbo].[NhomKhachhang] ADD  CONSTRAINT [DF_NhomKhachhang_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[NhomKhachhang] ADD  CONSTRAINT [DF_NhomKhachhang_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[NhomKhachhang] ADD  CONSTRAINT [DF_NhomKhachhang_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[Phieunhap] ADD  CONSTRAINT [DF_Phieunhap_PhieunhapId]  DEFAULT (newid()) FOR [PhieunhapId]
GO
ALTER TABLE [dbo].[Phieunhap] ADD  CONSTRAINT [DF_Phieunhap_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Phieuxuat] ADD  CONSTRAINT [DF_Phieuxuat_PhieuxuatId]  DEFAULT (newid()) FOR [PhieuxuatId]
GO
ALTER TABLE [dbo].[Phieuxuat] ADD  CONSTRAINT [DF_Phieuxuat_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Quanhuyen] ADD  CONSTRAINT [DF_Quanhuyen_QuanhuyenId]  DEFAULT (newid()) FOR [QuanhuyenId]
GO
ALTER TABLE [dbo].[Quanhuyen] ADD  CONSTRAINT [DF_Quanhuyen_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Quanhuyen] ADD  CONSTRAINT [DF_Quanhuyen_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Quanhuyen] ADD  CONSTRAINT [DF_Quanhuyen_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[Thuchi] ADD  CONSTRAINT [DF_Thuchi_ThuchiId]  DEFAULT (newid()) FOR [ThuchiId]
GO
ALTER TABLE [dbo].[Thuchi] ADD  CONSTRAINT [DF_Thuchi_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[ThuoctinhHanghoa] ADD  CONSTRAINT [DF_ThuoctinhHanghoa_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ThuoctinhHanghoa] ADD  CONSTRAINT [DF_ThuoctinhHanghoa_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[ThuoctinhHanghoa] ADD  CONSTRAINT [DF_Kichthuoc_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[Tinhthanh] ADD  CONSTRAINT [DF_Tinhthanh_TinhthanhId]  DEFAULT (newid()) FOR [TinhthanhId]
GO
ALTER TABLE [dbo].[Tinhthanh] ADD  CONSTRAINT [DF_Tinhthanh_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Tinhthanh] ADD  CONSTRAINT [DF_Tinhthanh_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[Tinhthanh] ADD  CONSTRAINT [DF_Tinhthanh_NgayCapnhat]  DEFAULT (getdate()) FOR [NgayCapnhat]
GO
ALTER TABLE [dbo].[Tinhtrang] ADD  CONSTRAINT [DF_Tinhtrang_TinhtrangId]  DEFAULT (newid()) FOR [TinhtrangId]
GO
ALTER TABLE [dbo].[Tinhtrang] ADD  CONSTRAINT [DF_Tinhtrang_CanDelete]  DEFAULT ((1)) FOR [CanDelete]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User__UserId]  DEFAULT (newid()) FOR [UserId]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_Step]  DEFAULT ((0)) FOR [Step]
GO
ALTER TABLE [dbo].[ChitietDonhang]  WITH CHECK ADD  CONSTRAINT [FK_ChitietDonhang_Donhang] FOREIGN KEY([DonhangId])
REFERENCES [dbo].[Donhang] ([DonhangId])
GO
ALTER TABLE [dbo].[ChitietDonhang] CHECK CONSTRAINT [FK_ChitietDonhang_Donhang]
GO
ALTER TABLE [dbo].[ChitietDonhang]  WITH CHECK ADD  CONSTRAINT [FK_ChitietDonhang_Hanghoa] FOREIGN KEY([HanghoaId])
REFERENCES [dbo].[Hanghoa] ([HanghoaId])
GO
ALTER TABLE [dbo].[ChitietDonhang] CHECK CONSTRAINT [FK_ChitietDonhang_Hanghoa]
GO
ALTER TABLE [dbo].[ChitietPhieunhap]  WITH CHECK ADD  CONSTRAINT [FK_ChitietPhieunhap_Hanghoa] FOREIGN KEY([HanghoaId])
REFERENCES [dbo].[Hanghoa] ([HanghoaId])
GO
ALTER TABLE [dbo].[ChitietPhieunhap] CHECK CONSTRAINT [FK_ChitietPhieunhap_Hanghoa]
GO
ALTER TABLE [dbo].[ChitietPhieunhap]  WITH CHECK ADD  CONSTRAINT [FK_ChitietPhieunhap_Phieunhap] FOREIGN KEY([PhieunhapId])
REFERENCES [dbo].[Phieunhap] ([PhieunhapId])
GO
ALTER TABLE [dbo].[ChitietPhieunhap] CHECK CONSTRAINT [FK_ChitietPhieunhap_Phieunhap]
GO
ALTER TABLE [dbo].[ChitietPhieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_ChitietPhieuxuat_Hanghoa] FOREIGN KEY([HanghoaId])
REFERENCES [dbo].[Hanghoa] ([HanghoaId])
GO
ALTER TABLE [dbo].[ChitietPhieuxuat] CHECK CONSTRAINT [FK_ChitietPhieuxuat_Hanghoa]
GO
ALTER TABLE [dbo].[ChitietPhieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_ChitietPhieuxuat_Phieuxuat] FOREIGN KEY([PhieuxuatId])
REFERENCES [dbo].[Phieuxuat] ([PhieuxuatId])
GO
ALTER TABLE [dbo].[ChitietPhieuxuat] CHECK CONSTRAINT [FK_ChitietPhieuxuat_Phieuxuat]
GO
ALTER TABLE [dbo].[CongnoNhap]  WITH CHECK ADD  CONSTRAINT [FK_CongnoNhap_NhaCungcap] FOREIGN KEY([NhaCungcapId])
REFERENCES [dbo].[NhaCungcap] ([NhaCungcapId])
GO
ALTER TABLE [dbo].[CongnoNhap] CHECK CONSTRAINT [FK_CongnoNhap_NhaCungcap]
GO
ALTER TABLE [dbo].[CongnoNhap]  WITH CHECK ADD  CONSTRAINT [FK_CongnoNhap_Nhanvien] FOREIGN KEY([NhanvienId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[CongnoNhap] CHECK CONSTRAINT [FK_CongnoNhap_Nhanvien]
GO
ALTER TABLE [dbo].[CongnoXuat]  WITH CHECK ADD  CONSTRAINT [FK_CongnoXuat_Khachhang] FOREIGN KEY([KhachhangId])
REFERENCES [dbo].[Khachhang] ([KhachhangId])
GO
ALTER TABLE [dbo].[CongnoXuat] CHECK CONSTRAINT [FK_CongnoXuat_Khachhang]
GO
ALTER TABLE [dbo].[CongnoXuat]  WITH CHECK ADD  CONSTRAINT [FK_CongnoXuat_Nhanvien] FOREIGN KEY([NhanvienId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[CongnoXuat] CHECK CONSTRAINT [FK_CongnoXuat_Nhanvien]
GO
ALTER TABLE [dbo].[Dongia]  WITH CHECK ADD  CONSTRAINT [FK_Dongia_Hanghoa] FOREIGN KEY([HanghoaId])
REFERENCES [dbo].[Hanghoa] ([HanghoaId])
GO
ALTER TABLE [dbo].[Dongia] CHECK CONSTRAINT [FK_Dongia_Hanghoa]
GO
ALTER TABLE [dbo].[Dongia]  WITH CHECK ADD  CONSTRAINT [FK_Dongia_NhomKhachhang] FOREIGN KEY([NhomKhachhangId])
REFERENCES [dbo].[NhomKhachhang] ([NhomKhachhangId])
GO
ALTER TABLE [dbo].[Dongia] CHECK CONSTRAINT [FK_Dongia_NhomKhachhang]
GO
ALTER TABLE [dbo].[Donhang]  WITH CHECK ADD  CONSTRAINT [FK_Donhang_Khachhang] FOREIGN KEY([KhachhangId])
REFERENCES [dbo].[Khachhang] ([KhachhangId])
GO
ALTER TABLE [dbo].[Donhang] CHECK CONSTRAINT [FK_Donhang_Khachhang]
GO
ALTER TABLE [dbo].[Donhang]  WITH CHECK ADD  CONSTRAINT [FK_Donhang_Kho] FOREIGN KEY([KhoId])
REFERENCES [dbo].[Kho] ([KhoId])
GO
ALTER TABLE [dbo].[Donhang] CHECK CONSTRAINT [FK_Donhang_Kho]
GO
ALTER TABLE [dbo].[Donhang]  WITH CHECK ADD  CONSTRAINT [FK_Donhang_Nhanvien] FOREIGN KEY([NhanvienId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[Donhang] CHECK CONSTRAINT [FK_Donhang_Nhanvien]
GO
ALTER TABLE [dbo].[Donhang]  WITH CHECK ADD  CONSTRAINT [FK_Donhang_Nhanvien1] FOREIGN KEY([NhanvienCapnhatId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[Donhang] CHECK CONSTRAINT [FK_Donhang_Nhanvien1]
GO
ALTER TABLE [dbo].[Hanghoa]  WITH CHECK ADD  CONSTRAINT [FK_Hanghoa_Donvi] FOREIGN KEY([DonviId])
REFERENCES [dbo].[Donvi] ([DonviId])
GO
ALTER TABLE [dbo].[Hanghoa] CHECK CONSTRAINT [FK_Hanghoa_Donvi]
GO
ALTER TABLE [dbo].[Hanghoa]  WITH CHECK ADD  CONSTRAINT [FK_Hanghoa_NhomHanghoa] FOREIGN KEY([NhomHanghoaId])
REFERENCES [dbo].[NhomHanghoa] ([NhomHanghoaId])
GO
ALTER TABLE [dbo].[Hanghoa] CHECK CONSTRAINT [FK_Hanghoa_NhomHanghoa]
GO
ALTER TABLE [dbo].[HanghoaNhaCungcap]  WITH CHECK ADD  CONSTRAINT [FK_HanghoaNhaCungcap_Hanghoa] FOREIGN KEY([HanghoaId])
REFERENCES [dbo].[Hanghoa] ([HanghoaId])
GO
ALTER TABLE [dbo].[HanghoaNhaCungcap] CHECK CONSTRAINT [FK_HanghoaNhaCungcap_Hanghoa]
GO
ALTER TABLE [dbo].[HanghoaNhaCungcap]  WITH CHECK ADD  CONSTRAINT [FK_HanghoaNhaCungcap_NhaCungcap] FOREIGN KEY([NhaCungcapId])
REFERENCES [dbo].[NhaCungcap] ([NhaCungcapId])
GO
ALTER TABLE [dbo].[HanghoaNhaCungcap] CHECK CONSTRAINT [FK_HanghoaNhaCungcap_NhaCungcap]
GO
ALTER TABLE [dbo].[Khachhang]  WITH CHECK ADD  CONSTRAINT [FK_Khachhang_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([AccountId])
GO
ALTER TABLE [dbo].[Khachhang] CHECK CONSTRAINT [FK_Khachhang_Account]
GO
ALTER TABLE [dbo].[Khachhang]  WITH CHECK ADD  CONSTRAINT [FK_Khachhang_NhomKhachhang1] FOREIGN KEY([NhomKhachhangId])
REFERENCES [dbo].[NhomKhachhang] ([NhomKhachhangId])
GO
ALTER TABLE [dbo].[Khachhang] CHECK CONSTRAINT [FK_Khachhang_NhomKhachhang1]
GO
ALTER TABLE [dbo].[Khachhang]  WITH CHECK ADD  CONSTRAINT [FK_Khachhang_Quanhuyen] FOREIGN KEY([QuanhuyenId])
REFERENCES [dbo].[Quanhuyen] ([QuanhuyenId])
GO
ALTER TABLE [dbo].[Khachhang] CHECK CONSTRAINT [FK_Khachhang_Quanhuyen]
GO
ALTER TABLE [dbo].[Khachhang]  WITH CHECK ADD  CONSTRAINT [FK_Khachhang_Tinhthanh] FOREIGN KEY([TinhthanhId])
REFERENCES [dbo].[Tinhthanh] ([TinhthanhId])
GO
ALTER TABLE [dbo].[Khachhang] CHECK CONSTRAINT [FK_Khachhang_Tinhthanh]
GO
ALTER TABLE [dbo].[Kho]  WITH CHECK ADD  CONSTRAINT [FK_Kho_Quanhuyen] FOREIGN KEY([QuanhuyenId])
REFERENCES [dbo].[Quanhuyen] ([QuanhuyenId])
GO
ALTER TABLE [dbo].[Kho] CHECK CONSTRAINT [FK_Kho_Quanhuyen]
GO
ALTER TABLE [dbo].[Kho]  WITH CHECK ADD  CONSTRAINT [FK_Kho_Tinhthanh] FOREIGN KEY([TinhthanhId])
REFERENCES [dbo].[Tinhthanh] ([TinhthanhId])
GO
ALTER TABLE [dbo].[Kho] CHECK CONSTRAINT [FK_Kho_Tinhthanh]
GO
ALTER TABLE [dbo].[LoHanghoa]  WITH CHECK ADD  CONSTRAINT [FK_LoHanghoa_Hanghoa] FOREIGN KEY([HanghoaId])
REFERENCES [dbo].[Hanghoa] ([HanghoaId])
GO
ALTER TABLE [dbo].[LoHanghoa] CHECK CONSTRAINT [FK_LoHanghoa_Hanghoa]
GO
ALTER TABLE [dbo].[LoHanghoa]  WITH CHECK ADD  CONSTRAINT [FK_LoHanghoa_Kho] FOREIGN KEY([KhoId])
REFERENCES [dbo].[Kho] ([KhoId])
GO
ALTER TABLE [dbo].[LoHanghoa] CHECK CONSTRAINT [FK_LoHanghoa_Kho]
GO
ALTER TABLE [dbo].[LoHanghoa]  WITH CHECK ADD  CONSTRAINT [FK_LoHanghoa_Nhanvien] FOREIGN KEY([NhanvienCapnhat])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[LoHanghoa] CHECK CONSTRAINT [FK_LoHanghoa_Nhanvien]
GO
ALTER TABLE [dbo].[NhaCungcap]  WITH CHECK ADD  CONSTRAINT [FK_NhaCungcap_Quanhuyen] FOREIGN KEY([QuanhuyenId])
REFERENCES [dbo].[Quanhuyen] ([QuanhuyenId])
GO
ALTER TABLE [dbo].[NhaCungcap] CHECK CONSTRAINT [FK_NhaCungcap_Quanhuyen]
GO
ALTER TABLE [dbo].[NhaCungcap]  WITH CHECK ADD  CONSTRAINT [FK_NhaCungcap_Tinhthanh] FOREIGN KEY([TinhthanhId])
REFERENCES [dbo].[Tinhthanh] ([TinhthanhId])
GO
ALTER TABLE [dbo].[NhaCungcap] CHECK CONSTRAINT [FK_NhaCungcap_Tinhthanh]
GO
ALTER TABLE [dbo].[Nhanvien]  WITH CHECK ADD  CONSTRAINT [FK_Nhanvien_Phongban] FOREIGN KEY([PhongbanId])
REFERENCES [dbo].[Phongban] ([PhongbanId])
GO
ALTER TABLE [dbo].[Nhanvien] CHECK CONSTRAINT [FK_Nhanvien_Phongban]
GO
ALTER TABLE [dbo].[Nhanvien]  WITH CHECK ADD  CONSTRAINT [FK_Nhanvien_Quanhuyen] FOREIGN KEY([QuanhuyenId])
REFERENCES [dbo].[Quanhuyen] ([QuanhuyenId])
GO
ALTER TABLE [dbo].[Nhanvien] CHECK CONSTRAINT [FK_Nhanvien_Quanhuyen]
GO
ALTER TABLE [dbo].[Nhanvien]  WITH CHECK ADD  CONSTRAINT [FK_Nhanvien_Tinhthanh] FOREIGN KEY([TinhthanhId])
REFERENCES [dbo].[Tinhthanh] ([TinhthanhId])
GO
ALTER TABLE [dbo].[Nhanvien] CHECK CONSTRAINT [FK_Nhanvien_Tinhthanh]
GO
ALTER TABLE [dbo].[NhanvienKho]  WITH CHECK ADD  CONSTRAINT [FK_NhanvienKho_Kho] FOREIGN KEY([KhoId])
REFERENCES [dbo].[Kho] ([KhoId])
GO
ALTER TABLE [dbo].[NhanvienKho] CHECK CONSTRAINT [FK_NhanvienKho_Kho]
GO
ALTER TABLE [dbo].[NhanvienKho]  WITH CHECK ADD  CONSTRAINT [FK_NhanvienKho_Nhanvien] FOREIGN KEY([NhanvienId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[NhanvienKho] CHECK CONSTRAINT [FK_NhanvienKho_Nhanvien]
GO
ALTER TABLE [dbo].[Phieunhap]  WITH CHECK ADD  CONSTRAINT [FK_Phieunhap_Kho] FOREIGN KEY([KhoId])
REFERENCES [dbo].[Kho] ([KhoId])
GO
ALTER TABLE [dbo].[Phieunhap] CHECK CONSTRAINT [FK_Phieunhap_Kho]
GO
ALTER TABLE [dbo].[Phieunhap]  WITH CHECK ADD  CONSTRAINT [FK_Phieunhap_NguyennhanLydo] FOREIGN KEY([NguyennhanLydo])
REFERENCES [dbo].[NguyennhanLydo] ([NguyennhanLydoId])
GO
ALTER TABLE [dbo].[Phieunhap] CHECK CONSTRAINT [FK_Phieunhap_NguyennhanLydo]
GO
ALTER TABLE [dbo].[Phieunhap]  WITH CHECK ADD  CONSTRAINT [FK_Phieunhap_NhaCungcap] FOREIGN KEY([NhacungcapId])
REFERENCES [dbo].[NhaCungcap] ([NhaCungcapId])
GO
ALTER TABLE [dbo].[Phieunhap] CHECK CONSTRAINT [FK_Phieunhap_NhaCungcap]
GO
ALTER TABLE [dbo].[Phieunhap]  WITH CHECK ADD  CONSTRAINT [FK_Phieunhap_Nhanvien] FOREIGN KEY([NhanvienId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[Phieunhap] CHECK CONSTRAINT [FK_Phieunhap_Nhanvien]
GO
ALTER TABLE [dbo].[Phieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_Phieuxuat_Donhang] FOREIGN KEY([DonhangId])
REFERENCES [dbo].[Donhang] ([DonhangId])
GO
ALTER TABLE [dbo].[Phieuxuat] CHECK CONSTRAINT [FK_Phieuxuat_Donhang]
GO
ALTER TABLE [dbo].[Phieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_Phieuxuat_Kho] FOREIGN KEY([KhoId])
REFERENCES [dbo].[Kho] ([KhoId])
GO
ALTER TABLE [dbo].[Phieuxuat] CHECK CONSTRAINT [FK_Phieuxuat_Kho]
GO
ALTER TABLE [dbo].[Phieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_Phieuxuat_NguyennhanLydo] FOREIGN KEY([NguyennhanLydo])
REFERENCES [dbo].[NguyennhanLydo] ([NguyennhanLydoId])
GO
ALTER TABLE [dbo].[Phieuxuat] CHECK CONSTRAINT [FK_Phieuxuat_NguyennhanLydo]
GO
ALTER TABLE [dbo].[Phieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_Phieuxuat_Nhanvien] FOREIGN KEY([NhanvienDonhang])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[Phieuxuat] CHECK CONSTRAINT [FK_Phieuxuat_Nhanvien]
GO
ALTER TABLE [dbo].[Phieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_Phieuxuat_Nhanvien3] FOREIGN KEY([NhanvienLapId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[Phieuxuat] CHECK CONSTRAINT [FK_Phieuxuat_Nhanvien3]
GO
ALTER TABLE [dbo].[Phieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_Phieuxuat_Nhanvien4] FOREIGN KEY([NhanvienGiaohangId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[Phieuxuat] CHECK CONSTRAINT [FK_Phieuxuat_Nhanvien4]
GO
ALTER TABLE [dbo].[Quanhuyen]  WITH CHECK ADD  CONSTRAINT [FK_Quanhuyen_Tinhthanh] FOREIGN KEY([TinhthanhId])
REFERENCES [dbo].[Tinhthanh] ([TinhthanhId])
GO
ALTER TABLE [dbo].[Quanhuyen] CHECK CONSTRAINT [FK_Quanhuyen_Tinhthanh]
GO
ALTER TABLE [dbo].[Thuchi]  WITH CHECK ADD  CONSTRAINT [FK_Thuchi_Nhanvien] FOREIGN KEY([NhanvienId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[Thuchi] CHECK CONSTRAINT [FK_Thuchi_Nhanvien]
GO
ALTER TABLE [dbo].[Thuchi]  WITH CHECK ADD  CONSTRAINT [FK_Thuchi_Phieunhap] FOREIGN KEY([PhieunhapId])
REFERENCES [dbo].[Phieunhap] ([PhieunhapId])
GO
ALTER TABLE [dbo].[Thuchi] CHECK CONSTRAINT [FK_Thuchi_Phieunhap]
GO
ALTER TABLE [dbo].[Thuchi]  WITH CHECK ADD  CONSTRAINT [FK_Thuchi_Phieuxuat] FOREIGN KEY([PhieuxuatId])
REFERENCES [dbo].[Phieuxuat] ([PhieuxuatId])
GO
ALTER TABLE [dbo].[Thuchi] CHECK CONSTRAINT [FK_Thuchi_Phieuxuat]
GO
ALTER TABLE [dbo].[ThuoctinhHanghoa]  WITH CHECK ADD  CONSTRAINT [FK_ThuoctinhHanghoa_Hanghoa] FOREIGN KEY([HanghoaId])
REFERENCES [dbo].[Hanghoa] ([HanghoaId])
GO
ALTER TABLE [dbo].[ThuoctinhHanghoa] CHECK CONSTRAINT [FK_ThuoctinhHanghoa_Hanghoa]
GO
ALTER TABLE [dbo].[Tinhthanh]  WITH CHECK ADD  CONSTRAINT [FK_Tinhthanh_Khuvuc] FOREIGN KEY([KhuvucId])
REFERENCES [dbo].[Khuvuc] ([KhuvucId])
GO
ALTER TABLE [dbo].[Tinhthanh] CHECK CONSTRAINT [FK_Tinhthanh_Khuvuc]
GO
ALTER TABLE [dbo].[TinhtrangDonhang]  WITH CHECK ADD  CONSTRAINT [FK_TinhtrangDonhang_Donhang] FOREIGN KEY([DonhangId])
REFERENCES [dbo].[Donhang] ([DonhangId])
GO
ALTER TABLE [dbo].[TinhtrangDonhang] CHECK CONSTRAINT [FK_TinhtrangDonhang_Donhang]
GO
ALTER TABLE [dbo].[TinhtrangDonhang]  WITH CHECK ADD  CONSTRAINT [FK_TinhtrangDonhang_Nhanvien] FOREIGN KEY([NhanvienCapnhatId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[TinhtrangDonhang] CHECK CONSTRAINT [FK_TinhtrangDonhang_Nhanvien]
GO
ALTER TABLE [dbo].[TinhtrangDonhang]  WITH CHECK ADD  CONSTRAINT [FK_TinhtrangDonhang_Tinhtrang] FOREIGN KEY([PhieuxuatId])
REFERENCES [dbo].[Tinhtrang] ([TinhtrangId])
GO
ALTER TABLE [dbo].[TinhtrangDonhang] CHECK CONSTRAINT [FK_TinhtrangDonhang_Tinhtrang]
GO
ALTER TABLE [dbo].[TinhtrangPhieunhap]  WITH CHECK ADD  CONSTRAINT [FK_TinhtrangPhieunhap_Nhanvien] FOREIGN KEY([NhanvienCapnhat])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[TinhtrangPhieunhap] CHECK CONSTRAINT [FK_TinhtrangPhieunhap_Nhanvien]
GO
ALTER TABLE [dbo].[TinhtrangPhieunhap]  WITH CHECK ADD  CONSTRAINT [FK_TinhtrangPhieunhap_Phieunhap] FOREIGN KEY([PhieunhapId])
REFERENCES [dbo].[Phieunhap] ([PhieunhapId])
GO
ALTER TABLE [dbo].[TinhtrangPhieunhap] CHECK CONSTRAINT [FK_TinhtrangPhieunhap_Phieunhap]
GO
ALTER TABLE [dbo].[TinhtrangPhieunhap]  WITH CHECK ADD  CONSTRAINT [FK_TinhtrangPhieunhap_Tinhtrang] FOREIGN KEY([TinhtrangId])
REFERENCES [dbo].[Tinhtrang] ([TinhtrangId])
GO
ALTER TABLE [dbo].[TinhtrangPhieunhap] CHECK CONSTRAINT [FK_TinhtrangPhieunhap_Tinhtrang]
GO
ALTER TABLE [dbo].[TinhtrangPhieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_TinhtrangPhieuxuat_Nhanvien] FOREIGN KEY([NhanvienCapnhatId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[TinhtrangPhieuxuat] CHECK CONSTRAINT [FK_TinhtrangPhieuxuat_Nhanvien]
GO
ALTER TABLE [dbo].[TinhtrangPhieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_TinhtrangPhieuxuat_Phieuxuat] FOREIGN KEY([PhieuxuatId])
REFERENCES [dbo].[Phieuxuat] ([PhieuxuatId])
GO
ALTER TABLE [dbo].[TinhtrangPhieuxuat] CHECK CONSTRAINT [FK_TinhtrangPhieuxuat_Phieuxuat]
GO
ALTER TABLE [dbo].[TinhtrangPhieuxuat]  WITH CHECK ADD  CONSTRAINT [FK_TinhtrangPhieuxuat_Tinhtrang] FOREIGN KEY([TinhtrangId])
REFERENCES [dbo].[Tinhtrang] ([TinhtrangId])
GO
ALTER TABLE [dbo].[TinhtrangPhieuxuat] CHECK CONSTRAINT [FK_TinhtrangPhieuxuat_Tinhtrang]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Nhanvien] FOREIGN KEY([NhanvienId])
REFERENCES [dbo].[Nhanvien] ([NhanvienId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Nhanvien]
GO
USE [master]
GO
ALTER DATABASE [QLBH_08_2014] SET  READ_WRITE 
GO
