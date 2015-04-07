angular.module("GlobalModule").controller("quanlyHanghoaController", QuanlyHanghoaController);

QuanlyHanghoaController.$inject = ['$scope', '$http'];
function QuanlyHanghoaController($scope, $http) {
    $scope.$scope = $scope;
    $scope.lstHanghoa = [];
    $scope.lstNhomHanghoa = [];

    $scope.deleteRow = function (team) {
        //Push to server, delete and delete GUI
        var index = $scope.lstHanghoa.indexOf(team);
        $scope.lstHanghoa.splice(index, 1);
    };

    $scope.LoadHanghoaTheoNhomHanghoa = function () {
        $http.get("QuanlyHanghoa/LoadHanghoaTheoNhomHanghoa", { nhomHanghoaId: $scope.nhomHanghoaId }).success(function (data, status, headers, config) {
            $scope.lstHanghoa = data;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    };

    $scope.LoadNhomHanghoa = function () {
        $http.get("QuanlyHanghoa/LoadNhomHanghoa").success(function (data, status, headers, config) {
            $scope.lstNhomHanghoa = data;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    };

    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.editCellTemplate = '<button ng-click="getExternalScopes().editRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-pencil"/></button> ';
    $scope.activeCellTemplate = '<input type="checkbox" ng-checked="row.entity.Active">';
    $scope.gridOptions.columnDefs = [
  	      { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 150 },
          { name: 'Giagoc', displayName: 'Giá gốc', width: 70 },
          { name: 'Active', displayName: 'Active', cellTemplate: $scope.activeCellTemplate, width: 60, enableFiltering: false, enableCellEdit: false },
          { name: 'NgayCapnhat', displayName: 'Cập nhật', width: 100 },
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
          { name: '_edit', displayName: "", cellTemplate: $scope.editCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "lstHanghoa";
    $scope.gridOptions.enableFiltering = true;
}