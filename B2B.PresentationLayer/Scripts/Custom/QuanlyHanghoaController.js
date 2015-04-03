angular.module("GlobalModule").controller("quanlyHanghoaController", QuanlyHanghoaController);

QuanlyHanghoaController.$inject = ['$scope', '$http'];
function QuanlyHanghoaController($scope, $http) {
    $scope.$scope = $scope;
    $scope.lstHanghoa = [];
    $scope.deleteRow = function (team) {
        //Push to server, delete and delete GUI
        var index = $scope.lstHanghoa.indexOf(team);
        $scope.lstHanghoa.splice(index, 1);
    };

    $scope.LoadHanghoaTheoNhomHanghoa = function () {
        $http.get("QuanlyHanghoa/LoadHanghoaTheoNhomHanghoa").success(function (data, status, headers, config) {
            $scope.lstHanghoa = data;
        }).error(function (data, status, headers, config) {
            // log 
            var alertInstance = new Alert("alertId", "Load Failed", "danger");
            alertInstance.ShowAlert();
        });
    };

    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.gridOptions.columnDefs = [
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
  	      { name: '_TenHanghoa', displayName: 'Tên hàng hóa', headerCellTemplate: '<div title="Tooltip Content">Name</div>', width: 150 },
  	      { name: '_Code', displayName: 'Code', width: 50 },
          { name: '_Giagoc', displayName: 'Giá gốc', width: 50 }
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "lstHanghoa";
    $scope.gridOptions.enableFiltering = true;
}