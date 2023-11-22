using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace IEFI_SyO
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Libroes",
                url: "Libroes/{action}/{id}",
                defaults: new { controller = "Libroes", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Socios",
                url: "Socios/{action}/{id}",
                defaults: new { controller = "Socios", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Empleadoes",
                url: "Empleadoes/{action}/{id}",
                defaults: new { controller = "Empleadoes", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Prestamoes",
                url: "Prestamoes/{action}/{id}",
                defaults: new { controller = "Prestamoes", action = "Index", id = UrlParameter.Optional }
            );

        }
    }
}
