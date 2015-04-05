angular.module("GlobalModule").controller("muaHangController", MuaHangController);

MuaHangController.$inject = ['$scope', '$http'];
function MuaHangController($scope, $http) {
    $scope.$scope = $scope;
    $scope.lstHanghoa = [];
    $scope.deleteRow = function (team) {
        //Push to server, delete and delete GUI
        var index = $scope.lstHanghoa.indexOf(team);
        $scope.lstHanghoa.splice(index, 1);

    };

    $scope.LoadNhomHanghoa = function () {
        $http.post("/MuaHang/LoadNhomHanghoa").success(function (data, status, headers, config) {
            if (data) {
                $scope.nhomHanghoaDropdownlist = data;
            }

        }).error(function (data, status, headers, config) {
            // log 
            alert("I am an alert box bug!");
        });

    }
    //var NhomHanghoaCurrent = $scope.currentSelect;
    $scope.LoadHanghoaTheoNhomHanghoa = function () {
        $http.post("/MuaHang/LoadHanghoaTheoNhomHanghoa", { nhomHanghoaModel: $scope.currentSelect }).success(function (data, status, headers, config) {
            $scope.lstHanghoa = data;
        }).error(function (data, status, headers, config) {
            // log 
            var alertInstance = new Alert("alertId", "Load Failed", "danger");
            alertInstance.ShowAlert();
            
        });
    };
    var img = $("<img />").attr('src', 'http://somedomain.com/image.jpg')
    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.imageCellTemplate = '<img src="~/Content/images/image1.jpg" />';
    $scope.gridOptions.columnDefs = [
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
  	      { name: 'TenHanghoa', displayName: 'Tên hàng hóa', headerCellTemplate: '<div title="Tooltip Content">Name</div>', width: 150 },
  	      { name: 'Code', displayName: 'Code', width: 50 },
          { name: 'Giagoc', displayName: 'Giá gốc', width: 50 },
          { name: '_hinhanh', cellTemplate: $scope.imageCellTemplate, width: 25 }
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "lstHanghoa";
    $scope.gridOptions.enableFiltering = true;
}