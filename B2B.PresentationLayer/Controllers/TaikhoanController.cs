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
        AccountService _accountService;
        KhachhangService _khachhangService;

        public TaikhoanController() 
        { 
            _tinhthanhService = new TinhthanhService();
            _quanhuyenService = new QuanhuyenService();
            _accountService = new AccountService();
            _khachhangService = new KhachhangService();
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
        public JsonResult XulyDangky(KhachhangModel khachhang, AccountModel account)
        {
            if(_accountService.Insert(account))
            {
                khachhang.AccountId = account.AccountId;
                if(_khachhangService.Insert(khachhang))
                {
                    return Json(new { thongbao = "Đăng ký thành công", kq = true }, JsonRequestBehavior.AllowGet);
                }
            }
            return Json(new { thongbao = "Đăng ký không thành công", kq = false }, JsonRequestBehavior.AllowGet);
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
