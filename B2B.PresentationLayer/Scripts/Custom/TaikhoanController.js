angular.module("GlobalModule").controller("taikhoanController", TaikhoanController);

TaikhoanController.$inject = ['$scope', '$http'];
function TaikhoanController($scope, $http) {
    $scope.Loi = { tenLoi: "", hienthi: "" };
    $scope.passnhaplai = "";
    $scope.account = { AccountName: "", AccountPassword: ""};
    $scope.khachhang = {
        HotenKhachhang: "",
        Ngaysinh: "", CMND: "", Gioitinh: "", Diachi: "",
        DichiGiaohang: "", Tinhthanh: "", Quanhuyen: "",
        Mobile: "", Tel: "", Email: "", Tax: "",
        TenCongty: "", DiachiCongty: "", Chucvu: "", DienthoaiCongty: "",
        Tentaikhoan: "", Sotaikhoan: "", Nganhang: "", Masothue: ""
    };
    $scope.KiemtraDulieuVao = function () {
        if ($scope.account.AccountName == "" || $scope.account.AccountPassword == "" || $scope.khachhang.HotenKhachhang == "") {
            $scope.Loi.tenLoi = "Null";
            $scope.Loi.hienthi = "Xin vui lòng nhập";
            return false;
        }
        else {
            $http.post("/Taikhoan/KiemtraAccountName", $scope.account).success(function (data, status, headers, config) {
                if (data == true) {
                    $scope.Loi.tenLoi = "TrungAccountName";
                    $scope.Loi.hienthi = "Tên đăng nhập đã tồn tại";
                    return false;
                }
                else {
                    return true;
                }
            }).error(function (data, status, headers, config) {
                // log 
                //var al = new Alert("alertId", "Load Failed", "danger");
                //al.ShowAlert();
            });
        }
    }

    $scope.XulyDangky = function () {
        if ($scope.KiemtraDulieuVao()) {
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
    
    $scope.isActive = 1;
    $scope.Hientab = function (item) {
        $scope.isActive = item;
    }
    $scope.getClass=function(){
        return 
    }

    $scope.passold = '';
    $scope.passnew = '';
    var m = { AccountName: 'vinhpham', Password: $scope.passold };
    $scope.XulyDoiPassword = function () {
        $http.post("/Taikhoan/XulyDoiPassword", JSON.stringify({ model: m, passnew: $scope.passnew })).success(function (data, status, headers, config) {
            alert(data.thongbao);
            if (data.kq == true) {
                window.location.href = "/Taikhoan/SuaTaikhoan";
            }
        }).error(function (data, status, headers, config) {
            // log 
            alert("Error.");
        });
    }
}
