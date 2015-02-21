using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace B2B.Model
{
    public class QuoteSectionModel
    {
        public QuoteSectionModel()
        {
        }

        public QuoteSectionModel(int quoteId)
        {
            QuoteSectionOverviewTree = new QuoteSectionOverview(quoteId);
        }

        public int auto { get; set; }
        public int QN { get; set; }
        public int SN { get; set; }

        public string section { get; set; }
        public string descr { get; set; }
        public double DefaultPartMargin { get; set; }

        public double section_markup { get; set; }
        public string part_number { get; set; }
        public string sap_descr { get; set; }
        public string revision { get; set; }
        public double section_cost { get; set; }
        public double sect_net_cost { get; set; }
        public int qty { get; set; }
        public decimal plantadministration { get; set; }
        public string manufacturingcost { get; set; }
        public string sga { get; set; }
        public string riskfactor { get; set; }
        public string RiskFactorPercentage { get; set; }
        public string SGAPercentage { get; set; }
        public string sellprice { get; set; }
        public string labor_tot { get; set; }
        public string commission { get; set; }
        public string materialoverhead { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public int SectionOrder { get; set; }

        public QuoteSectionOverview QuoteSectionOverviewTree { get; set; }

    }
}
