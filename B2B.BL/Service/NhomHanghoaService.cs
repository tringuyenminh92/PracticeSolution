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

        public List<NhomHanghoaModel> GetAllNhomHanghoa()
        {
            Mapper.CreateMap<NhomHanghoa, NhomHanghoaModel>();
            var a = repository.GetAllNhomHanghoa();
            var modelList = Mapper.Map<IQueryable<NhomHanghoa>, List<NhomHanghoaModel>>(a);
            return modelList;
        }

    }
}
