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
            //var listAccount1 = new List<Model.AccountModel>();
            //listAccount1.Add(listAccount);
            if (listAccount.Count < 1)
            {
                return false;
            }
            return us.SaveAllAccount(listAccount);

        }
        //Paage Addnew Account
        public ActionResult AddAccount()
        {
            return View();
        }
        public JsonResult AddnewAccout(string user, string pass)
        {
            bool f = false;
            Model.AccountModel ac = new Model.AccountModel();
            if(user!=null&& user!="" && pass!="" && pass!=null)
            {
                ac.Active = true;
                ac.AccountName = user;
                ac.AccountPassword = pass;
                if (us.CheckAccount(ac.AccountName))
                {
                    f = us.AddnewAccount(ac);
                }
            }
            return Json(new { result = f });
        }
    }
}
