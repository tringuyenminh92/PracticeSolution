using AutoMapper;
using B2B.DAL;
using B2B.DAL.Repository;
using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace B2B.BL.Service
{
    public class DonhangService
    {
        private DonhangRepository _donhangRepository;
        public DonhangService()
        {
            _donhangRepository = new DonhangRepository();
        }
        public List<DonhangModel> GetDonhang()
        {
            Mapper.CreateMap<Donhang, DonhangModel>();
            return Mapper.Map<IQueryable<Donhang>, List<DonhangModel>>(_donhangRepository.GetDonhang());
        }
        public IEnumerable<DonhangModel> GetDonhangsByMonth(DateTime ngaylap, int loaiDonhang)
        {
            Mapper.CreateMap<Tri_GetDonhangTheoThang_Result, DonhangModel>();
            return Mapper.Map<IQueryable<Tri_GetDonhangTheoThang_Result>, IEnumerable<DonhangModel>>(_donhangRepository.GetDonhangsByMonth(ngaylap, loaiDonhang));
        }
        public bool Insert(DonhangModel donhang)
        {
            Mapper.CreateMap<DonhangModel, Donhang>();
            Donhang dh = Mapper.Map<DonhangModel, Donhang>(donhang);
            return _donhangRepository.Insert(dh);
        }
        public bool Update(DonhangModel donhang)
        {
            Mapper.CreateMap<DonhangModel, Donhang>();
            Donhang dh = Mapper.Map<DonhangModel, Donhang>(donhang);
            return _donhangRepository.Update(dh);
        }
    }
}
