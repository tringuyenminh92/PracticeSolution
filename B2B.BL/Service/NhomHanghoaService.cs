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
    public class NhomHanghoaService
    {
        NhomHanghoaRepository repository;
        public NhomHanghoaService()
        {
            repository = new NhomHanghoaRepository();
        }

        public List<NhomHanghoaModel> GetNhomHanghoaActive()
        {
            Mapper.CreateMap<Vinh_GetNhomHanghoaActive_Result, NhomHanghoaModel>();
            var lstNhomHanghoa = repository.GetNhomHanghoaActive();
            return Mapper.Map<IQueryable<Vinh_GetNhomHanghoaActive_Result>, List<NhomHanghoaModel>>(lstNhomHanghoa);
        }

        public List<NhomHanghoaModel> GetNhomHanghoa()
        {
            Mapper.CreateMap<NhomHanghoa, NhomHanghoaModel>();
            var lstNhomHanghoa = repository.GetNhomHanghoa();
            return Mapper.Map<IQueryable<NhomHanghoa>, List<NhomHanghoaModel>>(lstNhomHanghoa);
        }
    }
}
