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

        public List<NhomHanghoaModel> GetNhomHanghoa()
        {
            Mapper.CreateMap<Vinh_GetNhomHanghoaActive_Result, NhomHanghoaModel>();
            var a = repository.GetNhomHanghoa();
            var modelList = Mapper.Map<IQueryable<Vinh_GetNhomHanghoaActive_Result>, List<NhomHanghoaModel>>(a);
            return modelList;
        }

    }
}
