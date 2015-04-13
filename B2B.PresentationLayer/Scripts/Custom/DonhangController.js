
angular.module("GlobalModule").controller("donhangController", DonhangController);

DonhangController.$inject = ['$scope', '$http'];

function DonhangController($scope, $http) {

    $scope.$scope = $scope;
    $scope.myData = [];


    $scope.LoadDonhang = function () {
        $http.get("Donhang/GetHanghoa", { ngaylap: $scope.ngaylap, loaiDonhang: $scope.loaiDonhang }).success(function (data, status, headers, config) {
            $scope.myData = data;
        }).error(function (data, status, headers, config) {
        });
    }

    $scope.gridHoadon = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.detailsCellTemplate = '<button ng-click="getExternalScopes().getDetails(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-camera"/></button> ';
    $scope.gridHoadon.columnDefs = [
        { name: 'Code', displayName: 'Code', width: 80, enableCellEdit: false },
  	    { name: 'Ngaylap', displayName: 'Ngày lập', width: 170, enableCellEdit: false },
        { name: 'Soluong', displayName: 'Số lượng', width: 80, enableCellEdit: true },
        { name: 'Giaban', displayName: 'Đơn giá', width: 100, enableCellEdit: false },
        { name: 'TenTinhtrangDonhang', displayName: 'Tình trạng ', width: 100, enableCellEdit: false }
    ];
    $scope.gridHoadon.paginationPageSizes = [25, 50, 75];
    $scope.gridHoadon.paginationPageSize = 25;
    $scope.gridHoadon.data = "myData";
    $scope.gridHoadon.enableFiltering = false;
}

