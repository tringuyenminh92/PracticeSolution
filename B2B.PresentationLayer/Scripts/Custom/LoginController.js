/// <reference path="MyApp.js" />

angular.module("GlobalModule").controller("loginController", LoginController);

LoginController.$inject = ['$scope', '$http'];
function LoginController($scope, $http, $modalInstance) {
    $scope.$scope = $scope;
    $scope.accountname = "";
    $scope.accountpassword = "";
    $scope.checkLogin = function () {
        $http.post("/Login/CheckLoginUser", { account: $scope.accountname, password: $scope.accountpassword }).success(function (data, status, headers, config) {
            if (data) {
                if (data.result) {
                    alert("Đăng nhập thành công.");
                    window.location.href = '/Quote';
                }
                else {
                    alert("Đăng nhập không thành công.");
                    window.location.href = '/Taikhoan/Dangnhap';
                }
            }
        }).error(function (data, status, headers, config) {
            alert("Error");
        });
    }

}


