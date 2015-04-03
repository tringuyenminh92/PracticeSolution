
$(function () {
    $('#alertButton').click(function () {
        var al = new Alert("alertDiv", "thoong baos", "success");
        al.Show();
    });
})

angular.module("GlobalModule").controller("quoteController", QuoteController);
QuoteController.$inject = ['$scope', '$http','$location'];
function QuoteController($scope, $http,$location, $modalInstance) {

    $scope.$scope = $scope;
    $scope.myData = [];
    $scope.deleteRow = function (team) {
        //Push to server, delete and delete GUI
        var index = $scope.myData.indexOf(team);
        $scope.myData.splice(index, 1);
    };

    $scope.loadData = function () {
        $http.get("Quote/GetQuotes").success(function (data, status, headers, config) {
            $scope.myData = data;
            $location.url('http://www.google.com')
        }).error(function (data, status, headers, config) {
            // log 
            var alertInstance = new Alert("alertId", "Load Failed", "danger");
            alertInstance.ShowAlert();
        });
    };

    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.gridOptions.columnDefs = [
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
  	      { name: 'name', displayName: 'Name', headerCellTemplate: '<div title="Tooltip Content">Name</div>', width: 150 },
  	      { name: 'tuoi', displayName: 'tuoi', width: 50 }
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "myData";
    $scope.gridOptions.enableFiltering = true;

    //Demo show datetime formart
    $scope.Giatri = Date.now();
}

