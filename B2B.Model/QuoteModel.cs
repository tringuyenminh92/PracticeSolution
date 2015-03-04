using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace B2B.Model
{
    public class QuotesModel
    {
        //Khuyen - test
        public int? auto { get; set; }

        public string Quote_number { get; set; }

        public string quoterName { get; set; }  

        public string quoter { get; set; }

        public DateTime? quote_expectedorder_date { get; set; }

        public DateTime? quote_rec_date { get; set; }

        public DateTime? quote_due_date { get; set; }

        public DateTime? quote_issued_date { get; set; }

        public int? sales_office { get; set; }
        public int? sales_group { get; set; }

        public string cust_name { get; set; }

        public string cust_street { get; set; }

        public string cust_city { get; set; }

        public string cust_zip { get; set; }

        public string cust_state { get; set; }
        public string cust_country { get; set; }
        public string cust_sap_number { get; set; }
        public string contact_salutation { get; set; }
        public string contact_fname { get; set; }
        public string contact_lname { get; set; }

        public string contact_telbus { get; set; }

        public string contact_telmobile { get; set; }

        public string contact_telfax { get; set; }

        public string contact_email { get; set; }

        public string SalesOrderNumber { get; set; }

        public string description { get; set; }

        public double est_price { get; set; }

        public string est_price1 { get; set; }

        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public int? LineItemIncrement { get; set; }
        public int? TechPositionIncrement { get; set; }

        public string Approver { get; set; }

        public string Status { get; set; }
        public string SalesOfficeName { get; set; }
        public string SalesGroupName { get; set; }
        public string ApproverComments { get; set; }
        public QuoteSectionOverview SectionOverview { get; set; }
        public SalesOfficeModel SalesOffice { get; set; }
        public SalesGroupModel SalesGroup { get; set; }
        public QuoteSummaryModel QuoteSummary { get; set; }
        public bool AllowCreate { get; set; }
        public bool AllowEdit { get; set; }
        public string Reason { get; set; }
        public string ReasonDetails { get; set; }
        public string OrderStatus { get; set; }

        public Int16 Quote_Revision { get; set; }
        public bool ApplEngg_NA { get; set; }
        public string ApplEngg_Comments { get; set; }

        public string Application_Engg { get; set; }

        public int? Application_Engineer { get; set; }

        public int Sale_Engineer { get; set; }

        public bool Revision_NA { get; set; }
        public SubCategoryeModel SubCategory { get; set; }
        public int? Sub_CategoryId { get; set; }

        public int DistributorId { get; set; }

        public string SalesEngineer { get; set; }
        public string ApplicationEngineer { get; set; }
        public string CostApprover { get; set; }
        public string SellPriceApprover { get; set; }
        public string AdditionalSPApprover { get; set; }
        public string StatusName { get; set; }
        public int StatusId { get; set; } 
        public int CustomerType { get; set; } 
        public int ProbabilityPO { get; set; }
        public int ProbabilityEOD { get; set; }

        public string OEM_cust_name { get; set; }

        public string OEM_cust_street { get; set; }

        public string OEM_cust_city { get; set; }

        public string OEM_cust_zip { get; set; }

        public string OEM_cust_state { get; set; }

        public string OEM_cust_country { get; set; }

        public double? QuotedPrice { get; set; }
    }

    public class QuoteSectionOverview
    {
        public QuoteSectionOverview(int quoteId)
        {
            QuoteSectionList = new List<QuoteSection>();
            QuoteId = quoteId;
        }
        public int QuoteId { get; set; }
        public List<QuoteSection> QuoteSectionList { get; set; }
    }

    public class QuoteSection
    {
        public QuoteSection()
        {
            SubAssemblyList = new List<QuoteSubAssembly>();
        }

        public int SectionOrder { get; set; }
        public int SectionNumber { get; set; }
        public long SectionId { get; set; }
        public string ShippableAssemblyName { get; set; }
        public string Description { get; set; }
        public double TotalLabor { get; set; }

        public List<QuoteSubAssembly> SubAssemblyList { get; set; }
    }

    public class QuoteSubAssembly
    {
        public int Order { get; set; }
        public long SubAssemblyId { get; set; }
        public string Description { get; set; }
        public string ShippableAssemblyName { get; set; }
        public double TotalLabor { get; set; }
    }

}
