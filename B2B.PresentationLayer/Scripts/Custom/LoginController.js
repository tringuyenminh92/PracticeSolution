/// <reference path="MyApp.js" />

angular.module("GlobalModule").controller("loginController", LoginController);

LoginController.$inject = ['$scope', '$http'];
function LoginController($scope, $http, $modalInstance) {
    $scope.$scope = $scope;
    $scope.accountname = "";
    $scope.accountpassword = "";
    $scope.abc = "abc";
    $scope.checkLogin = function () {
        $http.post("CheckLoginUser", { account: $scope.accountname, password: $scope.accountpassword }).success(function (data, status, headers, config) {
            if (data) {
                if (data.result) {
                    alert("Success");
                    window.location.href = '/Quote';
                }
                else {
                    alert("Fail");
                    window.location.href = '/Login';
                }
            }
        }).error(function (data, status, headers, config) {
            alert("Error");
        });
    }

}


