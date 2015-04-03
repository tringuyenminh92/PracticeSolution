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
        public ActionResult DoiPassword()
        {
            return View();
        }
        public JsonResult HienthiThongtinTaikhoan(string accountId)
        {
            AccountModel acc = _accountService.GetAccount(accountId);
            KhachhangModel kh = _khachhangService.GetKhachhangFromAccountId(accountId);
            return Json(new { acc, kh }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult XulyDoiPassword(AccountModel account, string passnew)
        {
            //AccountModel model = service.getUser("vinhpham");
            account.AccountPassword = passnew;
            var kq = _accountService.Update(account);
            string thongbao;
            if(kq)
            {
                thongbao = "Đổi password thành công";
            }
            else
            {
                thongbao = "Đổi password không thành công";
            }
            return Json(new { thongbao = thongbao, kq = kq }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult KiemtraAccountName (AccountModel account)
        {
            if(_accountService.CheckAccountNameExist(account))
            {
                return Json(new { thongbao = "Trùng Account", kq = true }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { thongbao = "Ko trùng Account", kq = false }, JsonRequestBehavior.AllowGet);
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
            return Json(_tinhthanhService.GetTinhthanh(), JsonRequestBehavior.AllowGet);
        }
        public JsonResult DisplayQuanhuyen()
        {
            return Json(_quanhuyenService.GetQuanhuyen(), JsonRequestBehavior.AllowGet);
        }
        public JsonResult ThaydoiThongtinDangnhap(AccountModel account)
        {
            var kq = _accountService.Update(account);
            string thongbao;
            if (kq)
            {
                thongbao = "Đổi thông tin thành công";
            }
            else
            {
                thongbao = "Đổi thông tin không thành công";
            }
            return Json(new { thongbao = thongbao, kq = kq }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult ThaydoiThongtinKhachhang(KhachhangModel khachhang)
        {
            var kh = khachhang;
            return Json(true, JsonRequestBehavior.AllowGet);
        }
    }
}
