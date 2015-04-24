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
        ThuoctinhHanghoaService _thuoctinhHanghoaService;
        public DonhangController()
        {
            _donhangService = new DonhangService();
            _chitietDonhangService = new ChitietDonhangService();
            _hanghoaService = new HanghoaService();
            _thuoctinhHanghoaService = new ThuoctinhHanghoaService();
        }
        public ActionResult Index()
        {
            return View();
        }
        public JsonResult GetNgaylapDonhangDautien()
        {
            DateTime? nl = _donhangService.GetNgaylapDonhangDautien();
            string ngaylapdautien = "";
            if(nl!=null)
            {
                string ngay = "";
                if (nl.Value.Day < 10) ngay = ngay + "0" + nl.Value.Day;
                else ngay = ngay + nl.Value.Day;

                string thang = "";
                if (nl.Value.Month < 10) thang = thang + "0" + nl.Value.Month;
                else thang = thang + nl.Value.Month;

                ngaylapdautien = nl.Value.Year + "-" + thang + "-" + ngay;
            }
            return Json(new { ngaylapdautien = ngaylapdautien }, JsonRequestBehavior.AllowGet);
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
                    lstChitietHanghoa[i].ThuoctinhHanghoaItems = _thuoctinhHanghoaService.GetThuoctinhHanghoaTheoHanghoa(lstChitietHanghoa[i].HanghoaId.ToString());
                }
            }
            return Json(lstChitietHanghoa, JsonRequestBehavior.AllowGet);
        }

    }
}
