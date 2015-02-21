using B2B.BL.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class QuoteController : Controller
    {
        //
        // GET: /Quote/

        public ActionResult Index()
        {
            return View();
        }

        public QuoteController()
        {
        }

        [HttpGet]
        public JsonResult GetQuotes()
        {
            //Dictionary<string, object> error = new Dictionary<string, object>();
            //error.Add("ErrorCode", -1);
            //error.Add("ErrorMessage", "Something really bad happened");
            //return Json(error);
            return Json(new[] { new { name = "Nguyen van a", tuoi = 12 }, new { name = "be bao bao", tuoi = 45 } },JsonRequestBehavior.AllowGet);
        }
    }
}