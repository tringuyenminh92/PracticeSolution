using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using B2B.BL.Service;

namespace B2B.PresentationLayer.Controllers
{
    public class QuanlyHanghoaController : Controller
    {
        //
        // GET: /QuanlyHanghoa/
        NhomHanghoaService _nhomHanghoaService;
        HanghoaService _hanghoaService;
        public QuanlyHanghoaController()
        {
            _nhomHanghoaService = new NhomHanghoaService();
            _hanghoaService = new HanghoaService();
        }
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult LoadHanghoaTheoNhomHanghoa(string nhomHanghoaId)
        {
            List<HanghoaModel> lstHanghoa = new List<HanghoaModel>();
            if (nhomHanghoaId != null)
            {
                lstHanghoa = _hanghoaService.GetHanghoaTheoNhomHanghoa(nhomHanghoaId);
            }
            else
            {
                lstHanghoa = _hanghoaService.GetHanghoa();
            }
            return Json(lstHanghoa, JsonRequestBehavior.AllowGet);
        }

        public JsonResult LoadNhomHanghoa()
        {
            return Json(_nhomHanghoaService.GetNhomHanghoa(), JsonRequestBehavior.AllowGet);
        }
    }
}
