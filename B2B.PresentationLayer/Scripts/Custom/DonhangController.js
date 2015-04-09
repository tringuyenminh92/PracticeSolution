
angular.module("GlobalModule").controller("donhangController", DonhangController);

DonhangController.$inject = ['$scope', '$http'];

function DonhangController($scope, $http) {

    $scope.$scope = $scope;
    $scope.myData = [];


    $scope.LoadDonhang = function () {
        $http.get("Donhang/GetHanghoa", { ngaylap: $scope.ngaylap, loaiDonhang: $scope.loaiDonhang }).success(function (data, status, headers, config) {
            $scope.myData = data;
        }).error(function (data, status, headers, config) {
        });
    }

    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.detailsCellTemplate = '<button ng-click="getExternalScopes().getDetails(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-camera"/></button> ';
    $scope.gridOptions.columnDefs = [
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
  	      { name: 'name', displayName: 'Name', headerCellTemplate: '<div title="Tooltip Content">Name</div>', width: 150 },
  	      { name: 'tuoi', displayName: 'tuoi', width: 50 },
          { name: 'Details', displayName: 'Details', width: 50, cellTemplate: $scope.detailsCellTemplate }
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "myData";
    $scope.gridOptions.enableFiltering = false;
}

