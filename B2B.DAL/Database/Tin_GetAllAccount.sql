use QLBH_08_2014
go
create proc Tin_GetAllAccount
as
begin 

	(select a.AccountId as AcountId, a.AccountName as AccountName, a.AccountPassword as AccountPassword,b.KhachhangId as UserId, b.HotenKhachhang  as Ten, b.Email as Email,b.Mobile as Mobile
	from Account a inner join Khachhang b on a.AccountId=b.AccountId
	where a.Active=1)
	union
	(select a.AccountId as AcountId, a.AccountName as AccountName, a.AccountPassword as AccountPassword,b.NhanvienId as UserId, b.HovatenNhanvien  as Ten, b.Email as Email, b.Mobile as Mobile
	from Account a inner join Nhanvien b on a.AccountId=b.AccountId 
	where a.Active=1)

end;