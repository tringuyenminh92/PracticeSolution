using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using B2B.DAL.Repository;
using B2B.Model;
using AutoMapper;
using B2B.DAL;

namespace B2B.BL.Service
{
    public class AccountService
    {
        AccountRepository repository;
        public AccountService()
        {
            repository = new AccountRepository();
        }
        public bool CheckAccountNameExist(AccountModel account)
        {
            Mapper.CreateMap<AccountModel, Account>();
            Account acc = Mapper.Map<AccountModel, Account>(account);
            return repository.CheckAccountNameExist(acc);
        }
        public AccountModel GetAccount(string accountId)
        {
            Mapper.CreateMap<Account, AccountModel>();
            var acc = repository.GetAccount(accountId);
            return Mapper.Map<Account, AccountModel>(acc);
        }
        public bool Insert(AccountModel account)
        {
            Mapper.CreateMap<AccountModel, Account>();
            Account acc = Mapper.Map<AccountModel, Account>(account);
            return repository.Insert(acc);
        }
        public bool Update(AccountModel account)
        {
            Mapper.CreateMap<AccountModel, Account>();
            Account acc = Mapper.Map<AccountModel, Account>(account);
            return repository.Update(acc);

        }
    }
}
