
angular.module("GlobalModule").controller("homeController", HomeController);

HomeController.$inject = ['$scope','$http'];
function HomeController($scope, $http) {
    $scope.account = { username: "", pass: "" };
    $scope.XulyDangnhap = function () {
        $http.post("/Home/CheckSignUp", { user: $scope.account.username, pass: $scope.account.pass }).success(function (data, status, headers, config) {
            if(data)
            {
               
            }

        }).error(function (data, status, headers, config) {
            // log 
            //var al = new Alert("alertId", "Load Failed", "danger");
            //al.ShowAlert();
        });
        $scope.account.username

    }

}
