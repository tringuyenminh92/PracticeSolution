
angular.module("GlobalModule").controller("donhangController", DonhangController);

DonhangController.$inject = ['$scope', '$http'];

function DonhangController($scope, $http) {

    $scope.$scope = $scope;
    $scope.donhangs = [];
    $scope.chitiethoadons = [];

    $scope.LoadDonhang = function () {
        $http.get("Donhang/GetHanghoa", { ngaylap: $scope.ngaylap, loaiDonhang: $scope.loaiDonhang }).success(function (data, status, headers, config) {
            $scope.donhangs = data;
        }).error(function (data, status, headers, config) {
        });
    }

    $scope.gridDonhang = {};
    $scope.gridDonhang.columnDefs = [
        { name: 'Code', displayName: 'Code', width: 80, enableCellEdit: false },
  	    { name: 'Ngaylap', displayName: 'Ngày lập', width: 85, enableCellEdit: false },
        { name: 'Tongtien', displayName: 'Tổng tiền', width: 80, enableCellEdit: true },
        { name: 'TenTinhtrangDonhang', displayName: 'Tình trạng ', width: 100, enableCellEdit: false }
    ];
    $scope.gridDonhang.paginationPageSizes = [25, 50, 75];
    $scope.gridDonhang.paginationPageSize = 25;
    $scope.gridDonhang.data = "donhangs";
    $scope.gridDonhang.enableFiltering = false;


    $scope.gridChitietDonhang = {};
    $scope.gridChitietDonhang.columnDefs = [
        { name: '_STT', displayName: 'STT', width: 60, enableFiltering: false, enableCellEdit: false },
        { name: 'Code', displayName: 'Code', width: 80, enableCellEdit: false },
  	    { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 170, enableCellEdit: false },
        { name: 'Soluong', displayName: 'Số lượng', width: 80, enableCellEdit: true },
        { name: 'Giaban', displayName: 'Đơn giá', width: 100, enableCellEdit: false },
        { name: 'Thanhtien', displayName: 'Thành tiền', width: 100, enableCellEdit: false },
    ];

    $scope.gridChitietDonhang.paginationPageSizes = [25, 50, 75];
    $scope.gridChitietDonhang.paginationPageSize = 25;
    $scope.gridChitietDonhang.data = "chitiethoadons";
    $scope.gridChitietDonhang.enableFiltering = false;
}

