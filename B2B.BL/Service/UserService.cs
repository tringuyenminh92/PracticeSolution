﻿using AutoMapper;
using B2B.DAL;
using B2B.DAL.Repository;
using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.BL.Service
{
    public class UserService
    {
        UserResponsitory respository;

        public UserService()
        {
            respository = new UserResponsitory();
        }

        public AccountModel getUser(string username)
        {
            Mapper.CreateMap<Account, AccountModel>();
            var a = respository.GetUser(username);
            return Mapper.Map<Account, AccountModel>(a);
        }

        public int UpdatePassword(AccountModel model)
        {
            Mapper.CreateMap<AccountModel, Account>();
            Account account = Mapper.Map<AccountModel, Account>(model);
            return respository.UpdatePassword(account);

        }
        public IEnumerable<AccountModel> GetUser()
        {
            Mapper.CreateMap<Account, AccountModel>();
            var rs = respository.GetUser();
            return Mapper.Map<IQueryable<Account>, IEnumerable<AccountModel>>(rs);
        }

        //Delete Account
        public bool DeleteAccount(string accountName)
        {
            return respository.DeleteAccount(accountName);
        }
        //GetAllAccount
        //public List<AccountModel> GetAllAccount()
        //{
        //    Mapper.CreateMap<Tin_GetAllAccount_Result, AccountModel>();
        //    var rs = respository.GetAllAccount();
        //    return Mapper.Map<List<Tin_GetAllAccount_Result>, List<AccountModel>>(rs);
        //}
        //GetAllAcccount Mapper thuoc tinh
        public List<AccountModel> GetAllAccount()
        {
            //try
            //{
            //Get all the Piping Material
            Mapper.CreateMap<Tin_GetAllAccount_Result, AccountModel>()
            .ForMember(dest => dest.AccountId, opt => opt.MapFrom(src => src.AcountId))
            .ForMember(dest => dest.AccountName, opt => opt.MapFrom(src => src.AccountName))
            .ForMember(dest => dest.AccountPassword, opt => opt.MapFrom(src => src.AccountPassword))
            .ForMember(dest => dest.Active, opt => opt.MapFrom(src => src.Active))
            .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.UserId))
            .ForMember(dest => dest.Ten, opt => opt.MapFrom(src => src.Ten))
            .ForMember(dest => dest.Email, opt => opt.MapFrom(src => src.Email))
            .ForMember(dest => dest.Mobile, opt => opt.MapFrom(src => src.Mobile));

            var rs = respository.GetAllAccount();
            return Mapper.Map<List<Tin_GetAllAccount_Result>, List<AccountModel>>(rs);

            //}
            //catch (Exception)
            //{
            //    throw;
            //}
        }
        //SaveAllAccount
        public bool SaveAllAccount(List<AccountModel> listAccount)
        {
            //try
            //{
            if (listAccount != null)
            {
                Mapper.CreateMap<AccountModel, Account>()
                .ForMember(dest => dest.AccountId, opt => opt.MapFrom(src => src.AccountId))
                .ForMember(dest => dest.AccountName, opt => opt.MapFrom(src => src.AccountName))
                .ForMember(dest => dest.Active, opt => opt.MapFrom(src => src.Active))
                .ForMember(dest => dest.AccountPassword, opt => opt.MapFrom(src => src.AccountPassword));
                var rs = Mapper.Map<List<AccountModel>, List<Account>>(listAccount);
                return respository.SaveAllAccount(rs);
            }
            return false;
            //}
            //catch (Exception)
            //{
            //    throw;
            //}
        }
        //___________________Addnew Account
        public bool AddnewAccount(AccountModel ac)
        {
            if (ac != null)
            {
                Mapper.CreateMap<AccountModel, Account>()
                .ForMember(dest => dest.AccountId, opt => opt.MapFrom(src => src.AccountId))
                .ForMember(dest => dest.AccountName, opt => opt.MapFrom(src => src.AccountName))
                .ForMember(dest => dest.Active, opt => opt.MapFrom(src => src.Active))
                .ForMember(dest => dest.AccountPassword, opt => opt.MapFrom(src => src.AccountPassword));
                var rs = Mapper.Map<AccountModel, Account>(ac);
                return respository.AddnewAccount(rs);
            }
            return false;
        }
        //Kiem tra Account User
        public bool CheckAccount(string user)
        {
            return respository.CheckAccount(user);
        }

    }
}
