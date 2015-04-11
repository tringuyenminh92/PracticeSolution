using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace B2B.PresentationLayer.Controllers
{
    public class UserController : Controller
    {
        //
        // GET: /User/
        B2B.BL.Service.UserService us = new BL.Service.UserService();

        public ActionResult Index()
        {
            return View();
        }
        public JsonResult GetUser()
        {
            var rs = us.GetUser().ToList();
            return Json(rs, JsonRequestBehavior.AllowGet);
        }
        public bool DeleteAccount(Model.AccountModel accountId)
        {
            var id = accountId.AccountId;
            return us.DeleteAccount(accountId.AccountName);
        }
        //Get All Account
        public JsonResult GetAllAccount()
        {
            var rs = us.GetAllAccount().ToList();
            return Json(rs, JsonRequestBehavior.AllowGet);
        }
        public bool SaveAllAccount(List<Model.AccountModel> listAccount)
        {
            return true;
        }
    }
}
