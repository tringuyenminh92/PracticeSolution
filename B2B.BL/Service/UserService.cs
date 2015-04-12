using AutoMapper;
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
            try
            {
                //Get all the Piping Material
                Mapper.CreateMap<Tin_GetAllAccount_Result, AccountModel>()
                .ForMember(dest => dest.AccountId, opt => opt.MapFrom(src => src.AcountId))
                .ForMember(dest => dest.AccountName, opt => opt.MapFrom(src => src.AccountName))
                .ForMember(dest => dest.AccountPassword, opt => opt.MapFrom(src => src.AccountPassword))
                .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.UserId))
                .ForMember(dest => dest.Ten, opt => opt.MapFrom(src => src.Ten))
                .ForMember(dest => dest.Email, opt => opt.MapFrom(src => src.Email))
                .ForMember(dest => dest.Mobile, opt => opt.MapFrom(src => src.Mobile));

                var rs = respository.GetAllAccount();
                return Mapper.Map<List<Tin_GetAllAccount_Result>, List<AccountModel>>(rs);

            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
