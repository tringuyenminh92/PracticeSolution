//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace B2B.DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class T_PipingSchemMapping
    {
        public int ID { get; set; }
        public int Piping_Id { get; set; }
        public string Units { get; set; }
        public string Material { get; set; }
        public string Joint { get; set; }
        public string Size { get; set; }
        public string Schedule { get; set; }
        public string Schem_Symbol { get; set; }
        public string Schem_Component { get; set; }
        public Nullable<bool> IsSelected { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public string Conduit { get; set; }
    }
}
