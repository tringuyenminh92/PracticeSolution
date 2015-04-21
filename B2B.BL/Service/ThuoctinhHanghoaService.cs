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
    public class ThuoctinhHanghoaService
    {
        ThuoctinhHanghoaRepository repository;
        public ThuoctinhHanghoaService()
        {
            repository = new ThuoctinhHanghoaRepository();
        }
        public List<ThuoctinhHanghoaModel> GetThuoctinhHanghoaTheoHanghoa(string hanghoaId)
        {
            Mapper.CreateMap<ThuoctinhHanghoa, ThuoctinhHanghoaModel>();
            var lstThuoctinhHanghoa = repository.GetThuoctinhHanghoaTheoHanghoa(hanghoaId);
            return Mapper.Map<IQueryable<ThuoctinhHanghoa>, List<ThuoctinhHanghoaModel>>(lstThuoctinhHanghoa);
        }
         public bool Delete(string thuoctinhHanghoaId)
        {
            return repository.Delete(thuoctinhHanghoaId);
        }
         public bool DeleteList(List<ThuoctinhHanghoaModel> lstThuoctinhHanghoa)
         {
             for (int i = 0; i < lstThuoctinhHanghoa.Count; ++i)
             {
                 if (!Delete(lstThuoctinhHanghoa[i].ThuoctinhHanghoaId.ToString()))
                 {
                     return false;
                 }
             }
             return true;
         }
        public bool Insert(ThuoctinhHanghoaModel thuoctinhHanghoa)
        {
            Mapper.CreateMap<ThuoctinhHanghoaModel, ThuoctinhHanghoa>();
            ThuoctinhHanghoa tthh = Mapper.Map<ThuoctinhHanghoaModel, ThuoctinhHanghoa>(thuoctinhHanghoa);
            return repository.Insert(tthh);
        }
        public bool InsertList(List<ThuoctinhHanghoaModel> lstThuoctinhHanghoa)
        {
            for (int i = 0; i < lstThuoctinhHanghoa.Count; ++i)
            {
                if(!Insert(lstThuoctinhHanghoa[i]))
                {
                    return false;
                }
            }
            return true;
        }
    }
}
