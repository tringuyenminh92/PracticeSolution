USE [QLBH_08_2014]
GO

alter Proc [dbo].[Tin_CheckLogin] 
@accountname nvarchar(250), @accountpassword nvarchar(250)
as
begin
	SELECT [AccountId]
      ,[AccountName]
      ,[AccountPassword]
	  ,[TypeAccount]
  FROM [QLBH_08_2014].[dbo].[Account]
  WHERE ([AccountName]=@accountname AND [AccountPassword]=@accountpassword)
end