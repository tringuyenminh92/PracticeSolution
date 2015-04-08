angular.module("GlobalModule").controller("muaHangController", MuaHangController);

MuaHangController.$inject = ['$scope', '$http'];
function MuaHangController($scope, $http) {
    $scope.$scope = $scope;
    $scope.hanghoas = [];
    $scope.nhomhanghoas = [];

    $scope.LoadHanghoaTheoNhomHanghoa = function () {
        $http.post("/MuaHang/LoadHanghoaTheoNhomHanghoa", { nhomHanghoaId: $scope.nhomHanghoaId }).success(function (data, status, headers, config) {
            $scope.hanghoas = data;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    };

    $scope.LoadNhomHanghoa = function () {
        $http.post("/MuaHang/LoadNhomHanghoa").success(function (data, status, headers, config) {
            $scope.nhomhanghoas = data;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    };

    var img = $("<img />").attr('src', 'http://somedomain.com/image.jpg')
    $scope.gridOptions = {};
    $scope.addCellTemplate = '<button ng-click="getExternalScopes().addHanghoa(row.entity)" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-plus"/></button> ';
    $scope.imageCellTemplate = '<img src="~/Content/images/image1.jpg" />';
    $scope.gridOptions.columnDefs = [
  	      { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 170 },
          { name: 'Code', displayName: 'Code', width: 80 },
          { name: 'Giagoc', displayName: 'Giá gốc', width: 80 },
          { name: '_hinhanh', displayName: '', enableFiltering: false, width: 100 },
          { name: '_addHanghoa', displayName: "", cellTemplate: $scope.addCellTemplate, width: 15, enableFiltering: false, enableCellEdit: false },
    ];

    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "hanghoas";
    $scope.gridOptions.enableFiltering = true;

    $scope.gridOptions1 = {};
    $scope.gridOptions1.columnDefs = [
  	      { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 170 },
          { name: 'Code', displayName: 'Code', width: 80 },
          { name: 'Giagoc', displayName: 'Giá gốc', width: 80 },
          { name: '_hinhanh', displayName: '', enableFiltering: false, width: 100 },
          { name: '_addHanghoa', displayName: "", cellTemplate: $scope.addCellTemplate, width: 15, enableFiltering: false, enableCellEdit: false },
    ];

    $scope.gridOptions1.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions1.paginationPageSize = 25;
    $scope.gridOptions1.data = "";
    $scope.gridOptions1.enableFiltering = true;
}