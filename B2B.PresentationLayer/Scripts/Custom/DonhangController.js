
angular.module("GlobalModule").controller("donhangController", DonhangController);

DonhangController.$inject = ['$scope', '$http', '$q'];

function DonhangController($scope, $http, $q) {

    $scope.$scope = $scope;
    $scope.donhangs = [];
    $scope.chitietdonhang = [];
    $scope.isHienthiCtdh = false;

    $scope.getNgaylapDonhangDautien = function () {
        var defer = $q.defer();
        $http.post("/Donhang/GetNgaylapDonhangDautien", { khachhangId: $scope.khachhang.KhachhangId }).success(function (data, status, headers, config) {
            $scope.datefrom = new Date();
            
            if (data.ngaylapdautien != null && data.ngaylapdautien != "")
            {
                $scope.datefrom = new Date(data.ngaylapdautien);
            }
            $scope.minDate = $scope.datefrom + "";
            $scope.dateto = new Date();
            defer.resolve(data);
        }).error(defer.reject);
        return defer.promise;
    }

    $scope.LayAccountId = function () {
        var defer = $q.defer();
        $http.post("/Taikhoan/LayAccountId").success(function (data, status, headers, config) {
            $scope.accountIdTmp = data.accountId;
            defer.resolve(data);
        }).error(defer.reject);
        return defer.promise;
    }

    $scope.LayThongtinTaikhoan = function () {
        var defer = $q.defer();
        $http.post("/Taikhoan/HienthiThongtinTaikhoan", { accountId: $scope.accountIdTmp }).success(function (data, status, headers, config) {
            $scope.account = data.acc;
            $scope.khachhang = data.kh;
            defer.resolve(data);
        }).error(defer.reject);
        return defer.promise;
    }

    $scope.InitXemlichsuMuahang = function () {
        $scope.LayAccountId().then($scope.LayThongtinTaikhoan).then($scope.getNgaylapDonhangDautien).then($scope.LodDonhangTungayDenngay);
    }

    $scope.LoadDonhang = function () {
        $http.get("/Donhang/LoadDonhang").success(function (data, status, headers, config) {
            $scope.donhangs = data;
        }).error(function (data, status, headers, config) {
            alert('Lỗi load đơn hàng');
        });
    }

    $scope.LodDonhangTungayDenngay = function () {
        if($scope.datefrom > $scope.dateto)
        {
            alert('Từ ngày phải nhỏ hơn đến ngày.')
        }
        else
        {
            //var tu = $scope.datefrom.toString();
            //var den = $scope.dateto.toString();
            //alert(tu);
            $http.post("/Donhang/LoadDonhangTungayDenngay", { tungay: $scope.datefrom, denngay: $scope.dateto, khachhangId: $scope.khachhang.KhachhangId }).success(function (data, status, headers, config) {
                $scope.donhangs = data;
            }).error(function (data, status, headers, config) {
                alert('Lỗi load đơn hàng từ ngày đến ngày');
            });
        }
    }

    //Load chi tiết đơn hàng theo mã đơn hàng và các chi tiết của đơn hàng
    $scope.getDonhangDetails = function (team) {
        $scope.donhang = team;
        if ($scope.donhang.SoDienthoai == null) { $scope.donhang.SoDienthoai = 'Chưa có'; }
        $scope.donhang.SoluongHang = 0;
        $http.post("/Donhang/LoadChitietDonhangTheoDonhang", { donhangId: team.DonhangId }).success(function (data, status, headers, config) {
            var stt = 0;
            $scope.chitietdonhang = data;
            for (i = 0; i < $scope.chitietdonhang.length; i++) {
                if ($scope.chitietdonhang[i].LinkHinhanh_Web == null) {
                    $scope.chitietdonhang[i].LinkHinhanh_Web = "/Images/Hinhhanghoa/noPhoto-icon.png";
                }
                stt = stt + 1;
                $scope.chitietdonhang[i].STT = stt;
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
        { name: 'Code', displayName: 'Code', width: 150 },
  	    { name: 'NgaylapString', displayName: 'Ngày lập', width: 85 },
        { name: 'Tongtien', displayName: 'Tổng tiền', cellFilter: 'number', width: 120 },
        { name: 'TenTinhtrangDonhang', displayName: 'Tình trạng ', width: 170 },
        { name: 'Details', displayName: '', width: 15, cellTemplate: $scope.detailsCellTemplate, enableFiltering: false }
    ];
    $scope.gridDonhang.paginationPageSizes = [10, 15, 30];
    $scope.gridDonhang.paginationPageSize = 10;
    $scope.gridDonhang.data = "donhangs";
    $scope.gridDonhang.enableCellEdit = false;
    $scope.gridDonhang.enableFiltering = true;


    $scope.gridChitietDonhang = {};
    $scope.imageCellTemplate = '<img ng-src={{row.entity.LinkHinhanh_Web}} class="img-responsive" width="200" height="300">';
    $scope.dacdiemCellTemplate = '<ul style="margin-left:-35px; margin-top:5px; list-style-type:none"><li ng-repeat="dd in row.entity.ThuoctinhHanghoaItems">{{ dd.TenThuoctinh }}</li></ul>';
    $scope.gridChitietDonhang.columnDefs = [
        { name: 'STT', displayName: 'STT', width: 50, enableFiltering: false },
        { name: '_hinhanh', displayName: '', cellTemplate: $scope.imageCellTemplate, width: 100 },
        { name: 'Code', displayName: 'Code', width: 150 },
  	    { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 220 },
        { name: '_dacdiem', displayName: 'Đặc điểm', cellTemplate: $scope.dacdiemCellTemplate, width: 255 },
        { name: 'Soluong', displayName: 'Số lượng', width: 80 },
        { name: 'Giaban', displayName: 'Đơn giá', cellFilter: 'number', width: 150 },
        { name: 'Thanhtien', displayName: 'Thành tiền', cellFilter: 'number', width: 150 },
    ];

    $scope.gridChitietDonhang.paginationPageSizes = [5, 10, 20];
    $scope.gridChitietDonhang.paginationPageSize = 5;
    $scope.gridChitietDonhang.data = "chitietdonhang";
    $scope.gridChitietDonhang.enableCellEdit = false;
    $scope.gridChitietDonhang.enableFiltering = false;
    $scope.gridChitietDonhang.rowHeight = 100;


    //Datetime Picker
    $scope.open1 = function ($event) {
        $event.preventDefault();
        $event.stopPropagation();

        $scope.opened1 = true;
    };
    $scope.open2 = function ($event) {
        $event.preventDefault();
        $event.stopPropagation();

        $scope.opened2 = true;
    };
    $scope.format = 'dd/MM/yyyy';

    $scope.dateOptions = {
        formatYear: 'yy',
        startingDay: 1
    };

    $scope.maxDate = new Date() + "";
}

