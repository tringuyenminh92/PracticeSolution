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

        public List<HanghoaModel> GetAllHanghoa()
        {
            Mapper.CreateMap<Hanghoa, HanghoaModel>();
            var a = repository.GetAllHanghoa();
            var modelList = Mapper.Map<IQueryable<Hanghoa>, List<HanghoaModel>>(a);


            return modelList;
        }

    }
}
