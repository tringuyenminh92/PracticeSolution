angular.module("GlobalModule").controller("userController", UserController);
UserController.$inject = ['$scope', '$http'];
function UserController($scope, $http) {
    $scope.$scope = $scope;
    $scope.myData = [];
    $scope.deleteRow = function (team) {
        //Push to server, delete and delete GUI        
        var index = $scope.myData.indexOf(team);
        $http.post("User/DeleteAccount", { accountId: $scope.myData[index] });
        $scope.myData.splice(index, 1);
        //$scope.myData.
        //$scope.nhomHanghoaId = "55d8d06f-1d8b-4411-aa84-bfa4b398ffe9";
    };
    $scope.saveGrid = function () {
        $scope.dataSave = [];
        $scope.dataSave = $scope.myData;
        $http.post("User/SaveAllAccount", { listAccount: $scope.dataSave }).success(function (data, status, headers, config) {
            if (data) {
                alert("Success!");
            }
            else {
                alert("Fail!");
            }
        }).error(function (data, status, headers, config) {
            // log 
            //var alertInstance = new Alert("alertId", "Load Failed", "danger");
            //alertInstance.ShowAlert();
            alert("Error!");
        });
    };
    $scope.createNew = function () {
        window.location.href = '/Taikhoan/Dangky';
    };
    $scope.loadData = function () {
        $http.get("User/GetAllAccount").success(function (data, status, headers, config) {
            $scope.myData = data;
        }).error(function (data, status, headers, config) {
            // log 
            //var alertInstance = new Alert("alertId", "Load Failed", "danger");
            //alertInstance.ShowAlert();
            alert("Error");
        });
    };
    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.gridOptions.columnDefs = [
  	      { name: 'AccountName', displayName: 'Account Name', enableFiltering: false, headerCellTemplate: '<div title="Tooltip Content">Account Name</div>', width: 190, enableCellEdit: true },
          { name: 'AccountPassword', displayName: 'Password', enableFiltering: false, enableCellEdit: true, width: 190 },
          { name: 'Ten', displayName: 'Tên', width: 200, enableFiltering: false, enableCellEdit: true },
          { name: 'Email', displayName: 'Email', width: 190, enableFiltering: false, enableCellEdit: true },
          { name: 'Mobile', displayName: 'Mobile', width: 145, enableFiltering: false, enableCellEdit: true },
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false }

    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "myData";
    $scope.gridOptions.enableFiltering = true;
}