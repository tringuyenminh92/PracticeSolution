
angular.module("GlobalModule").controller("donhangController", DonhangController);

DonhangController.$inject = ['$scope', '$http'];

function DonhangController($scope, $http) {

    $scope.$scope = $scope;
    $scope.donhangs = [];
    $scope.chitietdonhang = [];
    $scope.isHienthiCtdh = false;

    $scope.LoadDonhang = function () {
        $http.get("Donhang/LoadDonhang").success(function (data, status, headers, config) {
            $scope.donhangs = data;
        }).error(function (data, status, headers, config) {
        });
    }

    //Load chi tiết đơn hàng theo mã đơn hàng và các chi tiết của đơn hàng
    $scope.getDonhangDetails = function (team) {
        $scope.donhang = team;
        if ($scope.donhang.SoDienthoai == null) { $scope.donhang.SoDienthoai = 'Chưa có'; }
        $scope.donhang.SoluongHang = 0;
        $http.post("/Donhang/LoadChitietDonhangTheoDonhang", { donhangId: team.DonhangId }).success(function (data, status, headers, config) {
            $scope.chitietdonhang = data;
            for (i = 0; i < $scope.chitietdonhang.length; i++) {
                if ($scope.chitietdonhang[i].LinkHinhanh_Web == null) {
                    $scope.chitietdonhang[i].LinkHinhanh_Web = "/Images/Hinhhanghoa/noPhoto-icon.png";
                }

                $scope.donhang.SoluongHang += $scope.chitietdonhang[i].Soluong;
            }
            $scope.isHienthiCtdh = true;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Load chi tiết đơn hàng không thành công');
        });
    };

    $scope.gridDonhang = {};
    $scope.detailsCellTemplate = '<button ng-click="getExternalScopes().getDonhangDetails(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-camera"/></button> ';
    $scope.gridDonhang.columnDefs = [
        { name: 'Code', displayName: 'Code', width: 95 },
  	    { name: 'NgaylapString', displayName: 'Ngày lập', width: 85 },
        { name: 'Tongtien', displayName: 'Tổng tiền', width: 80 },
        { name: 'TenTinhtrangDonhang', displayName: 'Tình trạng ', width: 130 },
        { name: 'Details', displayName: '', width: 15, cellTemplate: $scope.detailsCellTemplate, enableFiltering: false }
    ];
    $scope.gridDonhang.paginationPageSizes = [25, 50, 75];
    $scope.gridDonhang.paginationPageSize = 25;
    $scope.gridDonhang.data = "donhangs";
    $scope.gridDonhang.enableCellEdit = false;
    $scope.gridDonhang.enableFiltering = true;


    $scope.gridChitietDonhang = {};
    $scope.imageCellTemplate = '<img ng-src={{row.entity.LinkHinhanh_Web}} class="img-responsive" width="200" height="300">';
    $scope.gridChitietDonhang.columnDefs = [
        { name: '_hinhanh', displayName: '', cellTemplate: $scope.imageCellTemplate, enableFiltering: false, width: 80 },
        { name: 'Code', displayName: 'Code', width: 90 },
  	    { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 170 },
        { name: 'Soluong', displayName: 'Số lượng', width: 80 },
        { name: 'Giaban', displayName: 'Đơn giá', width: 100 },
        { name: 'Thanhtien', displayName: 'Thành tiền', width: 100 },
    ];

    $scope.gridChitietDonhang.paginationPageSizes = [25, 50, 75];
    $scope.gridChitietDonhang.paginationPageSize = 25;
    $scope.gridChitietDonhang.data = "chitietdonhang";
    $scope.gridChitietDonhang.enableCellEdit = false;
    $scope.gridChitietDonhang.enableFiltering = false;
    $scope.gridChitietDonhang.rowHeight = 80;
}

