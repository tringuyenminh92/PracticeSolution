using B2B.DAL.Repository;
using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using B2B.DAL;
using AutoMapper;

namespace B2B.BL.Service
{
    public class KhachhangService
    {
        KhachhangRepository repository;
        public KhachhangService() { repository = new KhachhangRepository(); }
        public KhachhangModel GetKhachhangFromAccountId(string accountId)
        {
            Mapper.CreateMap<Tri_GetKhachhangDemo_Result, KhachhangModel>();
            var kh = repository.GetKhachhangFromAccountId(accountId);
            return Mapper.Map<Tri_GetKhachhangDemo_Result, KhachhangModel>(kh);
        }
        public bool Insert(KhachhangModel khachhang)
        {
            Mapper.CreateMap<KhachhangModel, Khachhang>();
            Khachhang kh = Mapper.Map<KhachhangModel, Khachhang>(khachhang);
            return repository.Insert(kh);
        }
        public bool Update(KhachhangModel khachhang)
        {
            Mapper.CreateMap<KhachhangModel, Khachhang>();
            Khachhang kh = Mapper.Map<KhachhangModel, Khachhang>(khachhang);
            return repository.Update(kh);
        }
    }
}
