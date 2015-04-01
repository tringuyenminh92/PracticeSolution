using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class UserModel
    {
        private Guid _UserId;

        public Guid UserId
        {
            get { return _UserId; }
            set { _UserId = value; }
        }
        private Nullable<Guid> _NhanvienId;

        public Nullable<Guid> NhanvienId
        {
            get { return _NhanvienId; }
            set { _NhanvienId = value; }
        }
        private Nullable<Int32> _Step;

        public Nullable<Int32> Step
        {
            get { return _Step; }
            set { _Step = value; }
        }
        private Nullable<Boolean> _Active;

        public Nullable<Boolean> Active
        {
            get { return _Active; }
            set { _Active = value; }
        }
        private Byte[] _Version;

        public Byte[] Version
        {
            get { return _Version; }
            set { _Version = value; }
        }
        private String __Username;

        public String _Username
        {
            get { return __Username; }
            set { __Username = value; }
        }
        private String __Password;

        public String _Password
        {
            get { return __Password; }
            set { __Password = value; }
        }

    }
}
