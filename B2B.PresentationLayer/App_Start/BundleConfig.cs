using System.Web;
using System.Web.Optimization;

namespace B2B.PresentationLayer
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                        "~/Scripts/jquery-ui-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.unobtrusive*",
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                                                             "~/Content/bootstrap/css/bootstrap.css",
                                                            "~/Content/ui-grid-unstable.css",
                                                            "~/Content/font-awesome.css",
                                                            "~/Content/myStyle.css",
                                                             "~/Content/gridStyleMuaHang.css",
                                                            "~/Content/ng-tags-input.css",
                                                            "~/Content/ng-tags-input.bootstrap.css",
                                                             "~/Content/select.css"));

            bundles.Add(new StyleBundle("~/Content/themes/base/css").Include(
                        "~/Content/themes/base/jquery.ui.core.css",
                        "~/Content/themes/base/jquery.ui.resizable.css",
                        "~/Content/themes/base/jquery.ui.selectable.css",
                        "~/Content/themes/base/jquery.ui.accordion.css",
                        "~/Content/themes/base/jquery.ui.autocomplete.css",
                        "~/Content/themes/base/jquery.ui.button.css",
                        "~/Content/themes/base/jquery.ui.dialog.css",
                        "~/Content/themes/base/jquery.ui.slider.css",
                        "~/Content/themes/base/jquery.ui.tabs.css",
                        "~/Content/themes/base/jquery.ui.datepicker.css",
                        "~/Content/themes/base/jquery.ui.progressbar.css",
                        "~/Content/themes/base/jquery.ui.theme.css"));


            bundles.Add(new ScriptBundle("~/bundles/Angular").Include(
                                                                "~/Scripts/Angular/angular.js",
                                                                "~/Scripts/Angular/bootstrap.js",
                                                                "~/Scripts/Angular/ui-grid-unstable.js",
                                                                "~/Scripts/Angular/ng-grid-1.3.2.js",
                                                                "~/Scripts/Angular/angular-resource.js",
                                                                "~/Scripts/Angular/angular-touch.js",
                                                                 "~/Scripts/Angular/ng-file-upload.js",
                                                                "~/Scripts/Angular/ng-file-upload-shim.js",
                                                                "~/Scripts/Angular/angular-route.js",
                                                                "~/Scripts/Angular/ng-tags-input.js",
                                                                "~/Scripts/Angular/angular-sanitize.js",
                                                                 "~/Scripts/Angular/select.js",
                                                                 "~/Scripts/Angular/progressBar.js"));
            bundles.Add(new ScriptBundle("~/bundles/Custom").Include("~/Scripts/Custom/MyApp.js"));

        }
    }
}