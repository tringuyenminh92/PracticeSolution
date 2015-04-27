angular.module("GlobalModule").controller("taikhoanController", TaikhoanController);

TaikhoanController.$inject = ['$scope', '$http','$q'];
function TaikhoanController($scope, $http,$q) {
    //Dang nhap
    $scope.$scope = $scope;
    $scope.accountname = "";
    $scope.accountpassword = "";

    $scope.ChonGioiTinh = function (team) {
        $scope.khachhang.Gioitinh = team;
    }

    $scope.checkLogin = function () {
        $http.post("/Taikhoan/CheckLoginUser", { account: $scope.accountname, password: $scope.accountpassword }).success(function (data, status, headers, config) {
            if (data) {
                if (data.result) {
                    alert("Đăng nhập thành công.");
                    //window.location.reload();
                    window.location.href = '/MuaHang/DatHang';
                    //window.history.go(-1);
                }
                else {
                    alert("Đăng nhập không thành công.");
                    $scope.accountpassword = "";
                }
            }
        }).error(function (data, status, headers, config) {
            alert("Error");
        });
    }

    $scope.Dangxuat = function () {
        $http.post("/Taikhoan/Dangxuat").success(function (data, status, headers, config) {
            if (data) {
                window.location.href = '/Quote';
            }
        }).error(function (data, status, headers, config) {
            alert("Error");
        });
    }

    $scope.Loi = { tenLoi: "", hienthi: "" };
    $scope.passnhaplai = "";


    $scope.Dangky = function () {
        $scope.account = { AccountName: "", AccountPassword: "" };
        $scope.khachhang = {
            HotenKhachhang: "",
            Ngaysinh: "", CMND: "", Gioitinh: "", Diachi: "",
            DichiGiaohang: "", TinhthanhId: "", QuanhuyenId: "",
            Mobile: "", Tel: "", Email: "", Tax: "",
            TenCongty: "", DiachiCongty: "", Chucvu: "", DienthoaiCongty: "",
            TenTaikhoan: "", SoTaikhoan: "", Nganhang: "", MasoThue: ""
        };
    }

    //Hàm kiểm tra dữ liệu đầu vào có null hay không
    $scope.KiemtraDulieuDangky = function () {
        if ($scope.account.AccountName == "" || $scope.account.AccountPassword == "" || $scope.khachhang.HotenKhachhang == "") {
            $scope.Loi.tenLoi = "Null";
            $scope.Loi.hienthi = "Xin vui lòng nhập";
            return false;
        }
        else {
            return true;
        }
    }

    //Hàm kiểm tra accountName người dùng nhập có tồn tại ko
    $scope.KiemtraTrungAccountName = function () {
        if ($scope.account.AccountName == "") {
            $scope.Loi.tenLoi = "Null";
            $scope.Loi.hienthi = "Xin vui lòng nhập";
        }
        else if ($scope.accountNameTmp == "" || ($scope.accountNameTmp != "" && $scope.accountNameTmp != $scope.account.AccountName)) {
            $http.post("/Taikhoan/KiemtraAccountName", { account: $scope.account }).success(function (data, status, headers, config) {
                if (data.kq == true) {
                    $scope.Loi.tenLoi = "TrungAccountName";
                    $scope.Loi.hienthi = "Tên đăng nhập đã tồn tại";
                }
                else {
                    $scope.Loi.tenLoi = "";
                    $scope.Loi.hienthi = "";
                }
            });
        }
    }

    //Hàm insert người dùng mới (vào bảng Account và Khachhang)
    $scope.XulyDangky = function () {
        if ($scope.KiemtraDulieuDangky()) {
            $http.post("/Taikhoan/XulyDangky", { khachhang: $scope.khachhang, account: $scope.account }).success(function (data, status, headers, config) {
                alert(data.thongbao);
                if (data.kq == true) {
                    window.location.href = "/Home";
                }
            }).error(function (data, status, headers, config) {
                // log 
                //var al = new Alert("alertId", "Load Failed", "danger");
                alert('Lỗi xử lý đăng ký');
            });
        }
    }

    //Các hàm hiển thị tab
    $scope.isActive = 1;
    $scope.Hientab = function (item) {
        $scope.isActive = item;
    }
    $scope.getClass = function () {
        return
    }

    //Hàm đổi password
    $scope.passold = '';
    $scope.passnew = '';
    var m = { AccountName: 'vinhpham', Password: $scope.passold };
    $scope.XulyDoiPassword = function () {
        if ($scope.account.AccountId == null) {
            window.location.href = "/Taikhoan/Dangnhap";
        }
        if ($scope.passold == $scope.account.AccountPassword) {
            $http.post("/Taikhoan/XulyDoiPassword", { account: $scope.account, passnew: $scope.passnew }).success(function (data, status, headers, config) {
                alert(data.thongbao);
                if (data.kq == true) {
                    window.location.href = "/Taikhoan/SuaTaikhoan";
                }
            }).error(function (data, status, headers, config) {
                // log 
                alert("Lỗi đổi password");
            });
            $scope.Loi = {};
        }
        else {
            $scope.Loi.tenLoi = "SaiPassword";
            $scope.Loi.hienthi = "Password nhập không đúng, vui lòng nhập lại.";
        }
    }
    //$scope.khachhang = {}
    $scope.accountNameTmp = "";
    $scope.LayAccountId = function () {
        var defer = $q.defer();
        $http.post("/Taikhoan/LayAccountId").success(function (data, status, headers, config) {
            $scope.accountIdTmp = data.accountId;
            defer.resolve(data);
        }).error(defer.reject);
        return defer.promise;
    }

    $scope.LoadThongtintaikhoan=function(){
        $scope.LayAccountId().then($scope.HienthiThongtinTaikhoan).then($scope.HienthiTinhthanh).then($scope.HienthiQuanhuyen);
    }
    //Hàm hiển thị các thông tin của account đang được sử dụng
    $scope.HienthiThongtinTaikhoan = function () {
        var defer = $q.defer();
        if ($scope.accountIdTmp == null) {
            window.location.href = "/Home";
        }
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

    //Hàm lưu thông tin account thay đổi
    $scope.ThaydoiThongtinDangnhap = function () {
        if ($scope.account.AccountId == null) {
            window.location.href = "/Taikhoan/Dangnhap";
        }
        $http.post("/Taikhoan/ThaydoiThongtinDangnhap", { account: $scope.account }).success(function (data, status, headers, config) {
            alert(data.thongbao);
        }).error(function (data, status, headers, config) {
            // log 
            alert("Lỗi thay đổi thông tin đăng nhập");
        });
    }

    $scope.KiemtraHotenKhachhang = function () {
        if ($scope.khachhang.HotenKhachhang == "") {
            $scope.Loi.tenLoi = "Null";
            $scope.Loi.hienthi = "Xin vui lòng nhập";
            return false;
        }
    }

    //Hàm lưu thông tin khách hàng thay đổi
    $scope.ThaydoiThongtinKhachhang = function () {
        if ($scope.account.AccountId == null) {
            window.location.href = "/Taikhoan/Dangnhap";
        }
        $http.post("/Taikhoan/ThaydoiThongtinKhachhang", { khachhang: $scope.khachhang }).success(function (data, status, headers, config) {
            alert(data.thongbao);
        }).error(function (data, status, headers, config) {
            // log 
            alert("Lỗi thay đổi thông tin khách hàng.");
        });
    }

    //Hàm tạo Datepicker
    $scope.open = function ($event) {
        $event.preventDefault();
        $event.stopPropagation();

        $scope.opened = true;
    };
    $scope.format = 'dd/MM/yyyy';
    
    $scope.dateOptions = {
        formatYear: 'yy',
        startingDay: 1
    };

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

    //Load quan huyen full (khi load lan dau)
    $scope.HienthiQuanhuyenFull = function () {
        $http.post("/Taikhoan/HienthiQuanhuyenFull").success(function (data, status, headers, config) {
            if (data) {
                $scope.quanhuyens = data;
            }
        }).error(function (data, status, headers, config) {
            // log 
            alert("I am an alert box bug!");
        });
    }

    $(function () {
        $('a, button').click(function () {
            $(this).toggleClass('active');
        });
    });
}