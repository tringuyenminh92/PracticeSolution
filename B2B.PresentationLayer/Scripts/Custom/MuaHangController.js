angular.module("GlobalModule").controller("muaHangController", MuaHangController);

MuaHangController.$inject = ['$scope', '$http'];
function MuaHangController($scope, $http) {
    $scope.$scope = $scope;
    $scope.hanghoas = [];
    $scope.nhomhanghoas = [];
    $scope.chitiethoadons = [
        //{
        //_STT: "1",
        //Code: "Test", TenHanghoa: "TestABC", Soluong: "2", Giaban: "1000",
        //Thanhtien: "2000"
        //}
    ];
    $scope.tongtien = 0;

    $scope.LoadHanghoaTheoNhomHanghoa = function () {
        $http.post("/MuaHang/LoadHanghoaTheoNhomHanghoa", { nhomHanghoaId: $scope.nhomHanghoaId }).success(function (data, status, headers, config) {
            $scope.hanghoas = data;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    };

    $scope.LoadNhomHanghoa = function () {
        $http.post("/MuaHang/LoadNhomHanghoa").success(function (data, status, headers, config) {
            $scope.nhomhanghoas = data;
        }).error(function (data, status, headers, config) {
            // log 
            alert('Error');
        });
    };

    $scope.addHanghoa = function (team) {
        var cthd = {
            _STT: $scope.chitiethoadons.length + 1,
            Code: team.Code, TenHanghoa: team.TenHanghoa,
            Soluong: 1, Giaban: team.Giagoc,
            Thanhtien: team.Giagoc
        };
        $scope.chitiethoadons.push(cthd);
        $scope.tongtien += cthd.Thanhtien;
    };

    var img = $("<img />").attr('src', 'http://somedomain.com/image.jpg')
    $scope.gridOptions = {};
    $scope.addCellTemplate = '<button ng-click="getExternalScopes().addHanghoa(row.entity)" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-shopping-cart"/></button> ';
    $scope.imageCellTemplate = '<img src="~/Content/images/image1.jpg" />';
    $scope.gridOptions.columnDefs = [
        { name: 'Code', displayName: 'Code', width: 80 },
  	    { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 150 },
        { name: 'Giagoc', displayName: 'Giá gốc', width: 80 },
        { name: '_hinhanh', displayName: '', enableFiltering: false, width: 80 },
        { name: '_addHanghoa', displayName: "", cellTemplate: $scope.addCellTemplate, width: 15, enableFiltering: false, enableCellEdit: false },
    ];

    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "hanghoas";
    $scope.gridOptions.enableFiltering = true;


    $scope.removeHanghoa = function (team) {
        //Push to server, delete and delete GUI
        var index = $scope.chitiethoadons.indexOf(team);
        $scope.chitiethoadons.splice(index, 1);
        $scope.tongtien -= team.Thanhtien;
        for (i = index; i < $scope.chitiethoadons.length; i++) {
            $scope.chitiethoadons[i]._STT = $scope.chitiethoadons[i]._STT - 1;
        }
    };

    //$scope.Test() = function () {
    //    alert('test');
    //}

    $scope.gridOptions1 = {};
    $scope.removeCellTemplate = '<button ng-click="getExternalScopes().removeHanghoa(row.entity)" class="btn btn-danger btn-xs"><i class="glyphicon glyphicon-remove"/></button> ';
    //$scope.soluongCellTemplate = '<input type="number" ng-change=$scope.Test()>';
    $scope.gridOptions1.columnDefs = [
        { name: '_STT', displayName: 'STT', width: 60, enableFiltering: false, enableCellEdit: false },
        { name: 'Code', displayName: 'Code', width: 80, enableCellEdit: false },
  	    { name: 'TenHanghoa', displayName: 'Tên hàng hóa', width: 170, enableCellEdit: false },
        { name: 'Soluong', displayName: 'Số lượng', width: 80, enableCellEdit: true },
        { name: 'Giaban', displayName: 'Đơn giá', width: 100, enableCellEdit: false },
        { name: 'Thanhtien', displayName: 'Thành tiền', width: 100, enableCellEdit: false },
        { name: '_removeHanghoa', displayName: "", cellTemplate: $scope.removeCellTemplate, width: 15, enableFiltering: false, enableCellEdit: false },
    ];

    $scope.gridOptions1.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions1.paginationPageSize = 25;
    $scope.gridOptions1.data = "chitiethoadons";
    $scope.gridOptions1.enableFiltering = true;

    $scope.gridOptions1.onRegisterApi = function (gridApi) {
        //set gridApi on scope
        $scope.gridApi = gridApi;
        gridApi.edit.on.afterCellEdit($scope, function (rowEntity, colDef, newValue, oldValue) {
            //$scope.msg.lastCellEdited = 'edited row id:' + rowEntity.id + ' Column:' + colDef.name + ' newValue:' + newValue + ' oldValue:' + oldValue;
            if (colDef.name == 'Soluong') {
                rowEntity.Thanhtien = newValue * rowEntity.Giaban;
            }
            $scope.tongtien -= oldValue * rowEntity.Giaban;
            $scope.tongtien += rowEntity.Thanhtien
            $scope.$apply();
        });
    };
}