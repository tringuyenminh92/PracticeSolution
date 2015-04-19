using B2B.BL.Service;
using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class DonhangController : Controller
    {
        //
        // GET: /Donhang/
        DonhangService _donhangService;
        ChitietDonhangService _chitietDonhangService;
        HanghoaService _hanghoaService;
        public DonhangController()
        {
            _donhangService = new DonhangService();
            _chitietDonhangService = new ChitietDonhangService();
            _hanghoaService = new HanghoaService();
        }
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult GetHanghoasByMonth(string ngaylap,int loaiDonhang)
        {
            var ngay = DateTime.Parse(ngaylap);
            return Json(null, JsonRequestBehavior.AllowGet);
        }
        public JsonResult LoadDonhang()
        {
            return Json(_donhangService.GetDonhang(), JsonRequestBehavior.AllowGet);
        }
        public JsonResult LoadChitietDonhangTheoDonhang(string donhangId)
        {
            List<ChitietDonhangModel> lstChitietHanghoa = new List<ChitietDonhangModel>();
            if (donhangId != null)
            {
                lstChitietHanghoa = _chitietDonhangService.GetChitietDonhangTheoDonhang(donhangId);
                for(int i=0; i<lstChitietHanghoa.Count; ++i)
                {
                    var hanghoa = _hanghoaService.GetHanghoaTheoHanghoaId(lstChitietHanghoa[i].HanghoaId.ToString());
                    lstChitietHanghoa[i].LinkHinhanh_Web = hanghoa.LinkHinhanh_Web;
                    lstChitietHanghoa[i].Code = hanghoa.Code;
                }
            }
            return Json(lstChitietHanghoa, JsonRequestBehavior.AllowGet);
        }

    }
}
