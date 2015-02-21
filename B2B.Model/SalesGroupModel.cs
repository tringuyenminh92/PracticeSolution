using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace B2B.Model
{
    public class SalesGroupModel
    {

        public SalesGroupModel()
        {
            subCategoryeModel = new SubCategoryeModel();
        }
        public string SalesGroupName { get; set; }
        public int SalesGroupID { get; set; }
        public SubCategoryeModel subCategoryeModel { get; set; }
    }

    public class SubCategoryeModel
    {
        public int Sub_CategoryId { get; set; }
        public string Sub_CategoryName { get; set; }
        public int Sales_GroupId { get; set; }
        public string Description { get; set; }
    }
}
