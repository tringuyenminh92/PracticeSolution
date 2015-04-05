using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class UserController : Controller
    {
        //
        // GET: /User/
        B2B.BL.Service.UserService us = new BL.Service.UserService();

        public ActionResult Index()
        {
            return View();
        }
        public JsonResult GetUser()
        {
            var rs = us.GetUser().ToList();
            return Json(rs,JsonRequestBehavior.AllowGet);
        }

    }
}
