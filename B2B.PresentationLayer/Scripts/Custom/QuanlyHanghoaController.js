angular.module("GlobalModule").controller("quanlyHanghoaController", QuanlyHanghoaController);

QuanlyHanghoaController.$inject = ['$scope', '$http'];
function QuanlyHanghoaController($scope, $http) {
    $scope.$scope = $scope;
    $scope.hanghoas = [];
    $scope.nhomhanghoas = [];
    $scope.donvis = [];

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

    $scope.editRow = function (team) {
        $scope.hanghoa = team;
        $scope.isEdit = true;
    };

    $scope.ResetValue = function () {
        $scope.isEdit = false;
        $scope.hanghoa = {};
    };

    $scope.LoadHanghoaTheoNhomHanghoa = function () {
        $http.post("/QuanlyHanghoa/LoadHanghoaTheoNhomHanghoa", { nhomHanghoaId: $scope.nhomHanghoaId }).success(function (data, status, headers, config) {
            $scope.hanghoas = data;
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

    $scope.InsertHanghoa = function () {
        $http.post("/QuanlyHanghoa/InsertHanghoa", { hanghoa: $scope.hanghoa }).success(function (data, status, headers, config) {
            alert(data.thongbao);
            $scope.ResetValue();
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    };

    $scope.UpdateHanghoa = function () {
        $http.post("/QuanlyHanghoa/UpdateHanghoa", { hanghoa: $scope.hanghoa }).success(function (data, status, headers, config) {
            alert(data.thongbao);
            $scope.ResetValue();
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    };

    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.editCellTemplate = '<button ng-click="getExternalScopes().editRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-pencil"/></button> ';
    $scope.activeCellTemplate = '<input type="checkbox" ng-checked="row.entity.Active" ng-click="getExternalScopes().ChangeActive(row.entity)"> ';
    $scope.gridOptions.columnDefs = [
  	      { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 150 },
          { name: 'Giagoc', displayName: 'Giá gốc', width: 70 },
          { name: 'Active', displayName: 'Active', cellTemplate: $scope.activeCellTemplate, width: 60 },
          { name: 'NgayCapnhat', displayName: 'Cập nhật', width: 100 },
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
          { name: '_edit', displayName: "", cellTemplate: $scope.editCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "hanghoas";
    $scope.gridOptions.enableFiltering = true;
}