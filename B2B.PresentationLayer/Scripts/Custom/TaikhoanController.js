angular.module("GlobalModule").controller("taikhoanController", TaikhoanController);

TaikhoanController.$inject = ['$scope', '$http'];
function TaikhoanController($scope, $http) {
    $scope.isActive = 1;
    $scope.account = { AccountName: "", C_Password: "", passnhaplai: "" };
    $scope.khachhang = {
        HotenKhachhang: "",
        Ngaysinh: "", CMND: "", Gioitinh: "", Diachi: "",
        DichiGiaohang: "", Tinhthanh: "", Quanhuyen: "",
        Mobile: "", Tel: "", Email: "", Tax: "",
        TenCongty: "", DiachiCongty: "", Chucvu: "", DienthoaiCongty: "",
        Tentaikhoan: "", Sotaikhoan: "", Nganhang: "", Masothue: ""
    };
    $scope.XulyDangky = function () {
        $http.post("/Taikhoan/XulyDangky", { khachhang: $scope.khachhang, account: $scope.account }).success(function (data, status, headers, config) {
            alert(data.thongbao);
            if (data.kq == true)
            {
                window.location.href = "/Home";
            }
        }).error(function (data, status, headers, config) {
            // log 
            //var al = new Alert("alertId", "Load Failed", "danger");
            //al.ShowAlert();
        });
    }
    
    $scope.Hientab = function (item) {
        $scope.isActive = item;
    }
    $scope.getClass=function(){
        return 
    }
}
