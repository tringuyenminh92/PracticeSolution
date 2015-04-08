using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class DonhangController : Controller
    {
        //
        // GET: /Donhang/

        public ActionResult Index()
        {
            return View();
        }

        public JsonResult GetHanghoasByMonth(string ngaylap,int loaiDonhang)
        {
            var ngay = DateTime.Parse(ngaylap);
            return Json(null, JsonRequestBehavior.AllowGet);
        }

    }
}
