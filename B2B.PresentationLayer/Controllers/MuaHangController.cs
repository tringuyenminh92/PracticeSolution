﻿using B2B.BL.Service;
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
        HanghoaService _hanghoaService;
        NhomHanghoaService _nhomHanghoaService;
        public MuaHangController()
        {
            _hanghoaService = new HanghoaService();
            _nhomHanghoaService = new NhomHanghoaService();
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
            List<NhomHanghoaModel> lst = _nhomHanghoaService.GetNhomHanghoaActive();
            return Json(_nhomHanghoaService.GetNhomHanghoaActive(), JsonRequestBehavior.AllowGet);
        }
        //___________________________
        public JsonResult LoadHanghoaTheoNhomHanghoa(string nhomHanghoaId)
        {
            List<HanghoaModel> lstHanghoa = new List<HanghoaModel>();
            if (nhomHanghoaId != null)
            {
                lstHanghoa = _hanghoaService.GetHanghoaActiveTheoNhomHanghoa(nhomHanghoaId);
            }
            else
            {
                lstHanghoa = _hanghoaService.GetHanghoaActive();
            }
            return Json(lstHanghoa, JsonRequestBehavior.AllowGet);
        }
    }
}
