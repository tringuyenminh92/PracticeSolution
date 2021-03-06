﻿angular.module("GlobalModule").controller("quanlyHanghoaController", QuanlyHanghoaController);

QuanlyHanghoaController.$inject = ['$scope', '$http', '$modal', '$log', 'Upload', '$q'];
function QuanlyHanghoaController($scope, $http, $modal, $log, Upload, $q) {
    $scope.$scope = $scope;
    $scope.hanghoas = [];
    $scope.nhomhanghoas = [];
    $scope.donvis = [];
    $scope.thuoctinhhanghoas = [];
    $scope.thuoctinhhanghoasXoa = [];
    $scope.thuoctinhhanghoasThem = [];
    

    $scope.Thuoctinh = {};

    $scope.img = "/Images/Hinhhanghoa/noPhoto-icon.png";

    $scope.isEdit = false;

    $scope.deleteRow = function (team) {
        //Push to server, delete and delete GUI
        var index = $scope.hanghoas.indexOf(team);
        $scope.hanghoas.splice(index, 1);
        $http.post("/QuanlyHanghoa/DeleteHanghoa", { hanghoaId: team.HanghoaId }).success(function (data, status, headers, config) {
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
        if ($scope.hanghoa.HanghoaId == team.HanghoaId) {
            $scope.ResetValue();
        }
    };

    $scope.ChangeActive = function (team) {
        if (team.Active == false) {
            team.Active = true;
        } else {
            team.Active = false;
        }
        $http.post("/QuanlyHanghoa/UpdateHanghoa", { hanghoa: team }).success(function (data, status, headers, config) {
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    }

    $scope.editIndex;
    $scope.editRow = function (team) {
        $scope.ResetValue();

        $scope.hanghoa = team;
        if ($scope.hanghoa.LinkHinhanh_Web != null) {
            $scope.img = $scope.hanghoa.LinkHinhanh_Web;
        }
        else {
            $scope.img = "/Images/Hinhhanghoa/noPhoto-icon.png";
        }

        //if ($scope.hanghoa.LinkHinhanh_Web == null) { $scope.hanghoa.LinkHinhanh_Web = "/Images/Hinhhanghoa/noPhoto-icon.jpg"; }
        $scope.isEdit = true;
        $scope.editIndex = $scope.hanghoas.indexOf(team);
        $http.post("/QuanlyHanghoa/LoadThuoctinhHanghoa", { hanghoaId: team.HanghoaId }).success(function (data, status, headers, config) {
            //$scope.thuoctinhhanghoas = [];
            //$scope.thuoctinhhanghoasXoa = [];
            //$scope.thuoctinhhanghoasThem = [];

            if (data.lst != null) {
                $scope.thuoctinhhanghoas = data.lst;
                var stt = 0;
                for (i = 0; i < $scope.thuoctinhhanghoas.length; i++) {
                    stt = stt + 1;
                    $scope.thuoctinhhanghoas[i].STT = stt;
                }
            }
        }).error(function (data, status, headers, config) {
            // log 
            alert('Lỗi load thuộc tính hàng hóa theo hàng hóa');
        });
    };

    $scope.ResetValue = function () {
        if ($scope.isEdit == true) {
            $scope.isEdit = false;
        }
        $http.post("/QuanlyHanghoa/LoadHanghoaTheoNhomHanghoa", { nhomHanghoaId: $scope.nhomHanghoaId }).success(function (data, status, headers, config) {
            $scope.hanghoas = data;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Lỗi load hàng hóa theo nhóm hàng');
        });
        $scope.hanghoa = {};
        $scope.thuoctinhhanghoas = [];
        $scope.thuoctinhhanghoasXoa = [];
        $scope.thuoctinhhanghoasThem = [];
        $scope.Thuoctinh.tenThuoctinh = null;
        //var imgInp = $("[name='image']");
        //imgInp.replaceWith(imgInp.val('').clone(true));
        $("[name='thongtinhanghoa']").closest('form').trigger('reset');
        $scope.myFile = null;
        $('#imgAvatar').attr('src', "/Images/Hinhhanghoa/noPhoto-icon.png");

    };

    //$scope.LoadHinh = function () {
    //    $scope.hanghoa.LinkHinhanh_Web = "/Images/Hinhhanghoa/noPhoto-icon.jpg";
    //}

    $scope.LoadHanghoaTheoNhomHanghoa = function () {
        $http.post("/QuanlyHanghoa/LoadHanghoaTheoNhomHanghoa", { nhomHanghoaId: $scope.nhomHanghoaId }).success(function (data, status, headers, config) {
            $scope.hanghoas = data;
            $scope.myFile = null;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    };

    $scope.LoadNhomHanghoa = function () {
        $http.post("/QuanlyHanghoa/LoadNhomHanghoa").success(function (data, status, headers, config) {
            $scope.nhomhanghoas = data;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    };

    $scope.LoadDonvi = function () {
        $http.post("/QuanlyHanghoa/LoadDonvi").success(function (data, status, headers, config) {
            $scope.donvis = data;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    };

    $scope.YeucauThemThuoctinh = function () {
        $scope.themtt = !$scope.themtt;
    }

    $scope.Thuoctinh = {};
    $scope.addThuoctinh = function () {
        var tt = { STT: $scope.thuoctinhhanghoas.length + 1, TenThuoctinh: $scope.Thuoctinh.tenThuoctinh + '' }
        $scope.thuoctinhhanghoas.push(tt);
        $scope.thuoctinhhanghoasThem.push(tt);
        $scope.Thuoctinh = {};
        $scope.themtt = !$scope.themtt;
    }

    $scope.deleteThuoctinh = function (team) {
        var index1 = $scope.thuoctinhhanghoas.indexOf(team);
        $scope.thuoctinhhanghoas.splice(index1, 1);
        for (i = index1; i < $scope.thuoctinhhanghoas.length; i++) {
            $scope.thuoctinhhanghoas[i].STT = $scope.thuoctinhhanghoas[i].STT - 1;
        }
        var index2 = $scope.thuoctinhhanghoasThem.indexOf(team);
        if (index2 >= 0) {
            $scope.thuoctinhhanghoasThem.splice(index2, 1);
        }
        else {
            $scope.thuoctinhhanghoasXoa.push(team);
        }
    }

    $scope.InsertHanghoa = function () {
        $http.post("/QuanlyHanghoa/InsertHanghoa", { hanghoa: $scope.hanghoa, lstThuoctinhHanghoa: $scope.thuoctinhhanghoasThem }).success(function (data, status, headers, config) {
            alert(data.thongbao);
            $scope.ResetValue();
        }).error(function (data, status, headers, config) {
            // log 
            alert('Lỗi Insert Hàng hóa');
        });
    };
    $scope.UpdateHanghoa = function () {
        $http.post("/QuanlyHanghoa/UpdateHanghoa", { hanghoa: $scope.hanghoa, lstThuoctinhHanghoaThem: $scope.thuoctinhhanghoasThem, lstThuoctinhHanghoaXoa: $scope.thuoctinhhanghoasXoa }).success(function (data, status, headers, config) {
            alert(data.thongbao);
            $scope.ResetValue();
        }).error(function (data, status, headers, config) {
            // log 
            //alert('Error');
        });
    };

    $scope.InsertHanghoaVaHinh = function () {
        if ($scope.myFile != null) {
            $scope.upload($scope.myFile).then($scope.InsertHanghoa);
        }
        else
            $scope.InsertHanghoa();
    }

    $scope.UpdateHanghoaVaHinh = function () {
        if ($scope.myFile != null) {
            $scope.upload($scope.myFile).then($scope.UpdateHanghoa);
        }
        else
            $scope.UpdateHanghoa();
    }

    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.editCellTemplate = '<button ng-click="getExternalScopes().editRow(row.entity)" class="btn btn-primary btn-xs"><i class="fa fa-pencil"/></button> ';
    $scope.activeCellTemplate = '<input type="checkbox" ng-checked="row.entity.Active" ng-click="getExternalScopes().ChangeActive(row.entity)"> ';
    $scope.gridOptions.columnDefs = [
        { name: 'Code', displayName: 'Code', width: '12%', enableCellEdit: false },
  	    { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: '28%', enableCellEdit: false },
        { name: 'Barcode', displayName: 'Barcode', width: '15%', enableCellEdit: false },
        { name: 'Giagoc', displayName: 'Giá gốc', cellFilter: 'number', width: '15%', enableCellEdit: false },
        { name: 'Active', displayName: 'A', cellTemplate: $scope.activeCellTemplate, width: '1%', enableFiltering: false },
        { name: 'NgayCapnhatString', displayName: 'Cập nhật', width: '12%', enableCellEdit: false },
        { name: '_edit', displayName: "Sửa", cellTemplate: $scope.editCellTemplate, width: '7.5%', enableFiltering: false, enableCellEdit: false },
        { name: '_delete', displayName: "Xóa", cellTemplate: $scope.deleteCellTemplate, width: '7.5%', enableFiltering: false, enableCellEdit: false }
    ];
    $scope.gridOptions.paginationPageSizes = [18, 36, 72];
    $scope.gridOptions.paginationPageSize = 18;
    $scope.gridOptions.data = "hanghoas";
    $scope.gridOptions.enableFiltering = true;

    //$scope.uploadImage = function (file) {
    //    var defer = $q.defer();
    //    if (file && file.length) {

    //        Upload.upload({
    //            url: '/QuanlyHanghoa/UploadImage',
    //            method: 'POST',
    //            file: file
    //        }).progress(function (evt) {
    //            //var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
    //        }).success(function (data, status, headers, config) {
    //            //console.log('file ' + config.file.name + 'uploaded. Response: ' + data);
    //            if (data) {
    //                //$scope.img = data.fullPath;
    //                alert(data.fullPath);  
    //            }
    //            defer.resolve(data);
    //        }).error(defer.reject);
    //        return defer.promise;
    //    }
    //};
    $scope.myFile = {};
    $scope.upload = function (file) {
        var defer = $q.defer();
        if (file) {
            Upload.upload({
                url: '/QuanlyHanghoa/UploadImage',
                method: 'POST',
                file: file
            }).progress(function (evt) {
                //var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            }).success(function (data, status, headers, config) {
                //console.log('file ' + config.file.name + 'uploaded. Response: ' + data);
                if (data) {
                    $scope.hanghoa.LinkHinhanh_Web = data.pathSave;
                }
                defer.resolve(data);
            }).error(defer.reject);  
        }
        return defer.promise;
    };

    $scope.readURL = function (files, e) {
        var input = e.target;
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#imgAvatar').attr('src', e.target.result);
                //  $scope.img=e.target.result;
            }

            reader.readAsDataURL(input.files[0]);
            $scope.myFile = input.files[0];
        }
    }

};

//angular.module("GlobalModule").controller('ModalInstanceCtrl', function ($scope, $modalInstance, items) {

//    $scope.items = items;
//    $scope.selected = {
//        item: $scope.items[0]
//    };

//    $scope.ok = function () {
//        $modalInstance.close($scope.selected.item);
//    };

//    $scope.cancel = function () {
//        $modalInstance.dismiss('cancel');
//    };
//});

