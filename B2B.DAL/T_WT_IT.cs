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
    
    public partial class T_WT_IT
    {
        public T_WT_IT()
        {
            this.T_WT_ChangeRequestTag = new HashSet<T_WT_ChangeRequestTag>();
        }
    
        public int IT_ID { get; set; }
        public Nullable<int> Module_ID { get; set; }
        public string IT_Name { get; set; }
        public string IT_Description { get; set; }
        public Nullable<int> Project_ID { get; set; }
    
        public virtual T_WT_Project T_WT_Project { get; set; }
        public virtual ICollection<T_WT_ChangeRequestTag> T_WT_ChangeRequestTag { get; set; }
    }
}
