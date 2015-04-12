
$(function () {
    $('#alertButton').click(function () {
        var al = new Alert("alertDiv", "thoong baos", "success");
        al.Show();
    });
})

angular.module("GlobalModule").controller("quoteController", QuoteController);
QuoteController.$inject = ['$scope', '$http', '$location','$q'];
function QuoteController($scope, $http, $location, $q,$modalInstance) {

    $scope.$scope = $scope;

    $scope.colors = [];
    $scope.availableColors = ['Red', 'Green', 'Blue', 'Yellow', 'Magenta', 'Maroon', 'Umbra', 'Turquoise'];


    //display-property="name" << when using array object
    $scope.tags = ['tkh','sasac'];
    $scope.loadTags=function(query)
    {
        alert(query);
    }

    $scope.myData = [];
    $scope.deleteRow = function (team) {
        //Push to server, delete and delete GUI
        var index = $scope.myData.indexOf(team);
        $scope.myData.splice(index, 1);
    };

    $scope.getDetails = function (rowData) {
        alert(rowData.name);
    }



    $scope.loadData = function () {
        $http.get("GetQuotes").success(function (data, status, headers, config) {
            $scope.myData = data;
            //var wait = new WaitDialog();
            //wait.Show();
            $scope.ShowModal(null,null, "abc", "cds", "Cancel", "Submit");
        }).error(function (data, status, headers, config) {
        });
    };

    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.detailsCellTemplate = '<button ng-click="getExternalScopes().getDetails(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-camera"/></button> ';
    $scope.gridOptions.columnDefs = [
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
  	      { name: 'name', displayName: 'Name', headerCellTemplate: '<div title="Tooltip Content">Name</div>', width: 150 },
  	      { name: 'tuoi', displayName: 'tuoi', width: 50, type: 'number' },
          { name: 'Details', displayName: 'Details', width: 50, cellTemplate: $scope.detailsCellTemplate }
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "myData";
    $scope.gridOptions.enableFiltering = false;

    //Demo show datetime formart
    $scope.Giatri = Date.now();
}

