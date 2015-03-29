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
        UserResponsitory responsitory;

        public UserService()
        {
            responsitory = new UserResponsitory();
        }

        public AccountModel getUser(string username)
        {
            Mapper.CreateMap<Account, AccountModel>();
            var a = responsitory.GetUser(username);
            return Mapper.Map<Account, AccountModel>(a);
        }

        public int UpdatePassword(AccountModel model)
        {
            Mapper.CreateMap<AccountModel, Account>();
            Account account = Mapper.Map<AccountModel, Account>(model);
            return responsitory.UpdatePassword(account);

        }
    }
}
