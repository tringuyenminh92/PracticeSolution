angular.module("GlobalModule").controller("taikhoanController", TaikhoanController);

TaikhoanController.$inject = ['$scope', '$http'];
function TaikhoanController($scope, $http) {
    $scope.Loi = { tenLoi: "", hienthi: "" };
    $scope.passnhaplai = "";


    $scope.Dangky = function () {
        $scope.account = { AccountName: "", AccountPassword: "" };
        $scope.khachhang = {
            HotenKhachhang: "",
            Ngaysinh: "", CMND: "", Gioitinh: "", Diachi: "",
            DichiGiaohang: "", Tinhthanh: "", Quanhuyen: "",
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
                //al.ShowAlert();
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
        if ($scope.passold == $scope.account.AccountPassword) {
            $http.post("/Taikhoan/XulyDoiPassword", { account: $scope.account, passnew: $scope.passnew }).success(function (data, status, headers, config) {
                alert(data.thongbao);
                if (data.kq == true) {
                    window.location.href = "/Taikhoan/SuaTaikhoan";
                }
            }).error(function (data, status, headers, config) {
                // log 
                alert("Error.");
            });
            $scope.Loi = {};
        }
        else {
            $scope.Loi.tenLoi = "SaiPassword";
            $scope.Loi.hienthi = "Password nhập không đúng, vui lòng nhập lại.";
        }
    }

    $scope.accountNameTmp = "";
    //Hàm hiển thị các thông tin của account đang được sử dụng
    $scope.HienthiThongtinTaikhoan = function () {
        $http.post("/Taikhoan/HienthiThongtinTaikhoan", { accountId: "34b4f9ab-7d28-49f4-9bc4-27d70c6eba85" }).success(function (data, status, headers, config) {
            $scope.account = data.acc;
            $scope.khachhang = data.kh;
            $scope.accountNameTmp = data.acc.AccountName;
            if ($scope.khachhang.Gioitinh == null) {
                $scope.khachhang.Gioitinh = true;
            }
        });
    }

    //Hàm lưu thông tin account thay đổi
    $scope.ThaydoiThongtinDangnhap = function () {

        $http.post("/Taikhoan/ThaydoiThongtinDangnhap", { account: $scope.account }).success(function (data, status, headers, config) {
            alert(data.thongbao);
        })
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
}