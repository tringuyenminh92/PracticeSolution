using B2B.BL.Service;
using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class MuaHangController : Controller, ICustomAuthorize
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
            if (!AllowAccessAsUser())
            {
                return Redirect("/Taikhoan/Dangnhap");
            }
            if (string.IsNullOrWhiteSpace(Session["accountName"] as string))
            {
                return Redirect("/Taikhoan/Dangnhap");
            }
            return View();
        }

        public ActionResult ChonDiachigiaohang()
        {
            if (!AllowAccessAsUser())
            {
                return Redirect("/Taikhoan/Dangnhap");
            }
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
            if (truonghop != 0)
            {
                _khachhangService.Update(khachhang);
            }
            //donhang.DonhangId = Guid.NewGuid();
            //donhang.Ngaylap = DateTime.Now;
            //donhang.NgayCapnhat = DateTime.Now;
            var tinhtrangDonhangDalap = _tinhtrangService.GetTinhtrangTheoCode("TTDH01");
            Guid? tinhtrangId = tinhtrangDonhangDalap.TinhtrangId;
            string tenTinhtrang = tinhtrangDonhangDalap.TenTinhtrang;
            //donhang.TinhtrangDonhangCurrentId = tinhtrangDonhangDalap.TinhtrangId;
            //donhang.TenTinhtrangDonhang = tinhtrangDonhangDalap.TenTinhtrang;

            DateTime today = DateTime.Now;
            DonhangModel donhang1 = new DonhangModel();
            donhang1.DonhangId = Guid.NewGuid();
            donhang1.Ngaylap = today;
            donhang1.NgayCapnhat = today;
            donhang1.TinhtrangDonhangCurrentId = tinhtrangId;
            donhang1.TenTinhtrangDonhang = tenTinhtrang;
            donhang1.KhachhangId = donhang.KhachhangId;
            donhang1.DiachiGiao = donhang.DiachiGiao;
            donhang1.TenTinhthanhGiao = donhang.TenTinhthanhGiao;
            donhang1.TenQuanhuyenGiao = donhang.TenQuanhuyenGiao;
            donhang1.SoDienthoai = donhang.SoDienthoai;
            donhang1.Tiengiam = donhang.Tiengiam;
            donhang1.PhantramGiam = donhang.PhantramGiam;
            donhang1.Tongtien = donhang.Tongtien;
            donhang1.Ghichu = donhang.Ghichu;
            donhang1.LoaiDonhang = donhang.LoaiDonhang;
            donhang1.Active = true;
            donhang1.Ngaygiao = today.AddDays(3);
            donhang1.Code = "" + today.Day + today.Month + today.Year + today.TimeOfDay.Hours + today.TimeOfDay.Minutes + today.TimeOfDay.Seconds;

            if (_donhangService.Insert(donhang1))
            {
                var tinhtrangDonhang = new TinhtrangDonhangModel();
                tinhtrangDonhang.DonhangId = donhang1.DonhangId;
                tinhtrangDonhang.TinhtrangId = donhang.TinhtrangDonhangCurrentId;
                tinhtrangDonhang.NgayCapnhat = DateTime.Now;
                if (_tinhtrangDonhangService.Insert(tinhtrangDonhang))
                {
                    kq = true;
                    for (int i = 0; i < lstChitietDonhang.Count; ++i)
                    {
                        lstChitietDonhang[i].DonhangId = donhang1.DonhangId;
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
                kq = true;

            }
            //Cập nhật đơn hàng không thành công
            else { kq = false; }


            if (kq)
            {
                Session["chitietDonhangTams"] = null;
                Session["donhangTam"] = null;
                thongbao = "Lưu đơn hàng thành công.";
            }
            else
            {
                thongbao = "Lưu đơn hàng không thành công.";
            }
            return Json(new { thongbao = thongbao, kq = kq }, JsonRequestBehavior.AllowGet);
        }

        public bool AllowAccessAsAdmin()
        {
            var typeAcc = Session["TypeAccount"] as string;
            if (typeAcc == "Admin")
            {
                return true;
            }
            return false;
        }

        public bool AllowAccessAsUser()
        {
            var typeAcc = Session["TypeAccount"] as string;
            if (typeAcc == "User" || typeAcc == "Admin")
            {
                return true;
            }
            return false;
        }
    }
}
