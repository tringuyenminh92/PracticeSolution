using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class AccountRepository
    {
        B2BSystemEntities dbContext;
        public AccountRepository()
        {
            dbContext = new B2BSystemEntities();
        }
        public Account GetAccount(String accountName)
        {
            //.Where(u => u.C_Username == username)
            return dbContext.Accounts.AsQueryable<Account>().Where(u => u.AccountName == accountName).FirstOrDefault<Account>();
        }
        public bool CheckAccountNameExist(Account account)
        {
            Account acc = dbContext.Accounts.AsQueryable<Account>().Where(u => u.AccountName == account.AccountName).FirstOrDefault<Account>();
            if (acc != null)
            {
                return true;
            }
            else return false;
        }
        public bool Insert(Account account)
        {
            try
            {
                dbContext.Accounts.Add(account);
                dbContext.SaveChanges();
                return true;
            }
            catch (System.Exception ex)
            {
                return false;
            }
        }
        public bool Update(Account account)
        {
            try
            {
                //dbContext.Accounts.Attach(account);
                //dbContext.Entry(account).State = System.Data.EntityState.Modified;
                //dbContext.SaveChanges();
                Account acc = dbContext.Accounts.Single(a => a.AccountName == account.AccountName);
                acc = account;
                dbContext.SaveChanges();
                return true;
            }
            catch (System.Exception ex)
            {
                return false;
            }
        }
    }
}
