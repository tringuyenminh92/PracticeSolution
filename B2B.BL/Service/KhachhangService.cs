﻿using B2B.DAL.Repository;
using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using B2B.DAL;
using AutoMapper;

namespace B2B.BL.Service
{
    public class KhachhangService
    {
        KhachhangRepository repository;
        public KhachhangService() { repository = new KhachhangRepository(); }
        public bool Insert(KhachhangModel khachhang)
        {
            Mapper.CreateMap<KhachhangModel, Khachhang>();
            Khachhang kh = Mapper.Map<KhachhangModel, Khachhang>(khachhang);
            return repository.Insert(kh);
        }
    }
}