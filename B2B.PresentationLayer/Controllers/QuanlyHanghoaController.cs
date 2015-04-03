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

        public JsonResult LoadHanghoaTheoNhomHanghoa ()
        {
            NhomHanghoaModel nhomHanghoa = new NhomHanghoaModel();
            nhomHanghoa.NhomHanghoaId = new Guid("00000000-0000-0000-0000-000000000000");
            List<HanghoaModel> lst = _hanghoaService.GetHanghoaTheoNhomHanghoa(nhomHanghoa);
            return Json(_hanghoaService.GetHanghoaTheoNhomHanghoa(nhomHanghoa), JsonRequestBehavior.AllowGet);
        }
    }
}
