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
    public class QuanhuyenService
    {
        QuanhuyenRepository repository;
        public QuanhuyenService()
        {
            repository = new QuanhuyenRepository();
        }
        public List<QuanhuyenModel> GetQuanhuyen()
        {
            Mapper.CreateMap<Tri_GetQuanhuyenActive_Result, QuanhuyenModel>();
            var listQuanhuyen = repository.GetQuanhuyen();
            return Mapper.Map<IQueryable<Tri_GetQuanhuyenActive_Result>, List<QuanhuyenModel>>(listQuanhuyen);
        }
    }
}
