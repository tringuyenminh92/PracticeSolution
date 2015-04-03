using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using B2B.DAL;
using B2B.Model;
using B2B.DAL.Repository;
using AutoMapper;
using log4net;

namespace B2B.BL.Service
{
    public class DSHanghoaService
    {
        private static readonly ILog logger = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        //Flag to check if error level was enabled.
        private static readonly bool isErrorEnabled = logger.IsErrorEnabled;

        DSHanghoaReponsitory dhr;
        public DSHanghoaService()
        {
            dhr = new DSHanghoaReponsitory();
        }
        public IEnumerable<Model.HanghoaModel_Tin>GetDSHanghoaTheoNhomHanghoa(Guid? nhomHh)
        {
            Mapper.CreateMap<Khuyen_GetHanghoaTheoNhom_Result, HanghoaModel_Tin>();
            var hanghoaList = dhr.GetDSHanghoaTheoNhomHanghoa(nhomHh);
            return Mapper.Map<IQueryable<Khuyen_GetHanghoaTheoNhom_Result>, IEnumerable<HanghoaModel_Tin>>(hanghoaList);
        }
        //Nhom hang hoa
        public IEnumerable<Model.NhomHanghoaModel_Tin>GetNhomHanghoa()
        {
            Mapper.CreateMap<NhomHanghoa, Model.NhomHanghoaModel_Tin>();
            var nhomHanghoaList = dhr.GetNhomHanghoa();
            return Mapper.Map<IQueryable<NhomHanghoa>, IEnumerable<Model.NhomHanghoaModel_Tin>>(nhomHanghoaList);
        }
    }
}
