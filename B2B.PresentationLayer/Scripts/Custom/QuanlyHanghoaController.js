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
    $scope.activeCellTemplate = '<input type="checkbox" ng-checked="row.entity.Active">';
    $scope.gridOptions.columnDefs = [
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
  	      { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 150 },
          { name: 'Barcode', displayName: 'Barcode', width: 70 },
          { name: 'Giagoc', displayName: 'Giá gốc', width: 70 },
          { name: 'Active', displayName: 'Active', cellTemplate: $scope.activeCellTemplate, width: 50, enableFiltering: false, enableCellEdit: false },
          { name: 'NgayCapnhat', displayName: 'Ngày cập nhật', width: 70 },
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "lstHanghoa";
    $scope.gridOptions.enableFiltering = true;
}