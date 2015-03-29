﻿angular.module("GlobalModule").controller("taikhoanController", TaikhoanController);

TaikhoanController.$inject = ['$scope', '$http'];
function TaikhoanController($scope, $http) {
    $scope.isActive = 1;
    $scope.account = {
        username: "", pass: "", passnhaplai: "", hoten: "",
        ngaysinh: "", cmnd: "", gioitinh: "", diachi: "",
        dichigiaohang: "", tinhthanh: "", quanhuyen: "",
        mobile: "", tel: "", email: "", tax: "",
        tencongty: "", diachicongty: "", chucvu: "", dienthoaicongty: "",
        tentaikhoan: "", sotaikhoan: "", nganhang: "", masothue: ""};
    $scope.XulyDangky = function () {
        $http.post("/Taikhoan/XulyDangky", JSON.stringify($scope.account) ).success(function (data, status, headers, config) {
            if (data) {
                alert(data);
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