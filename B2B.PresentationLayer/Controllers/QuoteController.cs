using B2B.BL.IService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using B2B.Model;
using System.Text;
using System.IO;

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

        [HttpGet]
        public JsonResult GetQuotes()
        {
            return Json(new[] { new { name = "Nguyen van a", tuoi = 12 }, new { name = "be bao bao", tuoi = 45 } }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult UploadFile(HttpPostedFileBase file)
        {
            if (file == null)
            {
                return Json(null);
            }
            var filename = Path.GetFileName(file.FileName);
            var path = Path.Combine(Server.MapPath("~/Images"), filename);
            file.SaveAs(path);

            return Json(new { FileName = filename });
        }
    }
}