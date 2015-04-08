using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.Model
{
    public class LoaiDonhangModel
    {
        public int LoaiDonhangValue { get; set; }

        public string TenLoaiDonhang { get; set; }

        public static List<LoaiDonhangModel> listLoaiDonhang = new List<LoaiDonhangModel>()
        {
            new LoaiDonhangModel { LoaiDonhangValue = 0, TenLoaiDonhang = "PreSales" },
            new LoaiDonhangModel { LoaiDonhangValue = 1, TenLoaiDonhang = "VanSales" }
        };

        private static Dictionary<int, string> listNhom = new Dictionary<int, string>()
        {
            { 0, "PreSales" },
            { 1, "VanSales" }
        };
        public static string GetTenLoaiDonhang(int value)
        {
            string kq = "";
            if (listNhom.TryGetValue(value, out kq))
            {
                return kq;
            }
            return "";
        }
    }
}
