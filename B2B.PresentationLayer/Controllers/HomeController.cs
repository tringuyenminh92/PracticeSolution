using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Message = "Modify this template to jump-start your ASP.NET MVC application.";

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult New()
        {
            ViewBag.Message = "Your new page.";

            return View();
        }

        public ActionResult SignUp()
        {
            return View();
        }
        public ActionResult ChangePassword()
        {
            return View();
        }



        public Boolean CheckSignUp( string user, string pass)
        {
            if(user.Equals("vinh") )
            { return true; }
            return false;
            
            //return Json(new { username= "anh", pass="anh" });
        }

    }
}
