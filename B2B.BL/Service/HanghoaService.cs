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
            var a = repository.GetHanghoa();
            var modelList = Mapper.Map<IQueryable<Hanghoa>, List<HanghoaModel>>(a);
            return modelList;
        }

        public List<HanghoaModel> GetHanghoaTheoNhomHanghoa(string nhomHanghoaId)
        {
            Mapper.CreateMap<Hanghoa, HanghoaModel>();
            var lstHanghoa = repository.GetHanghoaTheoNhomHanghoa(nhomHanghoaId);
            return Mapper.Map<IQueryable<Hanghoa>, List<HanghoaModel>>(lstHanghoa);
        }
        public List<HanghoaModel> GetHanghoaAcTtiveheoNhomHanghoa(NhomHanghoaModel nhomHanghoa)
        {
            Mapper.CreateMap<NhomHanghoaModel, NhomHanghoa>();
            var nhomhh = Mapper.Map<NhomHanghoaModel, NhomHanghoa>(nhomHanghoa);
            var lstHanghoa = repository.GetHanghoaActiveTheoNhomHanghoa(nhomhh);

            Mapper.CreateMap<Hanghoa, HanghoaModel>();
            return Mapper.Map<IQueryable<Hanghoa>, List<HanghoaModel>>(lstHanghoa);
        }

    }
}
