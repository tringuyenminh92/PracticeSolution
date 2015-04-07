using B2B.BL.Service;
using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class MuaHangController : Controller
    {
        HanghoaService hangHoaService;
        NhomHanghoaService nhomHangHoaService;
        public MuaHangController()
        {
            hangHoaService = new HanghoaService();
            nhomHangHoaService = new NhomHanghoaService();
        }
        //
        // GET: /DSHanghoa/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DatHang()
        {
            return View();
        }

        //Nhom hang hoa
        public JsonResult LoadNhomHanghoa()
        {
            var rs = nhomHangHoaService.GetNhomHanghoaActive();
            return Json(rs);
        }
        //___________________________
        public JsonResult LoadHanghoaTheoNhomHanghoa(NhomHanghoaModel nhomHanghoaModel)
        {
            var rs = hangHoaService.GetHanghoaAcTtiveheoNhomHanghoa(nhomHanghoaModel);
            return Json(rs,JsonRequestBehavior.AllowGet);
        }
    }
}
