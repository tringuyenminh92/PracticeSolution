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
        public bool Insert(AccountModel account)
        {
            Mapper.CreateMap<AccountModel, Account>();
            Account acc = Mapper.Map<AccountModel, Account>(account);
            return repository.Insert(acc);
        }
    }
}
