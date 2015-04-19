using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.DAL.Repository
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    namespace B2B.DAL
    {
        public class TinhtrangDonhangRepository
        {
            B2BSystemEntities dbContext;
            public TinhtrangDonhangRepository()
            {
                dbContext = new B2BSystemEntities();
            }
            public bool Insert(TinhtrangDonhang tinhtrangDonhang)
            {
                try
                {
                    dbContext.TinhtrangDonhangs.Add(tinhtrangDonhang);
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
}
