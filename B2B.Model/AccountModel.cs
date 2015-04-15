using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public partial class AccountModel
    {
        public Guid AccountId { get; set; }
        public String AccountName { get; set; }
        public String AccountPassword { get; set; }
        public bool Active { get; set; }
        public AccountModel() { AccountId = Guid.NewGuid(); }
    }
}
