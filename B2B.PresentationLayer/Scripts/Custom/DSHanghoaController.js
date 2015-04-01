//$(function () {
//    $('#alertButton').click(function () {
//        var al = new Alert("alertDiv", "thoong baos", "success");
//        al.Show();
//    });
//})
angular.module("GlobalModule").controller("dsHanghoaController", DSHanghoaController);
DSHanghoaController.$inject = ['$scope', '$http'];
function DSHanghoaController($scope, $http, $modalInstance) {
    $scope.$scope = $scope;
    $scope.myData = [];
    $scope.dataSelect = [];
    $scope.currentSelect='';
    $scope.deleteRow = function (team) {
        //Push to server, delete and delete GUI
        var index = $scope.myData.indexOf(team);
        $scope.myData.splice(index, 1);
        //$scope.nhomHanghoaId = "55d8d06f-1d8b-4411-aa84-bfa4b398ffe9";
    };
    $scope.LoadDataSelect = function () {
        $http.get("DSHanghoa/GetNhomHanghoa").success(function (data, status, headers, config) {
            $scope.dataSelect = data;
            $scope.currentSelect = $scope.dataSelect[1];
        }).error(function (data, status, headers, config) {
            alert('error');
        });
    };
    $scope.loadData = function () {
        alert($scope.currentSelect);
        $http.post("DSHanghoa/GetHanghoa", { idNhomhanghoa: $scope.currentSelect }).success(function (data, status, headers, config) {
            $scope.myData = data;
        }).error(function (data, status, headers, config) {
            // log 
            //var alertInstance = new Alert("alertId", "Load Failed", "danger");
            //alertInstance.ShowAlert();
        });
    };
    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.gridOptions.columnDefs = [
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
  	      { name: 'TenHanghoa', displayName: 'TenHanghoa', headerCellTemplate: '<div title="Tooltip Content">Name</div>', width: 150 },
          { name: 'Giagoc', displayName: 'Giagoc',width: 70 }
  	      //{ name: 'tuoi', displayName: 'tuoi', width: 50 }
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "myData";
    $scope.gridOptions.enableFiltering = true;

    
}
