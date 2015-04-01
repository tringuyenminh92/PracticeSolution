/// <reference path="MyApp.js" />

angular.module("GlobalModule").controller("loginController", LoginController);

LoginController.$inject = ['$scope', '$http'];
function LoginController($scope, $http, $modalInstance) {
    $scope.$scope = $scope;
    $scope.myAccount = { username: "", password: "" };
    //$scope.User = { UserId: "", _Username: "", _Password: "", NhanvienId: "", Active: "", Step: "", Version: "" };
    $scope.checkLogin=function()
    {
        $http.post("CheckLogin", { user: $scope.myAccount.username, password: $scope.myAccount.password }).success(function (data, status, headers, config) {
            if (data) {
                if (data.result) {
                    alert("Success!");
                    //Chuyen trang neu thanh cong
                    window.location.href='/Quote';
                }
                else {
                    alert("Fail");                    
                }
            }

        }).error(function (data, status, headers, config) {
            alert("Error");
        });
    }
    //$scope.checkLoginUser=function()
    //{
    //    $http.post("CheckLogin",{User:$scope.User}).success(function(data))
    //}
}


