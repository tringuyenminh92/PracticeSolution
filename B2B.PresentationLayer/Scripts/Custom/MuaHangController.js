angular.module("GlobalModule").controller("muaHangController", MuaHangController);

MuaHangController.$inject = ['$scope', '$http', '$q'];
function MuaHangController($scope, $http, $q) {
    $scope.$scope = $scope;
    $scope.hanghoas = [];
    $scope.nhomhanghoas = [];
    //$scope.chitietdonhangs = [
    //    //{
    //    //_STT: "1",
    //    //Code: "Test", TenHanghoa: "TestABC", Soluong: "2", Giaban: "1000",
    //    //Thanhtien: "2000"
    //    //}
    //];
    $scope.tongtien = 0;
    $scope.tiengiam = 0;
    $scope.phantramgiam = "0%";

    $scope.LoadHanghoaTheoNhomHanghoa = function () {
        $http.post("/MuaHang/LoadHanghoaTheoNhomHanghoa", { nhomHanghoaId: $scope.nhomHanghoaId }).success(function (data, status, headers, config) {
            $scope.hanghoas = data;
            for(i = 0; i<$scope.hanghoas.length; i++){
                if ($scope.hanghoas[i].LinkHinhanh_Web == null)
                {
                    $scope.hanghoas[i].LinkHinhanh_Web = "/Images/Hinhhanghoa/noPhoto-icon.png";
                }
            }
        }).error(function (data, status, headers, config) {
            // log 
            alert('Load hàng hóa không thành công');
        });
    };

    $scope.LoadNhomHanghoa = function () {
        $http.post("/MuaHang/LoadNhomHanghoa").success(function (data, status, headers, config) {
            $scope.nhomhanghoas = data;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Load nhóm hàng không thành công');
        });
    };

    $scope.LayDonhangTam = function () {
        $http.post("/MuaHang/LayDonhangTam").success(function (data, status, headers, config) {
            $scope.chitietdonhangs = [];
            $scope.donhang = { Tiengiam: 0, PhantramGiam : 0,Tongtien: 0, TongLoaiDonhang: 0, Active: 1 };
            if (data.lst != null) {
                $scope.chitietdonhangs = data.lst;
                $scope.donhang = data.dh;
            }
        }).error(function (data, status, headers, config) {
            // log 
            alert('Load chi tiết đơn hàng tạm không thành công');
        });
    }

    $scope.Dathang = function () {

    }

    $scope.Reset = function () {
        $scope.chitietdonhangs = [];
        $scope.tongtien = 0;
        $scope.tiengiam = 0;
        $scope.phantramgiam = "0%";
    }

    //Lấy Account để kiểm tra đã đăng nhập chưa và có đầy đủ thông tin chưa
    $scope.LayAccountId = function () {
        var defer = $q.defer();
        $http.post("/Taikhoan/LayAccountId").success(function (data, status, headers, config) {
            $scope.accountIdTmp = data.accountId;
            defer.resolve(data);
        }).error(defer.reject);
        return defer.promise;
    }
    
    $scope.XulyDathang = function () {
        if ($scope.chitietdonhangs.length == 0) {
            alert('Đơn hàng rỗng.');
        }
        else {
            if ($scope.accountIdTmp == "") {
                alert('Bạn cần đăng nhập để sử dụng chức năng này.');
            }
            else {
                window.location.href = "/MuaHang/ChonDiachigiaohang";
            }
        }
    }

    $scope.Dathang = function () {
        $scope.LayAccountId().then($scope.XulyDathang);
    }

    $scope.KiemtraDiachiGiaohang = function () {
        if ($scope.khachhang.DiachiGiaohang == null || $scope.khachhang.QuanhuyenId == null || $scope.khachhang.TinhthanhId == null) {
            $scope.ChuacoDiachi = true;
        }
        else $scope.ChuacoDiachi = false;
    }

    //Hàm lấy các thông tin của account đang được sử dụng
    $scope.LayThongtinTaikhoan = function () {
        var defer = $q.defer();
        $http.post("/Taikhoan/HienthiThongtinTaikhoan", { accountId: $scope.accountIdTmp }).success(function (data, status, headers, config) {
            $scope.account = data.acc;
            $scope.khachhang = data.kh;
            $scope.accountNameTmp = data.acc.AccountName;
            if ($scope.khachhang.Gioitinh == null) {
                $scope.khachhang.Gioitinh = true;
            }
            defer.resolve(data);
        }).error(defer.reject);
        return defer.promise;
    }

    //Load tinh thanh
    $scope.HienthiTinhthanh = function () {
        var defer = $q.defer();
        $http.post("/Taikhoan/HienthiTinhthanh").success(function (data, status, headers, config) {
            if (data) {
                $scope.tinhthanhs = data;
                defer.resolve(data);
            }
        }).error(defer.reject);
        return defer.promise;
    }

    //Load quan huyen theo tinh thanh
    $scope.HienthiQuanhuyen = function () {
        var defer = $q.defer();
        if ($scope.khachhang.TinhthanhId == null) {
            $scope.quanhuyens = [];
            $scope.khachhang.QuanhuyenId = null;
        }
        else {
            $http.post("/Taikhoan/HienthiQuanhuyen", { tinhthanhId: $scope.khachhang.TinhthanhId }).success(function (data, status, headers, config) {
                if (data) {
                    $scope.quanhuyens = data;
                }
            }).error(defer.reject);
        }
        return defer.promise;
    }

    $scope.InitChonDiachiGiaohang = function () {
        $scope.LayAccountId().then($scope.LayThongtinTaikhoan).then($scope.KiemtraDiachiGiaohang).then($scope.HienthiTinhthanh).then($scope.HienthiQuanhuyen);
    }

    $scope.addHanghoa = function (team) {
        var ctdh = {
            STT: $scope.chitietdonhangs.length + 1,
            Code: team.Code,
            HanghoaId : team.HanghoaId,
            TenHanghoa: team.TenHanghoa,
            Giaban: team.Giagoc,
            VAT: 0,
            Soluong: 1,
            Tiengiam: 0,
            PhantramGiam: 0,
            Thanhtien: team.Giagoc,
            SoluongGiao: 0,
            SoluongConlai : 1
        };
        $scope.chitietdonhangs.push(ctdh);
        $scope.tongtien += ctdh.Thanhtien;
        $http.post("/MuaHang/CapnhatDSChitietDonhangTam", { lstChitietDonhangTam: $scope.chitietdonhangs }).success(function (data, status, headers, config) {
        }).error(function (data, status, headers, config) {
            // log 
            alert('Cập nhật chi tiết đơn hàng tạm không thành công');
        });
    };

    var img = $("<img />").attr('src', 'http://somedomain.com/image.jpg')
    $scope.gridOptions = {};
    $scope.addCellTemplate = '<button ng-click="getExternalScopes().addHanghoa(row.entity)" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-shopping-cart"/></button> ';
    $scope.imageCellTemplate = '<img ng-src={{row.entity.LinkHinhanh_Web}} class="img-responsive" width="200" height="300">';
    $scope.gridOptions.columnDefs = [
        { name: '_hinhanh', displayName: '', cellTemplate: $scope.imageCellTemplate, enableFiltering: false, width: 80 },
        { name: 'Code', displayName: 'Code', width: 80 },
  	    { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 150 },
        { name: 'Giagoc', displayName: 'Giá gốc', width: 80 },
        { name: '_addHanghoa', displayName: "", cellTemplate: $scope.addCellTemplate, width: 15, enableFiltering: false },
    ];

    $scope.gridOptions.paginationPageSizes = [10, 25, 50];
    $scope.gridOptions.paginationPageSize = 10;
    $scope.gridOptions.data = "hanghoas";
    $scope.gridOptions.enableFiltering = true;
    $scope.gridOptions.rowHeight = 80;


    $scope.removeHanghoa = function (team) {
        //Push to server, delete and delete GUI
        var index = $scope.chitietdonhangs.indexOf(team);
        $scope.chitietdonhangs.splice(index, 1);
        $scope.tongtien -= team.Thanhtien;
        for (i = index; i < $scope.chitietdonhangs.length; i++) {
            $scope.chitietdonhangs[i].STT = $scope.chitietdonhangs[i].STT - 1;
        }
        $http.post("/MuaHang/CapnhatDSChitietDonhangTam", { lstChitietDonhangTam: $scope.chitietdonhangs }).success(function (data, status, headers, config) {
        }).error(function (data, status, headers, config) {
            // log 
            alert('Cập nhật chi tiết đơn hàng tạm không thành công');
        });
    };

    //$scope.Test() = function () {
    //    alert('test');
    //}

    $scope.gridOptions1 = {};
    $scope.removeCellTemplate = '<button ng-click="getExternalScopes().removeHanghoa(row.entity)" class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-trash"/></button> ';
    //$scope.soluongCellTemplate = '<input type="number" ng-change=$scope.Test()>';
    $scope.gridOptions1.columnDefs = [
        { name: 'STT', displayName: 'STT', width: 60, enableFiltering: false, enableCellEdit: false },
        { name: 'Code', displayName: 'Code', width: 80, enableCellEdit: false },
  	    { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 170, enableCellEdit: false },
        { name: 'Soluong', displayName: 'Số lượng', width: 80, enableCellEdit: true },
        { name: 'Giaban', displayName: 'Đơn giá', width: 100, enableCellEdit: false },
        { name: 'Thanhtien', displayName: 'Thành tiền', width: 100, enableCellEdit: false },
        { name: '_removeHanghoa', displayName: "", cellTemplate: $scope.removeCellTemplate, width: 15, enableFiltering: false, enableCellEdit: false },
    ];

    $scope.gridOptions1.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions1.paginationPageSize = 25;
    $scope.gridOptions1.data = "chitietdonhangs";
    $scope.gridOptions1.enableFiltering = false;

    $scope.gridOptions1.onRegisterApi = function (gridApi) {
        //set gridApi on scope
        $scope.gridApi = gridApi;
        gridApi.edit.on.afterCellEdit($scope, function (rowEntity, colDef, newValue, oldValue) {
            //$scope.msg.lastCellEdited = 'edited row id:' + rowEntity.id + ' Column:' + colDef.name + ' newValue:' + newValue + ' oldValue:' + oldValue;
            if (colDef.name == 'Soluong') {
                if (newValue <= 0) { newValue = 1; rowEntity.Soluong = 1; }
                rowEntity.Thanhtien = newValue * rowEntity.Giaban;
                rowEntity.SoluongConlai = newValue;
            }
            
            $scope.tongtien -= oldValue * rowEntity.Giaban;
            $scope.tongtien += rowEntity.Thanhtien;
            $scope.$apply();
            $http.post("/MuaHang/CapnhatDSChitietDonhangTam", { lstChitietDonhangTam: $scope.chitietdonhangs }).success(function (data, status, headers, config) {
            }).error(function (data, status, headers, config) {
                // log 
                alert('Cập nhật chi tiết đơn hàng tạm không thành công');
            });
        });
    };

    $scope.ThaydoiThongtinKhachhang = function () {
        $http.post("/Taikhoan/ThaydoiThongtinKhachhang", { khachhang: $scope.khachhang }).success(function (data, status, headers, config) {
            alert(data.thongbao);
            window.location.reload();
        }).error(function (data, status, headers, config) {
            // log 
            alert("Lỗi thay đổi thông tin khách hàng.");
        });
    }

    $scope.ThemDcGh = false;
    $scope.MuonthemDiachiGiaohang = function () {
        $scope.ThemDcGh = true;
    }
}