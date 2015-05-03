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
    
    public partial class Item
    {
        public Item()
        {
            this.RoleRights = new HashSet<RoleRight>();
        }
    
        public System.Guid ItemId { get; set; }
        public Nullable<System.Guid> ItemChaId { get; set; }
        public string Thutu { get; set; }
        public string TypeName { get; set; }
        public string ObjectTypeName { get; set; }
        public string Name { get; set; }
        public string Text { get; set; }
        public byte[] Image { get; set; }
        public byte[] LargeImage { get; set; }
        public Nullable<bool> IsLarge { get; set; }
        public Nullable<int> Width { get; set; }
        public Nullable<bool> ShowImage { get; set; }
        public Nullable<bool> ShowFormAsTab { get; set; }
        public string TenForm { get; set; }
        public string TenFileDLL { get; set; }
        public int Cap { get; set; }
        public Nullable<bool> Enable { get; set; }
        public Nullable<bool> Visible { get; set; }
        public Nullable<bool> Lock { get; set; }
        public bool Allow { get; set; }
        public bool BeginGroup { get; set; }
        public Nullable<System.Guid> GroupItemId { get; set; }
    
        public virtual GroupItem GroupItem { get; set; }
        public virtual ICollection<RoleRight> RoleRights { get; set; }
    }
}
