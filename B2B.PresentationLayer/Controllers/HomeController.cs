using B2B.BL.Service;
using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class HomeController : Controller
    {
        NhomHanghoaService nhomHanghoaService;
        HanghoaService hanghoaService;
        public HomeController()
        {
            nhomHanghoaService = new NhomHanghoaService();
            hanghoaService = new HanghoaService();
        }
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



        public Boolean CheckSignUp(string user, string pass)
        {
            if (user.Equals("vinh"))
            { return true; }
            return false;

            //return Json(new { username= "anh", pass="anh" });
        }

        public String CheckChangePassword(string user)
        {
            string s = user;
            if (user.Equals("vinh"))
            { return s; }
            return s;
        }


        public ActionResult MenuDropdown()
        {
            return View();
        }

        public JsonResult LoadData()
        {
            List<NhomHanghoaModel> NhomHanghoaItems = nhomHanghoaService.GetAllNhomHanghoa();
            return Json(NhomHanghoaItems);
        }

        [HttpGet]
        public JsonResult GetGridHanghoas()
        {
            List<HanghoaModel> HanghoaItems = hanghoaService.GetAllHanghoa();
            return Json(HanghoaItems, JsonRequestBehavior.AllowGet);
            //return Json(new[] { new { name = "Nguyen van a", tuoi = 12 }, new { name = "be bao bao", tuoi = 45 } }, JsonRequestBehavior.AllowGet);
        }
    }
}
