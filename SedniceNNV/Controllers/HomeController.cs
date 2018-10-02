using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SedniceNNV.Controllers
{
    [CustomAuthorize(Roles = "Admin,User")]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

    }
}