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
    
    public partial class T_Piping_Fitting
    {
        public int PipeFitting_ID { get; set; }
        public Nullable<double> Size_Min { get; set; }
        public Nullable<double> Size_Max { get; set; }
        public Nullable<double> Assembly_hrs { get; set; }
        public Nullable<bool> flgStatus { get; set; }
        public string CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
    }
}
