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
        LoginService loguser = new LoginService();
        public ActionResult Dangnhap()
        {
            return View();
        }
        public JsonResult CheckLoginUser(string account, string password)
        {
            bool kq = false;
            AccountModel rs = new AccountModel();
            rs = loguser.CheckLogin(account, password);
            if (rs != null)
            {
                kq = true;
                Session["accountId"] = rs.AccountId;
            }
            return Json(new { result = kq });

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
        public JsonResult HienthiTinhthanh()
        {
            return Json(_tinhthanhService.GetTinhthanhActive(), JsonRequestBehavior.AllowGet);
        }
        public JsonResult HienthiQuanhuyen(string tinhthanhId)
        {
            return Json(_quanhuyenService.GetQuanhuyenActiveTheoTinhthanh(tinhthanhId), JsonRequestBehavior.AllowGet);
        }
        public JsonResult HienthiQuanhuyenFull()
        {
            return Json(_quanhuyenService.GetQuanhuyenActive(), JsonRequestBehavior.AllowGet);
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
            var kq = _khachhangService.Update(khachhang);
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
    }
}
