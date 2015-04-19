using AutoMapper;
using B2B.DAL.Repository;
using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using B2B.DAL;

namespace B2B.BL.Service
{
    public class ChitietDonhangService
    {
        ChitietDonhangRepository repository;
        public ChitietDonhangService() { repository = new ChitietDonhangRepository(); }
        public List<ChitietDonhangModel> GetChitietDonhangTheoDonhang(string donhangId)
        {
            Mapper.CreateMap<ChitietDonhang, ChitietDonhangModel>();
            var lstChitietDonhang = repository.GetChitietDonhangTheoDonhang(donhangId);
            return Mapper.Map<IQueryable<ChitietDonhang>, List<ChitietDonhangModel>>(lstChitietDonhang);
        }
        public bool Insert(ChitietDonhangModel chitietdonhang)
        {
            Mapper.CreateMap<ChitietDonhangModel, ChitietDonhang>();
            ChitietDonhang ctdh = Mapper.Map<ChitietDonhangModel, ChitietDonhang>(chitietdonhang);
            return repository.Insert(ctdh);
        }
        public bool Update(ChitietDonhangModel chitietdonhang)
        {
            Mapper.CreateMap<ChitietDonhangModel, ChitietDonhang>();
            ChitietDonhang ctdh = Mapper.Map<ChitietDonhangModel, ChitietDonhang>(chitietdonhang);
            return repository.Update(ctdh);
        }
    }
}
