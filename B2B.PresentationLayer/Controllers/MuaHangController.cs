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
        HanghoaService _hanghoaService;
        NhomHanghoaService _nhomHanghoaService;
        DonhangService _donhangService;
        ChitietDonhangService _chitietDonhangService;
        TinhtrangService _tinhtrangService;
        TinhtrangDonhangService _tinhtrangDonhangService;
        KhachhangService _khachhangService;

        public MuaHangController()
        {
            _hanghoaService = new HanghoaService();
            _nhomHanghoaService = new NhomHanghoaService();
            _donhangService = new DonhangService();
            _chitietDonhangService = new ChitietDonhangService();
            _tinhtrangService = new TinhtrangService();
            _tinhtrangDonhangService = new TinhtrangDonhangService();
            _khachhangService = new KhachhangService();
        }
        //
        // GET: /DSHanghoa/

        public ActionResult DatHang()
        {
            return View();
        }

        public ActionResult ChonDiachigiaohang()
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
        public JsonResult LayDonhangTam()
        {
            List<ChitietDonhangModel> lstChitietDonhangTam = (List<ChitietDonhangModel>)Session["chitietDonhangTams"];
            DonhangModel donhangTam = (DonhangModel)Session["donhangTam"];
            return Json(new { lst = lstChitietDonhangTam, dh = donhangTam }, JsonRequestBehavior.AllowGet);
        }
        public void CapnhatDonhangTam(List<ChitietDonhangModel> lstChitietDonhangTam, DonhangModel donhang)
        {
            Session["chitietDonhangTams"] = lstChitietDonhangTam;
            Session["donhangTam"] = donhang;
        }
        public JsonResult InsertDonhang(DonhangModel donhang, List<ChitietDonhangModel> lstChitietDonhang, KhachhangModel khachhang, int truonghop)
        {
            bool kq;
            string thongbao = "";
            if(truonghop != 0)
            {
                _khachhangService.Update(khachhang);
            }
            donhang.Ngaylap = DateTime.Now;
            donhang.NgayCapnhat = DateTime.Now;
            var tinhtrangDonhangDalap = _tinhtrangService.GetTinhtrangTheoCode("TTDH01");
            donhang.TinhtrangDonhangCurrentId = tinhtrangDonhangDalap.TinhtrangId;
            donhang.TenTinhtrangDonhang = tinhtrangDonhangDalap.TenTinhtrang;

            if(_donhangService.Insert(donhang))
            {
                var tinhtrangDonhang = new TinhtrangDonhangModel();
                tinhtrangDonhang.DonhangId = donhang.DonhangId;
                tinhtrangDonhang.TinhtrangId = donhang.TinhtrangDonhangCurrentId;
                tinhtrangDonhang.NgayCapnhat = DateTime.Now;
                if(_tinhtrangDonhangService.Insert(tinhtrangDonhang))
                {
                    kq = true;
                    for (int i = 0; i < lstChitietDonhang.Count; ++i)
                    {
                        lstChitietDonhang[i].DonhangId = donhang.DonhangId;
                        lstChitietDonhang[i].NgayCapnhat = DateTime.Now;
                        if (!_chitietDonhangService.Insert(lstChitietDonhang[i]))
                        {
                            //Cập nhật chi tiết đơn hàng ko thành công
                            kq = false;
                            break;
                        }
                    }
                }
                //Cập nhật tình trạng đơn hàng không thành công
                else { kq = false; }
                
            }
            //Cập nhật đơn hàng không thành công
            else { kq = false; }


            if (kq)
            {
                thongbao = "Lưu đơn hàng thành công.";
            }
            else
            {
                thongbao = "Lưu đơn hàng không thành công.";
            }
            return Json(new { thongbao = thongbao, kq = kq }, JsonRequestBehavior.AllowGet);
        }
    }
}
