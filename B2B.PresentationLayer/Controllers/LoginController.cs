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
        public JsonResult CheckLogin(string user, string password)
        {
            bool kq = false;
            //var u=new UserModel{_Username="user", _Password="password"};
            UserModel rs = new UserModel();
            rs = loguser.CheckLogin(user, password).FirstOrDefault();
            if (rs != null)
            {
                kq = true;
                Session["UserId"] = rs.UserId;
            }
            return Json(new { result = kq });
        }

    }
}
