angular.module("GlobalModule").controller("changePasswordController", ChangePasswordController);
ChangePasswordController.$inject = ['$scope', '$http'];
function ChangePasswordController($scope, $http) {
    $scope.pass = { username: "", pass: "" };
    $scope.a = function () {
        $http.post("/Home/CheckSignUp", { user: $scope.account.username, pass: $scope.account.pass }).success(function (data, status, headers, config) {
            if (data.result) {
                alert("I am an alert box!");
            }

        }).error(function (data, status, headers, config) {
            // log 
            alert("I am an alert box bug!");
        });

    }

}