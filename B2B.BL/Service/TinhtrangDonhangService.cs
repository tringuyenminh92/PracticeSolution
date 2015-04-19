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
    public class TinhtrangDonhangService
    {
        TinhtrangDonhangRepository repository;
        public TinhtrangDonhangService() { repository = new TinhtrangDonhangRepository(); }
        public bool Insert(TinhtrangDonhangModel tinhtrangDonhang)
        {
            Mapper.CreateMap<TinhtrangDonhangModel, TinhtrangDonhang>();
            TinhtrangDonhang ttdh = Mapper.Map<TinhtrangDonhangModel, TinhtrangDonhang>(tinhtrangDonhang);
            return repository.Insert(ttdh);
        }
    }
}
