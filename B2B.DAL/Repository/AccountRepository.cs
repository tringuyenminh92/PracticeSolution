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
                dbContext.Accounts.Attach(account);
                dbContext.Entry(account).State = System.Data.EntityState.Modified;
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
