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
        public IEnumerable<AccountModel> GetAllAccount()
        {
            Mapper.CreateMap<Tin_GetAllAccount_Result, AccountModel>();
            var rs = respository.GetAllAccount();
            return Mapper.Map<IQueryable<Tin_GetAllAccount_Result>, IEnumerable<AccountModel>>(rs);
        }
    }
}
