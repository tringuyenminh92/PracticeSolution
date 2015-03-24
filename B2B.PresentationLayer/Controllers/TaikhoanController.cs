using B2B.BL.Service;
using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class TaikhoanController : Controller
    {
        //
        // GET: /Taikhoan/
        TinhthanhService _tinhthanhService;
        QuanhuyenService _quanhuyenService;

        public TaikhoanController() 
        { 
            _tinhthanhService = new TinhthanhService();
            _quanhuyenService = new QuanhuyenService();
        }
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Dangky()
        {
            return View();
        }
        public ActionResult SuaTaikhoan()
        {
            return View();
        }
        public ActionResult SuaTaikhoan1()
        {
            return View();
        }
        public ActionResult SuaTaikhoan2()
        {
            return View();
        }
        public JsonResult XulyDangky(KhachhangModel account)
        {
            return Json(account.HotenKhachhang, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DisplayTinhthanh()
        {
            return Json(_tinhthanhService.GetTinhthanh().ToList(), JsonRequestBehavior.AllowGet);
        }
        public JsonResult DisplayQuanhuyen()
        {
            return Json(_quanhuyenService.GetQuanhuyen().ToList(), JsonRequestBehavior.AllowGet);
        }
    }
}
