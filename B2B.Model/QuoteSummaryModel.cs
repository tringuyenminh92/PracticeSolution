using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace B2B.Model
{
    public class QuoteSummaryModel
    {
        public QuoteSummaryModel()
        {
            SectionList = new List<QuoteSectionModel>();
        }

        public List<QuoteSectionModel> SectionList { get; set; }

        public double LaborCost { get; set; }
        public double PlantAdministration { get; set; }
        public double SGA { get; set; }
        public double RiskFactor { get; set; }
        public double ManufacturingCost { get; set; }

        public int QuoteId { get; set; }
        public string CustomerName { get; set; }
        public string Contact { get; set; }
        public string PhoneNumber { get; set; }
        public string Description { get; set; }
        public double FinalSalePrice { get; set; }

        public string QuoteStatus { get; set; }

        public string Approver { get; set; }
        public string ApproverComments { get; set; }

        public QuotesModel QuotesList { get; set; }


        public string DistributionChannel { get; set; } 

        public string Type { get; set; } 

        public string DistributionChannelName { get; set; }
        public string TypeName { get; set; }

        public string SellPriceApprover { get; set; }

        public string AddSellPriceApprover { get; set; }

        public string CostAppName { get; set; }
        public string CostAppNTID { get; set; }

        [DisplayFormat(DataFormatString = "{0:d}")]
        public DateTime CA_Action_Date { get; set; }

        public string CA_Comment { get; set; }

        public string SellPriceAppName { get; set; }
        public string SellPriceAppNTID { get; set; }

        [DisplayFormat(DataFormatString = "{0:d}")]
        public DateTime SPA_Action_Date { get; set; }

        public string SPA_Comment { get; set; }

        public string AddSellPriceAppName { get; set; }
        public string AddSellPriceAppNTID { get; set; }

        [DisplayFormat(DataFormatString = "{0:d}")]
        public DateTime ASPA_Action_Date { get; set; }

        public string ASPA_Comment { get; set; }

        public int Application_Engineer { get; set; }
        public string AppEngName { get; set; }
        public string AppEngNTID { get; set; }

        public int Sale_Engineer { get; set; }
        public string SaleEngName { get; set; }
        public string SalesEngNTID { get; set; }

        public int Approval_Levels { get; set; }
        public string StatusName { get; set; }

        public string IsPMEffort { get; set; }
        public double PMEffort { get; set; }
        public double PMFactorValue { get; set; }
        public double PMconvertedValue { get; set; }
        public string IsCommission { get; set; }
        public double Commission { get; set; }

    }

    public class DistributionChannelModel
    {
        public int FieldValueId { get; set; }
        public int FieldId { get; set; }
        public string FieldValueName { get; set; }
        public string FieldValueDescription { get; set; }
        public int FieldValueNameId { get; set; }
    }

    public class PMCommissionModel
    {
        public string PMRequired { get; set; }
        public double PMEffort { get; set; }
        public string CommissionRequired { get; set; }
        public double Commission { get; set; }
    }

    public class ApproverModel
    {
        public int Quote_UserId { get; set; }
        public int Quote_auto { get; set; }
        public int Application_Engineer { get; set; }
        public int Sale_Engineer { get; set; }
        public int Distribution_Channel { get; set; }
        public int Type { get; set; }
        public int Cost_Approver { get; set; }
        public DateTime CA_Action_Date { get; set; }
        public string CA_Comment { get; set; }
        public int Sell_Price_Approver { get; set; }
        public DateTime SPA_Action_Date { get; set; }
        public string SPA_Comment { get; set; }
        public int Additional_SP_Approver { get; set; }
        public DateTime ASPA_Action_Date { get; set; }
        public string ASPA_Comment { get; set; }
        public int Approval_Levels { get; set; }
        public string StatusName { get; set; }

        public string AppEngName { get; set; }
        public string SaleEngName { get; set; }
        public string CostAppName { get; set; }
        public string SellPriceAppName { get; set; }
        public string AddSellPriceAppName { get; set; }

        public string DistributionChannelName { get; set; }
        public string TypeName { get; set; }

        public string AppEngNTID { get; set; }
        public string SalesEngNTID { get; set; }
        public string CostAppNTID { get; set; }
        public string SellPriceAppNTID { get; set; }
        public string AddSellPriceAppNTID { get; set; }

        public string IsPMEffort { get; set; }
        public double PMEffort { get; set; }
        public double PMFactorValue { get; set; }
        public double PMconvertedValue { get; set; }
        public string IsCommission { get; set; }
        public double Commission { get; set; }

        public string CustomerName { get; set; }
    }
}


