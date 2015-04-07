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
    public class DonviService
    {
        DonviRepository repository;
        public DonviService()
        {
            repository = new DonviRepository();
        }

        public List<DonviModel> GetDonvi()
        {
            Mapper.CreateMap<Donvi, DonviModel>();
            var lstDonvi = repository.GetDonvi();
            return Mapper.Map<IQueryable<Donvi>, List<DonviModel>>(lstDonvi);
        }
    }
}
