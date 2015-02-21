
angular.module("PMSModule").controller("hanghoaController", HanghoaController);

HanghoaController.$inject = ['$scope', '$http'];
function HanghoaController($scope, $http) {

    $http.get("Hanghoa/GetHanghoaItems").success(function (data, status, headers, config) {
        $scope.hanghoaItems = data;
    }).error(function (data, status, headers, config) {
        // log 
    });
}

