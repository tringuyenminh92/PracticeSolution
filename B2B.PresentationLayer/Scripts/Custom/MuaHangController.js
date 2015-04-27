angular.module("GlobalModule").controller("muaHangController", MuaHangController);

MuaHangController.$inject = ['$scope', '$http', '$q', '$modal', '$log'];
function MuaHangController($scope, $http, $q, $modal, $log) {
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
    //$scope.tongtien = 0;
    //$scope.tiengiam = 0;
    //$scope.phantramgiam = "0%";

    //Load hàng hóa
    $scope.LoadHanghoaTheoNhomHanghoa = function () {
        $http.post("/MuaHang/LoadHanghoaTheoNhomHanghoa", { nhomHanghoaId: $scope.nhomHanghoaId }).success(function (data, status, headers, config) {
            $scope.hanghoas = data;
            for (i = 0; i < $scope.hanghoas.length; i++) {
                if ($scope.hanghoas[i].LinkHinhanh_Web == null) {
                    $scope.hanghoas[i].LinkHinhanh_Web = "/Images/Hinhhanghoa/noPhoto-icon.png";
                }
            }
        }).error(function (data, status, headers, config) {
            // log 
            alert('Load hàng hóa không thành công');
        });
    };

    //Load nhóm hàng hóa
    $scope.LoadNhomHanghoa = function () {
        $http.post("/MuaHang/LoadNhomHanghoa").success(function (data, status, headers, config) {
            $scope.nhomhanghoas = data;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Load nhóm hàng không thành công');
        });
    };

    //Load session đơn hàng
    $scope.LayDonhangTam = function () {
        var defer = $q.defer();
        $http.post("/MuaHang/LayDonhangTam").success(function (data, status, headers, config) {
            $scope.chitietdonhangs = [];
            $scope.donhang = { Tiengiam: 0, PhantramGiam: 0, Tongtien: 0, LoaiDonhang: 0, Active: 1 };
            if (data.lst != null) {
                $scope.chitietdonhangs = data.lst;
                $scope.donhang = data.dh;
                $scope.tongsoHang = 0;
                for (i = 0; i < $scope.chitietdonhangs.length; ++i)
                {
                    $scope.tongsoHang += $scope.chitietdonhangs[i].Soluong;
                }
            }
        }).error(defer.reject);
        return defer.promise;
    }

    //Reset khi khách hàng bấm hủy ở form mua hàng
    $scope.Reset = function () {
        $scope.chitietdonhangs = [];
        $scope.donhang.Tongtien = 0;
        $scope.donhang.Tiengiam = 0;
        $scope.donhang.PhantramGiam = 0;
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

    //Xử lý nút đặt hàng
    $scope.Dathang = function () {
        $scope.LayAccountId().then($scope.XulyDathang);
    }

    //Kiểm tra khách hàng đã điền địa chỉ giao hàng/quận/huyện trong account của mình chưa
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

            //Hiển thị số điện thoại của khách hàng
            $scope.dienthoai = "Chưa có";
            if ($scope.khachhang.Tel == null && $scope.khachhang.Mobile != null) {
                $scope.dienthoai = $scope.khachhang.Mobile;
            } else if ($scope.khachhang.Tel != null && $scope.khachhang.Mobile == null) {
                $scope.dienthoai = $scope.khachhang.Tel;
            } else if ($scope.khachhang.Tel != null && $scope.khachhang.Mobile != null) {
                $scope.dienthoai = $scope.khachhang.Tel + " - " + $scope.khachhang.Mobile;
            }
            defer.resolve(data);
        }).error(defer.reject);
        return defer.promise;
    }

    //Load tinh thanh - bổ sung địa chỉ giao hàng
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

    //Load quan huyen theo tinh thanh - bổ sung địa chỉ giao hàng
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

    //Hàm add hàng hóa vào chi tiết hàng hóa
    $scope.addHanghoa = function (team) {
        var ctdh = {
            STT: $scope.chitietdonhangs.length + 1,
            Code: team.Code,
            HanghoaId: team.HanghoaId,
            TenHanghoa: team.TenHanghoa,
            Giaban: team.Giagoc,
            VAT: 0,
            Soluong: 1,
            Tiengiam: 0,
            PhantramGiam: 0,
            Thanhtien: team.Giagoc,
            SoluongGiao: 0,
            SoluongConlai: 1
        };
        $scope.chitietdonhangs.push(ctdh);
        $scope.donhang.Tongtien += ctdh.Thanhtien;
        //Cập nhật lại session hóa đơn và chi tiết hóa đơn
        $http.post("/MuaHang/CapnhatDonhangTam", { lstChitietDonhangTam: $scope.chitietdonhangs, donhang: $scope.donhang }).success(function (data, status, headers, config) {
        }).error(function (data, status, headers, config) {
            alert('Cập nhật đơn hàng tạm không thành công');
        });
    };

    $scope.gridOptions = {};
    $scope.addCellTemplate = '<button ng-click="getExternalScopes().addHanghoa(row.entity)" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-shopping-cart"/></button> ';
    $scope.imageCellTemplate = '<img ng-src={{row.entity.LinkHinhanh_Web}} ng-click="getExternalScopes().openModalChitietHanghoa(row.entity)" class="img-responsive" width="200" height="300">';
    //$scope.imageCellTemplate = '<button class="btn btn-default" ng-click="getExternalScopes().openModalChitietHanghoa()">Open me!</button>';
    $scope.gridOptions.columnDefs = [
        { name: '_hinhanh', displayName: '', cellTemplate: $scope.imageCellTemplate, enableFiltering: false, width: '20%' },
        { name: 'Code', displayName: 'Code', width: '15%' },
  	    { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: '40%' },
        { name: 'Giagoc', displayName: 'Giá gốc', cellFilter: 'number', width: '17%' },
        { name: '_addHanghoa', displayName: "", cellTemplate: $scope.addCellTemplate, width: '8%', enableFiltering: false },
    ];

    $scope.gridOptions.paginationPageSizes = [10, 25, 50];
    $scope.gridOptions.paginationPageSize = 10;
    $scope.gridOptions.data = "hanghoas";
    $scope.gridOptions.enableFiltering = true;
    $scope.gridOptions.rowHeight = 80;

    //Hàm remove hàng hóa khỏi chi tiết hàng hóa
    $scope.removeHanghoa = function (team) {
        //Push to server, delete and delete GUI
        var index = $scope.chitietdonhangs.indexOf(team);
        $scope.chitietdonhangs.splice(index, 1);
        $scope.donhang.Tongtien -= team.Thanhtien;
        for (i = index; i < $scope.chitietdonhangs.length; i++) {
            $scope.chitietdonhangs[i].STT = $scope.chitietdonhangs[i].STT - 1;
        }
        //Cập nhật lại session hóa đơn và chi tiết hóa đơn
        $http.post("/MuaHang/CapnhatDonhangTam", { lstChitietDonhangTam: $scope.chitietdonhangs, donhang: $scope.donhang }).success(function (data, status, headers, config) {
        }).error(function (data, status, headers, config) {
            // log 
            alert('Cập nhật đơn hàng tạm không thành công');
        });
    };

    $scope.gridOptions1 = {};
    $scope.removeCellTemplate = '<button ng-click="getExternalScopes().removeHanghoa(row.entity)" class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-trash"/></button> ';
    //$scope.soluongCellTemplate = '<input type="number" ng-change=$scope.Test()>';
    $scope.gridOptions1.columnDefs = [
        { name: 'STT', displayName: 'STT', width: '5%', enableFiltering: false, enableCellEdit: false },
        { name: 'Code', displayName: 'Code', width: '10%', enableCellEdit: false },
  	    { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: '35%', enableCellEdit: false },
        { name: 'Soluong', displayName: 'Số lượng', width: '10%', enableCellEdit: true },
        { name: 'Giaban', displayName: 'Đơn giá', cellFilter: 'number', width: '10%', enableCellEdit: false },
        { name: 'Thanhtien', displayName: 'Thành tiền', cellFilter: 'number', width: '20%', enableCellEdit: false },
        { name: '_removeHanghoa', displayName: "Xoá", cellTemplate: $scope.removeCellTemplate, width: '10%', enableFiltering: false, enableCellEdit: false },
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

            $scope.donhang.Tongtien -= oldValue * rowEntity.Giaban;
            $scope.donhang.Tongtien += rowEntity.Thanhtien;
            $scope.$apply();
            $http.post("/MuaHang/CapnhatDonhangTam", { lstChitietDonhangTam: $scope.chitietdonhangs, donhang: $scope.donhang }).success(function (data, status, headers, config) {
            }).error(function (data, status, headers, config) {
                // log 
                alert('Cập nhật đơn hàng tạm không thành công');
            });
        });
    };

    //Các hàm xử lý riêng trong trang chọn địa chỉ giao hàng

    //Load quan huyen theo tinh thanh - chọn địa chỉ giao hàng khác
    $scope.HienthiQuanhuyen1 = function () {
        var defer = $q.defer();
        if ($scope.tinhthanhGiao == null) {
            $scope.quanhuyens = [];
            $scope.quanhuyenGiao = null;
        }
        else {
            $http.post("/Taikhoan/HienthiQuanhuyen", { tinhthanhId: $scope.tinhthanhGiao.TinhthanhId }).success(function (data, status, headers, config) {
                if (data) {
                    $scope.quanhuyens = data;
                }
            }).error(defer.reject);
        }
        return defer.promise;
    }


    //Hàm khi load trang chọn địa chỉ giao hàng
    $scope.InitChonDiachiGiaohang = function () {
        $scope.LayAccountId().then($scope.LayThongtinTaikhoan).then($scope.KiemtraDiachiGiaohang).then($scope.HienthiTinhthanh).then($scope.HienthiQuanhuyen);
    }

    $scope.ThaydoiThongtinKhachhang = function () {
        $http.post("/Taikhoan/ThaydoiThongtinKhachhang", { khachhang: $scope.khachhang }).success(function (data, status, headers, config) {
            alert(data.thongbao);
            window.location.reload();
        }).error(function (data, status, headers, config) {
            // log 
            alert("Lỗi thay đổi thông tin khách hàng.");
        });
    }

    //Hàm xử lý khi khách hàng muốn thêm địa chỉ giao hàng
    $scope.ThemDcGh = false;
    $scope.MuonthemDiachiGiaohang = function () {
        var defer = $q.defer();
        $scope.ThemDcGh = true;
        $scope.quanhuyens = [];
        $scope.diachiGiao = null;
        $scope.tinhthanhGiao = null;
        $scope.quanhuyenGiao = null;
        $scope.soDienthoai = null;
        return defer.promise;
    }

    $scope.XulyThemDiachiGiaohang = function () {
        $scope.MuonthemDiachiGiaohang().then($scope.HienthiQuanhuyen1);
    }

    //Hàm xử lý khi khách hàng không muốn thêm địa chỉ giao hàng nữa
    $scope.HuyThemDiachiGiaohang = function () {
        $scope.ThemDcGh = false;
        $scope.diachiGiao = null;
        $scope.tinhthanhGiao = null;
        $scope.quanhuyenGiao = null;
        $scope.soDienthoai = null;
    }

    $scope.isLuuthanhMacdinh = false;
    //Hàm xử lý khi khách hàng hoàn tất thông tin và lưu đơn hàng
    $scope.TienhanhLuuDonhang = function () {
        if ($scope.account.AccountId == null) {
            window.location.href = "/Taikhoan/Dangnhap";
        }
        $scope.donhang.KhachhangId = $scope.khachhang.KhachhangId;
        //alert($scope.donhang.Tongtien);
        //Trường hợp khách không chọn địa chỉ giao hàng khác
        if ($scope.diachiGiao == null) {
            //alert("Trường hợp khách không chọn địa chỉ giao hàng khác");
            $scope.donhang.DiachiGiao = $scope.khachhang.DiachiGiaohang;
            $scope.donhang.TenTinhthanhGiao = $scope.khachhang.TenTinhthanh;
            $scope.donhang.TenQuanhuyenGiao = $scope.khachhang.TenQuanhuyen;
            if ($scope.khachhang.Mobile != null) {
                $scope.donhang.SoDienthoai = $scope.khachhang.Mobile;
            }
            else {
                $scope.donhang.SoDienthoai = $scope.khachhang.Tel;
            }

            //alert($scope.donhang.KhachhangId + " " + $scope.donhang.DiachiGiao + " " + $scope.donhang.TenTinhthanhGiao + " " + $scope.donhang.TenQuanhuyenGiao + " " + $scope.donhang.SoDienthoai + " " + $scope.donhang.Tongtien);
            //Lưu vào bảng đơn hàng
            $scope.truonghop = 0;
        }
            //Trường hợp khách chọn giao hàng nơi khác, nhưng không dùng làm địa chỉ mặc định
        else if ($scope.isLuuthanhMacdinh == false) {
            //alert("Trường hợp khách chọn giao hàng nơi khác, nhưng không dùng làm địa chỉ mặc định");
            $scope.donhang.DiachiGiao = $scope.diachiGiao;
            $scope.donhang.TenTinhthanhGiao = $scope.tinhthanhGiao.TenTinhthanh;
            $scope.donhang.TenQuanhuyenGiao = $scope.quanhuyenGiao.TenQuanhuyen;
            $scope.donhang.SoDienthoai = $scope.soDienthoai;

            //alert($scope.donhang.KhachhangId + " " + $scope.donhang.DiachiGiao + " " + $scope.donhang.TenTinhthanhGiao + " " + $scope.donhang.TenQuanhuyenGiao + " " + $scope.donhang.SoDienthoai + " " + $scope.donhang.Tongtien);
            //Lưu vào bảng đơn hàng
            $scope.truonghop = 0;
        }
            //Trường hợp khách chọn giao hàng nơi khác, nhưng dùng làm địa chỉ mặc định
        else if ($scope.isLuuthanhMacdinh == true) {
            //alert("Trường hợp khách chọn giao hàng nơi khác, nhưng dùng làm địa chỉ mặc định");
            $scope.khachhang.DiachiGiaohang = $scope.diachiGiao;
            $scope.khachhang.TenTinhthanh = $scope.tinhthanhGiao.TenTinhthanh;
            $scope.khachhang.TinhthanhId = $scope.tinhthanhGiao.TinhthanhId;
            $scope.khachhang.TenQuanhuyen = $scope.quanhuyenGiao.TenQuanhuyen;
            $scope.khachhang.QuanhuyenId = $scope.quanhuyenGiao.QuanhuyenId;
            $scope.khachhang.Mobile = $scope.soDienthoai;

            $scope.donhang.DiachiGiao = $scope.khachhang.DiachiGiaohang;
            $scope.donhang.TenTinhthanhGiao = $scope.khachhang.TenTinhthanh;
            $scope.donhang.TenQuanhuyenGiao = $scope.khachhang.TenQuanhuyen;
            $scope.donhang.SoDienthoai = $scope.khachhang.Mobile;

            //alert($scope.donhang.KhachhangId + " " + $scope.donhang.DiachiGiao + " " + $scope.donhang.TenTinhthanhGiao + " " + $scope.donhang.TenQuanhuyenGiao + " " + $scope.donhang.SoDienthoai + " " + $scope.donhang.Tongtien);
            //Lưu vào bảng Khachhang và bảng Donhang
            $scope.truonghop = 1;
        }

        $http.post("/MuaHang/InsertDonhang", { donhang: $scope.donhang, lstChitietDonhang: $scope.chitietdonhangs, khachhang: $scope.khachhang, truonghop: $scope.truonghop }).success(function (data, status, headers, config) {
            alert(data.thongbao);
            if (data.kq == true) {
                window.location.href = '/MuaHang/DatHang';
            }
        }).error(function (data, status, headers, config) {
            // log 
            alert('Lỗi insert Đơn hàng');
        });
    }


    //modal
    //$scope.items = ['item1', 'item2', 'item3'];
    $scope.openModalChitietHanghoa = function (hanghoa) {
        //alert(hanghoa.TenHanghoa);
        var modalInstance = $modal.open({
            templateUrl: 'myModalContent.html',
            controller: 'ModalInstanceCtrl',
            resolve: {
                hanghoa: function () {
                    return hanghoa;
                }
            }
        });

        //modalInstance.result.then(function (selectedItem) {
        //    $scope.selected = selectedItem;
        //}, function () {
        //    $log.info('Modal dismissed at: ' + new Date());
        //});
    };
};

angular.module("GlobalModule").controller('ModalInstanceCtrl', function ($scope, $modalInstance, $http, hanghoa) {

    $scope.hanghoa = hanghoa;
    //Load thuộc tính hàng hóa
    $http.post("/QuanlyHanghoa/LoadThuoctinhHanghoa", { hanghoaId: hanghoa.HanghoaId }).success(function (data, status, headers, config) {
        $scope.thuoctinhhanghoas = [];

        if (data.lst != null) {
            $scope.thuoctinhhanghoas = data.lst;
        }
    }).error(function (data, status, headers, config) {
        // log 
        alert('Lỗi load thuộc tính hàng hóa theo hàng hóa');
    });
    //$scope.ok = function () {
    //    $modalInstance.close($scope.selected.item);
    //};

    //$scope.cancel = function () {
    //    $modalInstance.dismiss('cancel');
    //};
});