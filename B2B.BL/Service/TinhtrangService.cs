using AutoMapper;
using B2B.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using B2B.Model;

namespace B2B.BL.Service
{
    public class TinhtrangService
    {
        TinhtrangRepository repository;
        public TinhtrangService() { repository = new TinhtrangRepository(); }
        public TinhtrangModel GetTinhtrangTheoCode(string code)
        {
            Mapper.CreateMap<Tinhtrang, TinhtrangModel>();
            var tt = repository.GetTinhtrangTheoCode(code);
            return Mapper.Map<Tinhtrang, TinhtrangModel>(tt);
        }
    }
}
