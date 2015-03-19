﻿
angular.module("GlobalModule").controller("homeController", HomeController);

HomeController.$inject = ['$scope','$http'];
function HomeController($scope, $http) {
    $scope.account = { username: "", pass: "" };
    $scope.CheckSignUp = function () {
        $http.post("/Home/CheckSignUp", { user: $scope.account.username, pass: $scope.account.pass }).success(function (data, status, headers, config) {
            if(data.result)
            {
                alert("I am an alert box!");
            }

        }).error(function (data, status, headers, config) {
            // log 
            alert("I am an alert box bug!");
        });

    }

}
