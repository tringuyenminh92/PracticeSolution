
angular.module("GlobalModule").controller("homeController", HomeController);

HomeController.$inject = ['$scope', '$http','notifyService'];
function HomeController($scope, $http, notifyService) {
    $scope.selectedObject = {}// $scope.dropdownMenu[0];
    $scope.account = { username: "", pass: "" };

    $scope.eventWhenChange = function () {
        $http.post("/Home/LoadData").success(function (data, status, headers, config) {
            if (data) {
                $scope.dropdownMenu = data;
            }

        }).error(function (data, status, headers, config) {
            // log 
            alert("I am an alert box bug!");
        });

    }
    //gird

    //$scope.myData = [{ name: "1", id: 3 }, { name: "1", id: 3 }, { name: "1", id: 3 }, { name: "1", id: 3 }];
    $scope.loadData = function () {
        $http.get("/Home/GetGridHanghoas").success(function (data, status, headers, config) {
            if (data) {
                $scope.myData = data;
            }

        }).error(function (data, status, headers, config) {
            // log 
            alert("I am an alert box bug!");
        });
    }
    $scope.gridOptions = { data: 'myData' };


    $scope.CheckSignUp = function () {
        $http.post("/Home/CheckSignUp", { user: $scope.account.username, pass: $scope.account.pass }).success(function (data, status, headers, config) {
            if (data) {
                alert("I am an alert box!");
            }

        }).error(function (data, status, headers, config) {
            // log 
            alert("I am an alert box bug!");
        });

    }
}
