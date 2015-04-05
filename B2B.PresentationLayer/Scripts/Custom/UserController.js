angular.module("GlobalModule").controller("userController", UserController);
UserController.$inject = ['$scope', '$http'];
function UserController($scope, $http) {
    $scope.$scope = $scope;
    $scope.myData = [];
    $scope.deleteRow = function (team) {
        //Push to server, delete and delete GUI
        var index = $scope.myData.indexOf(team);
        $scope.myData.splice(index, 1);
        //$scope.nhomHanghoaId = "55d8d06f-1d8b-4411-aa84-bfa4b398ffe9";
    };
    $scope.loadData = function () {
        $http.get("User/GetUser").success(function (data, status, headers, config) {
            $scope.myData = data;
        }).error(function (data, status, headers, config) {
            // log 
            //var alertInstance = new Alert("alertId", "Load Failed", "danger");
            //alertInstance.ShowAlert();
        });
    };
    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.gridOptions.columnDefs = [
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
  	      { name: 'AccountName', displayName: 'AccountName', headerCellTemplate: '<div title="Tooltip Content">User name</div>', width: 150 },
          { name: 'AccountPassword', displayName: 'AccountPassword', width: 150 }
  	      //{ name: 'tuoi', displayName: 'tuoi', width: 50 }
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "myData";
    $scope.gridOptions.enableFiltering = true;