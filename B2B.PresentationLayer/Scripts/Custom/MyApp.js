
(function () {

    'use strict';

    angular.module("GlobalModule", ['ngRoute', 'ui.bootstrap', 'ngTouch', 'ui.grid', 'ui.grid.pagination', 'ui.grid.edit', 'ui.grid.resizeColumns',
                                    'ui.grid.selection', 'ui.grid.moveColumns', 'ui.grid.saveState', 'ui.bootstrap', 'ngTagsInput', 'ngSanitize',
                                    'ui.select', 'ngFileUpload', 'progress.bar']);

    angular.module("GlobalModule").run(rootModal);
    angular.module("GlobalModule").factory('modalService', modalService);
    angular.module("GlobalModule").factory('notifyService', notifyService);
    angular.module("GlobalModule").factory('shareService', shareService);

})();

// Controller xu ly cac thao tac cua message Modal
angular.module("GlobalModule").controller("messageModalController", messageModalController);
messageModalController.$inject = ['$scope', '$modalInstance', 'data'];
function messageModalController($scope, $modalInstance, data) {

    //set data in modal scope
    $scope.data = data;

    $scope.ok = function () {
        //Close and Pass return result
        $modalInstance.close('ok');
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
}

// Controller xu ly cac thao tac cua message Modal
angular.module("GlobalModule").controller("gridModalController", gridModalController);
gridModalController.$inject = ['$scope', '$modalInstance', '$interval', 'data'];
function gridModalController($scope, $modalInstance, $interval, data) {

    $scope.$scope = $scope;

    //set data in modal scope
    $scope.GridData = data;
    $scope.gridOptions = {};
    $scope.gridApi = {};

    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.detailsCellTemplate = '<button ng-click="getExternalScopes().getDetails(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-camera"/></button> ';
    $scope.gridOptions.columnDefs = [
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
          { name: 'name', displayName: 'Name', headerCellTemplate: '<div title="Tooltip Content">Name</div>', width: 150 },
          {
              name: 'tuoi', displayName: 'tuoi', width: 50, type: 'number'
          },
          { name: 'Details', displayName: 'Details', width: 50, cellTemplate: $scope.detailsCellTemplate }
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "GridData";
    $scope.gridOptions.onRegisterApi = function (gridApi) {
        $scope.gridApi = gridApi;
        $interval(function () {
            $scope.gridApi.core.handleWindowResize();
        }, 10, 500);
    };

    $scope.ok = function () {
        //Close and Pass return result
        $modalInstance.close('ok');
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
}

//Storing modal object in rootScope for calling in controllers
rootModal.$inject = ['$rootScope', '$modal'];
function rootModal($rootScope, $modal) {

    $rootScope.AppPath = $("#appPath").attr("href");
    $rootScope.ShowModal = function (funcOk, funcCancel, myData) {

        var modalInstance = $modal.open({
            templateUrl: myData.Template || 'messageModal.html',
            backdrop: 'static',
            keyboard: false,
            size: myData.Size || 'sm',
            controller: myData.MessageController || 'messageModalController',
            resolve: {
                data: function () { return myData; }
            }
        });

        modalInstance.result.then(funcOk, funcCancel);
    };
}

//Wait-Dialog class to show Processing message in modal
function WaitDialog(modalContent) {

    modalContent = modalContent || "Processing...";
    var pleaseWaitDiv = $('<div class="modal fade" id="pleaseWaitDialog" data-backdrop="static" data-keyboard="false" role="dialog" aria-labelledby="basicModal" aria-hidden="true" tabindex="-1"><div class="modal-dialog"><div class="modal-content"><div class="modal-header bg-primary"><div>' + modalContent + '</div></div><div class="modal-body"><div class="progress progress-striped active"><div class="progress-bar" style="width: 100%;"/></div></div></div></div></div>');

    this.Show = function () {
        pleaseWaitDiv.modal();
    };
    this.Hide = function () {
        pleaseWaitDiv.modal('hide');
    };
}

modalService.$inject = ['$modal'];
function modalService($modal) {

    var serviceObject = {};
    serviceObject.ShowModal = function (funcOk, funcCancel) {

        var modalInstance = $modal.open({
            templateUrl: 'gridModal.html',
            backdrop: 'static',
            keyboard: false,
            controller: 'gridModalController',
            size: 'lg',
            resolve: {
                data: function () { return []; }
            }
        });

        modalInstance.result.then(funcOk, funcCancel);
    };

    return serviceObject;

}

//Service to show notification message
notifyService.$inject = ['$rootScope', '$timeout'];
function notifyService($rootScope, $timeout) {

    $rootScope.queue = [];
    var serviceObject = {};

    serviceObject.add = function (item) {
        $rootScope.queue.push(item);
        $timeout(function () {
            // remove the alert after 2000 ms
            $('.alerts .alert').eq(0).remove();
            $rootScope.queue.shift();
        }, 3000);
    };

    serviceObject.pop = function () {
        $rootScope.queue.pop();
    };

    return serviceObject;

}

//share service to share data between controllers
shareService.$inject = ['$rootScope'];
function shareService($rootScope) {

    'use strict';

    var serviceObject = {};

    //publish event to another scope
    serviceObject.raiseEvent = function (name, data) {
        $rootScope.$broadcast(name, data);
    };

    //listen event to handle
    serviceObject.onEvent = function ($scope, name, handler) {
        $scope.$on(name, function (event, args) {
            handler(args);
        });
    };

    return serviceObject;
}
