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
    
    public partial class SP_SelectQuotes_Result
    {
        public int auto { get; set; }
        public string Quote_Number { get; set; }
        public short Quote_Revision { get; set; }
        public System.DateTime quote_expectedorder_date { get; set; }
        public Nullable<System.DateTime> quote_rec_date { get; set; }
        public Nullable<System.DateTime> quote_due_date { get; set; }
        public Nullable<System.DateTime> quote_issued_date { get; set; }
        public Nullable<int> sales_office { get; set; }
        public Nullable<int> sales_group { get; set; }
        public string cust_name { get; set; }
        public string cust_sap_number { get; set; }
        public string contact_salutation { get; set; }
        public string contact_fname { get; set; }
        public string contact_lname { get; set; }
        public string contact_telbus { get; set; }
        public string contact_telmobile { get; set; }
        public string contact_telfax { get; set; }
        public string contact_email { get; set; }
        public string description { get; set; }
        public string CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public string SalesOfficeName { get; set; }
        public string SalesGroupName { get; set; }
        public string Reason { get; set; }
        public string ReasonDetails { get; set; }
        public string OrderStatus { get; set; }
        public Nullable<int> LineItemIncrement { get; set; }
        public Nullable<int> TechPositionIncrement { get; set; }
        public Nullable<int> Sale_Engineer { get; set; }
        public string SalesEngineer { get; set; }
        public Nullable<int> Application_Engineer { get; set; }
        public string ApplicationEngineer { get; set; }
        public Nullable<int> Cost_Approver { get; set; }
        public string CostApprover { get; set; }
        public Nullable<int> Sell_Price_Approver { get; set; }
        public string SellPriceApprover { get; set; }
        public Nullable<int> Additional_SP_Approver { get; set; }
        public string AdditionalSPApprover { get; set; }
        public Nullable<int> StatusId { get; set; }
        public string StatusName { get; set; }
        public Nullable<double> est_price { get; set; }
        public Nullable<double> QuotedPrice { get; set; }
    }
}
