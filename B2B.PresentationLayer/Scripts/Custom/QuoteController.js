
$(function () {
    $('#alertButton').click(function () {
        var al = new Alert("alertDiv", "thoong baos", "success");
        al.Show();
    });
})

angular.module("GlobalModule").controller("quoteController", QuoteController);
QuoteController.$inject = ['$scope', '$http', '$upload', '$location', '$q'];
function QuoteController($scope, $http, $upload, $location, $q, $modalInstance) {

    $scope.$scope = $scope;

    $scope.colors = ['Red', 'Green'];
    $scope.availableColors = ['Blue', 'Yellow', 'Magenta', 'Maroon', 'Umbra', 'Turquoise'];

    $scope.Array = [];
    $scope.Edit = function () {
        $scope.Array = JSON.parse(JSON.stringify($scope.colors));
    }
    $scope.Reset = function () {
        $scope.colors = JSON.parse(JSON.stringify($scope.Array));
    }

    //display-property="name" << when using array object
    $scope.tags = ['tkh', 'sasac'];
    $scope.loadTags = function (query) {
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

        $http.get("/Quote/GetQuotes").success(function (data, status, headers, config) {
            $scope.myData = data;
            //var wait = new WaitDialog();
            //wait.Show();
            //$scope.ShowModal(null, null, "abc", "cds", "Cancel", "Submit");

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


    $scope.upload = function (file) {
        if (file && file.length) {
            $upload.upload({
                url: 'Quote/UploadFile',
                method: 'POST',
                file: file
            }).progress(function (evt) {
                //var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            }).success(function (data, status, headers, config) {
                //console.log('file ' + config.file.name + 'uploaded. Response: ' + data);
                if (data) {
                    alert(data.FileName);
                }
            });
        }
    };
}

