using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using B2B.Model;
using B2B.BL.Service;

namespace B2B.PresentationLayer.Controllers
{
    public class LoginController : Controller
    {
        //
        // GET: /Login/
        LoginService loguser = new LoginService();
        public ActionResult Index()
        {
            return View();
        }
        //public JsonResult CheckLogin(string user, string password)
        //{
        //    string username = "user"; string pass = "password";


        //    bool kq = false;
        //    if (user == username && pass == password)
        //    {
        //        kq = true;
        //        Session["user"] = username;
        //    }
        //    return Json(new { result = kq });
        //}
        public JsonResult CheckLoginUser(string account, string password)
        {
            bool kq = false;
            AccountModel rs = new AccountModel();
            rs = loguser.CheckLogin(account, password);
            if (rs != null)
            {
                kq = true;
                Session["accountId"] = rs.AccountId;
                Session["accountName"] = rs.AccountName;
                Session["TypeAccount"] = rs.TypeAccount;
            }
            return Json(new { result = kq });

        }
    }
}
