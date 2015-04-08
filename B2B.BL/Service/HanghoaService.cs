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
    public class HanghoaService
    {
        HanghoaRepository repository;
        public HanghoaService()
        {
            repository = new HanghoaRepository();
        }

        public List<HanghoaModel> GetHanghoa()
        {
            Mapper.CreateMap<Hanghoa, HanghoaModel>();
            var lstHanghoa = repository.GetHanghoa();
            return Mapper.Map<IQueryable<Hanghoa>, List<HanghoaModel>>(lstHanghoa);
        }
        public List<HanghoaModel> GetHanghoaActive()
        {
            Mapper.CreateMap<Hanghoa, HanghoaModel>();
            var lstHanghoa = repository.GetHanghoaActive();
            return Mapper.Map<IQueryable<Hanghoa>, List<HanghoaModel>>(lstHanghoa);
        }
        public List<HanghoaModel> GetHanghoaTheoNhomHanghoa(string nhomHanghoaId)
        {
            Mapper.CreateMap<Hanghoa, HanghoaModel>();
            var lstHanghoa = repository.GetHanghoaTheoNhomHanghoa(nhomHanghoaId);
            return Mapper.Map<IQueryable<Hanghoa>, List<HanghoaModel>>(lstHanghoa);
        }
        public List<HanghoaModel> GetHanghoaActiveTheoNhomHanghoa(string nhomHanghoaId)
        {
            Mapper.CreateMap<Hanghoa, HanghoaModel>();
            var lstHanghoa = repository.GetHanghoaActiveTheoNhomHanghoa(nhomHanghoaId);
            return Mapper.Map<IQueryable<Hanghoa>, List<HanghoaModel>>(lstHanghoa);
        }

        public HanghoaModel GetHanghoaTheoHanghoaId(string hanghoaId)
        {
            Mapper.CreateMap<Hanghoa, HanghoaModel>();
            var hanghoa = repository.GetHanghoaTheoHanghoaId(hanghoaId);
            return Mapper.Map<Hanghoa, HanghoaModel>(hanghoa);
        }
        public bool Delete(string hanghoaId)
        {
            return repository.Delete(hanghoaId);
        }
        public bool Insert(HanghoaModel hanghoa)
        {
            Mapper.CreateMap<HanghoaModel, Hanghoa>();
            Hanghoa hh = Mapper.Map<HanghoaModel, Hanghoa>(hanghoa);
            return repository.Insert(hh);
        }
        public bool Update(HanghoaModel hanghoa)
        {
            Mapper.CreateMap<HanghoaModel, Hanghoa>();
            Hanghoa hh = Mapper.Map<HanghoaModel, Hanghoa>(hanghoa);
            return repository.Update(hh);

        }
    }
}
