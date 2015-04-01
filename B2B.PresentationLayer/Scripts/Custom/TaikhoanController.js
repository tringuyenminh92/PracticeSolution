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
            Tentaikhoan: "", Sotaikhoan: "", Nganhang: "", Masothue: ""
        };
    }

    //Hàm kiểm tra dữ liệu đầu vào có null hay không
    $scope.KiemtraDulieuVao = function () {
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
        $http.post("/Taikhoan/KiemtraAccountName", { account: $scope.account }).success(function (data, status, headers, config) {
            if (data.kq == true) {
                alert("trùng accountname");
                $scope.Loi.tenLoi = "TrungAccountName";
                $scope.Loi.hienthi = "Tên đăng nhập đã tồn tại";
                return true;
            }
            else {
                alert("ko trùng accountname");
                return false;
            }
        })
        //alert("test");
    }
    
    //Hàm insert người dùng mới (vào bảng Account và Khachhang)
    $scope.XulyDangky = function () {
        if ($scope.KiemtraDulieuVao) {
            //if($scope.KiemtraTrungAccountName == false)
            //{
            //    alert("OK");
            //}
            //else
            //{
            //    alert("Not f***king OK");
            //}
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
    $scope.getClass=function(){
        return 
    }

    //Hàm đổi password (tìm account có accountName được truyền vào và đổi password của account đó)
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

    //Hàm hiển thị các thông tin của account đang được sử dụng
    $scope.HienthiThongtinTaikhoan = function () {
        $http.post("/Taikhoan/HienthiThongtinTaikhoan", { accountId: "34b4f9ab-7d28-49f4-9bc4-27d70c6eba85" } ).success(function (data, status, headers, config) {
            $scope.account = data.acc;
            $scope.khachhang = data.kh;
            if($scope.khachhang.Gioitinh == null)
            {
                $scope.khachhang.Gioitinh = true;
            }
        })
    }
}
