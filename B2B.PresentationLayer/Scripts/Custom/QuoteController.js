
angular.module("GlobalModule").controller("quoteController", QuoteController);

QuoteController.$inject = ['$scope', '$http'];
function QuoteController($scope, $http, $modalInstance) {

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
        }).error(function (data, status, headers, config) {
            // log 
            var al = new Alert("alertId", "Load Failed", "danger");
            al.ShowAlert();
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
}

$(function () {
    $('#btId').click(function () {
        var al = new Alert("alertId", "thoong baos", "success");
        al.ShowAlert();
    });
})

angular.module("GlobalModule").controller("modalInstanceController", ModalInstanceController);
ModalInstanceController.$inject = ['$scope', '$modalInstance','items'];
function ModalInstanceController($scope, $modalInstance, items) {

    $scope.items = items;
    $scope.selected = {
        item: $scope.items[0]
    };


    $scope.ok = function () {
        //Close and Pass result
        $modalInstance.close("abc");
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };

}

angular.module("GlobalModule").controller("modalDemoController", ModalDemoController);
ModalDemoController.$inject = ['$scope', '$modal'];
function ModalDemoController($scope, $modal) {

    $scope.items = ['item1', 'item2', 'item3'];

    $scope.open = function (size) {

        var modalInstance = $modal.open({
            templateUrl: 'myModalContent.html',
            controller: 'modalInstanceController',
            size: size,
            resolve: {
                items: function () { return $scope.items; }
            }
        });
        modalInstance.result.then(function (selectedItem) {
            //Read result of modal and set to $scope.selected
            $scope.selected = selectedItem;
        }, function () {
        });
    };
}