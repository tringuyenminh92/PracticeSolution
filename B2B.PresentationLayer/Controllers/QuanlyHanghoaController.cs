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
        DonviService _donviService;
        ThuoctinhHanghoaService _thuoctinhHanghoaService;

        public QuanlyHanghoaController()
        {
            _nhomHanghoaService = new NhomHanghoaService();
            _hanghoaService = new HanghoaService();
            _donviService = new DonviService();
            _thuoctinhHanghoaService = new ThuoctinhHanghoaService();
        }
        public ActionResult Index()
        {
            return View();
        }
        public JsonResult GetHanghoaTheoHanghoaId(string hanghoaId)
        {
            return Json(_hanghoaService.GetHanghoaTheoHanghoaId(hanghoaId), JsonRequestBehavior.AllowGet);
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
        public JsonResult LoadDonvi()
        {
            List<DonviModel> lst = _donviService.GetDonvi();
            return Json(_donviService.GetDonvi(), JsonRequestBehavior.AllowGet);
        }
        public JsonResult LoadThuoctinhHanghoa(string hanghoaId)
        {
            List<ThuoctinhHanghoaModel> lstThuoctinh = _thuoctinhHanghoaService.GetThuoctinhHanghoaTheoHanghoa(hanghoaId);
            return Json(new { lst = lstThuoctinh }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DeleteHanghoa(string hanghoaId)
        {
            return Json(_hanghoaService.Delete(hanghoaId), JsonRequestBehavior.AllowGet);
        }

        public JsonResult InsertHanghoa(HanghoaModel hanghoa, List<ThuoctinhHanghoaModel> lstThuoctinhHanghoa)
        {
            hanghoa.NgayCapnhat = DateTime.Now;
            var kq = _hanghoaService.Insert(hanghoa);
            string thongbao;
            if (kq)
            {
                if (lstThuoctinhHanghoa.Count != 0)
                {
                    if (!_thuoctinhHanghoaService.InsertList(lstThuoctinhHanghoa)) { kq = false; }
                }
            }

            if (kq)
            {
                thongbao = "Thêm hàng hóa thành công";
            }
            else
            {
                thongbao = "Thêm hàng hóa không thành công";
            }


            return Json(new { thongbao = thongbao, kq = kq }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateHanghoa(HanghoaModel hanghoa, List<ThuoctinhHanghoaModel> lstThuoctinhHanghoaThem, List<ThuoctinhHanghoaModel> lstThuoctinhHanghoaXoa)
        {
            hanghoa.NgayCapnhat = DateTime.Now;
            var kq = _hanghoaService.Update(hanghoa);
            string thongbao;
            if (kq)
            {
                string thongbao1 = "";
                string thongbao2 = "";
                if (lstThuoctinhHanghoaThem != null)
                {
                    for (int i = 0; i < lstThuoctinhHanghoaThem.Count; ++i)
                    {
                        lstThuoctinhHanghoaThem[i].HanghoaId = hanghoa.HanghoaId;
                        lstThuoctinhHanghoaThem[i].Active = true;
                        lstThuoctinhHanghoaThem[i].NgayCapnhat = DateTime.Now;
                    }
                    if (!_thuoctinhHanghoaService.InsertList(lstThuoctinhHanghoaThem)) { kq = false; thongbao1 = "Thêm thuộc tính không thành công. "; }
                }
                if(lstThuoctinhHanghoaXoa != null)
                {
                    if (!_thuoctinhHanghoaService.DeleteList(lstThuoctinhHanghoaXoa)) { kq = false; thongbao2 = "Xóa thuộc tính không thành công."; }
                }
                thongbao = thongbao1 + thongbao2;
            }
            else
            {
                thongbao = "Sửa hàng hóa không thành công";
            }

            if (kq)
            {
                thongbao = "Sửa hàng hóa thành công";
            }
            return Json(new { thongbao = thongbao, kq = kq }, JsonRequestBehavior.AllowGet);
        }
    }
}
