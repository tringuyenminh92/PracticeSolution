angular.module("GlobalModule").controller("userController", UserController);
UserController.$inject = ['$scope', '$http'];
function UserController($scope, $http) {
    $scope.$scope = $scope;
    $scope.myData = [];
    $scope.deleteRow = function (team) {
        //Push to server, delete and delete GUI        
        var index = $scope.myData.indexOf(team);
        alert(team);
        $http.post("User/DeleteAccount", { accountId: $scope.myData[index] });
        $scope.myData.splice(index, 1);
        //$scope.myData.
        //$scope.nhomHanghoaId = "55d8d06f-1d8b-4411-aa84-bfa4b398ffe9";
    };
    $scope.loadData = function () {
        $http.get("User/GetAllAccount").success(function (data, status, headers, config) {
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
  	      { name: 'AccountName', displayName: 'AccountName', headerCellTemplate: '<div title="Tooltip Content">Account Name</div>', width: 190, enableCellEdit: true },
          { name: 'AccountPassword', displayName: 'AccountPassword', enableCellEdit: true, width: 190 },
          { name: 'Ten', displayName: 'Ten', width: 190, enableCellEdit: true },
          { name: 'Email', displayName: 'Email', width: 185, enableCellEdit: true },
          { name: 'Mobile', displayName: 'Mobile', width: 170, enableCellEdit: true }

    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "myData";
    $scope.gridOptions.enableFiltering = true;
}