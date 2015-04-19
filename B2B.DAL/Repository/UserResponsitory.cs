using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    public class UserResponsitory
    {
        B2BSystemEntities dbContext;

        public UserResponsitory()
        {
            dbContext = new B2BSystemEntities();
        }

        public Account GetUser(String accountName)
        {
            //.Where(u => u.C_Username == username)
            return dbContext.Accounts.AsQueryable<Account>().Where(u => u.AccountName == accountName).FirstOrDefault<Account>();
        }

        public int UpdatePassword(Account model)
        {
            // 08a4415e9d594ff960030b921d42b91e
            //chưa so sánh id cua account
            //Account account = dbContext.Accounts.Single(a => a.AccountName == model.AccountName);
            //account.Password = model.Password;
            return dbContext.SaveChanges();
        }
        //Get list account
        public IQueryable<Account> GetUser()
        {
            return dbContext.Accounts.AsQueryable();
        }
        public bool DeleteAccount(string accountName)
        {
            if (accountName != null)
            {
                var item = dbContext.Accounts.Where(p => p.AccountName == accountName).FirstOrDefault();
                item.Active = false;
                dbContext.Entry(item).State = EntityState.Modified;
                dbContext.SaveChanges();
                return true;
            }
            return false;
        }
        public List<Tin_GetAllAccount_Result> GetAllAccount()
        {
            //var tam = dbContext.Tin_GetAllAccount().ToList();
            return dbContext.Tin_GetAllAccount().ToList();
        }
    }
}
