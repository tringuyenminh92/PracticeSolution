using B2B.BL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class DSHanghoaController : Controller
    {
        DSHanghoaService dhs = new DSHanghoaService();
        //
        // GET: /DSHanghoa/

        public ActionResult Index()
        {
            return View();
        }
        //public JsonResult GetHanghoaTheoNhomHanghoa(string nhomHanghoaId)
        //{
        //    Guid? nhomHanghoaId1=new Guid("55d8d06f-1d8b-4411-aa84-bfa4b398ffe9");
        //    //nhomHanghoaId = id;
        //    var rs = dhs.GetDSHanghoaTheoNhomHanghoa(nhomHanghoaId1);
        //    return Json(rs,JsonRequestBehavior.AllowGet);
        //}
        
        //Nhom hang hoa
        public JsonResult GetNhomhanghoa()
        {
            var rs = dhs.GetNhomHanghoa();
            return Json(rs, JsonRequestBehavior.AllowGet); 
        }
        //___________________________
        public JsonResult GetHanghoa(string idNhomhanghoa)
        {
            Guid? id;
            if (idNhomhanghoa != "")
                id = new Guid(idNhomhanghoa);
            else
                id = new Guid("55d8d06f-1d8b-4411-aa84-bfa4b398ffe9");
            var rs = dhs.GetDSHanghoaTheoNhomHanghoa(id);
            return Json(rs,JsonRequestBehavior.AllowGet);
        }
    }
}
