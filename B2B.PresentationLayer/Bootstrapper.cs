using System.Web.Mvc;
using Microsoft.Practices.Unity;
using Microsoft.Practices.Unity.Mvc;
using B2B.BL.IService;
using B2B.BL.Service;
using B2B.DAL.IRepository;
using B2B.DAL.Repository;
using B2B.DAL;

namespace B2B.PresentationLayer
{
    public static class Bootstrapper
    {
        public static void Initialize()
        {
            var container = BuildUnityContainer();

            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }

        private static IUnityContainer BuildUnityContainer()
        {
            var container = new UnityContainer();

            // register all your components with the container here
            // it is NOT necessary to register your controllers
            
            // e.g. container.RegisterType<ITestService, TestService>();     
            
            return container;
        }
    }
}
