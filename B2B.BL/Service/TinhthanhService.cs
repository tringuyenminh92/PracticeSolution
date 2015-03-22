﻿using AutoMapper;
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
    public class TinhthanhService
    {
        TinhthanhRepository repository;
        public TinhthanhService()
        {
            repository = new TinhthanhRepository();
        }
        public IEnumerable<TinhthanhModel> GetTinhthanh()
        {
            Mapper.CreateMap<Tri_GetTinhthanhActive_Result, TinhthanhModel>();
            var listTinhthanh = repository.GetTinhthanh();
            return Mapper.Map<IQueryable<Tri_GetTinhthanhActive_Result>, IEnumerable<TinhthanhModel>>(listTinhthanh);
        }
    }
}
