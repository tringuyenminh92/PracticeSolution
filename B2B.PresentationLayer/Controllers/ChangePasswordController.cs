using B2B.BL.Service;
using B2B.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class ChangePasswordController : Controller
    {
        UserService service;

        public ChangePasswordController()
        {
            service = new UserService();
        }
        public JsonResult CheckPass(AccountModel model, string passnew)
        {
            //AccountModel model = service.getUser("vinhpham");
            int i = 0;
            if (model.Password != "")
            {
                model.Password = passnew;
                i = UpdatePassword(model);
            }
            return Json(i);
        }
        private int UpdatePassword(AccountModel model)
        {
            return service.UpdatePassword(model);
        }
    }
}
