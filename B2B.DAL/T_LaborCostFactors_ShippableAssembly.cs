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
    
    public partial class T_LaborCostFactors_ShippableAssembly
    {
        public int Id { get; set; }
        public int ShippableAssemblyId { get; set; }
        public int LaborCostFactorId { get; set; }
        public double Value { get; set; }
    
        public virtual T_LaborCostFactors T_LaborCostFactors { get; set; }
        public virtual T_ShippableAssembly T_ShippableAssembly { get; set; }
    }
}
