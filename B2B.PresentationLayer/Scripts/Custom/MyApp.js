
(function () {
    angular.module("GlobalModule", ['ngRoute', 'ui.bootstrap', 'ngTouch', 'ui.grid', 'ui.grid.pagination', 'ui.grid.edit', 'ui.grid.resizeColumns',
                                    'ui.grid.selection', 'ui.grid.moveColumns', 'ui.grid.saveState', 'ui.bootstrap', 'ngTagsInput', 'ngSanitize',
                                    'ui.select', 'angularFileUpload']);


    // Controller xu ly cac thao tac cua message Modal
    angular.module("GlobalModule").controller("messageModalController", MessageModalController);
    MessageModalController.$inject = ['$scope', '$modalInstance', 'data'];
    function MessageModalController($scope, $modalInstance, data) {

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
    angular.module("GlobalModule").controller("gridModalController", GridModalController);
    GridModalController.$inject = ['$scope', '$modalInstance', '$interval', 'data'];
    function GridModalController($scope, $modalInstance, $interval, data) {

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
    RootModal.$inject = ['$rootScope', '$modal'];
    function RootModal($rootScope, $modal) {

        $rootScope.AppPath = $("#appPath").attr("href");
        $rootScope.ShowModal = function (funcOk, funcCancel, myData) {

            var modalInstance = $modal.open({
                templateUrl: myData.Template || 'messageModal.html',
                backdrop: 'static',
                keyboard: false,
                size: myData.Size || 'sm',
                controller: myData.MessageController || 'messageModalController',
                resolve: {
                    data: function () { return { Title: title, Content: content, ButtonOk: okButton, ButtonCancel: cancelButton } }
                }
            });

            modalInstance.result.then(funcOk, funcCancel);
        };
    }

    angular.module("GlobalModule").run(RootModal);
    angular.module("GlobalModule").factory("modalService", ModalService);


})();

//Wait-Dialog class to show Processing message in modal
function WaitDialog(ModalContent) {

    ModalContent = ModalContent || "Processing...";
    var pleaseWaitDiv = $('<div class="modal fade" id="pleaseWaitDialog" data-backdrop="static" data-keyboard="false" role="dialog" aria-labelledby="basicModal" aria-hidden="true" tabindex="-1"><div class="modal-dialog"><div class="modal-content"><div class="modal-header bg-primary"><div>' + ModalContent + '</div></div><div class="modal-body"><div class="progress progress-striped active"><div class="progress-bar" style="width: 100%;"/></div></div></div></div></div>');

    this.Show = function () {
        pleaseWaitDiv.modal();
    }
    this.Hide = function () {
        pleaseWaitDiv.modal('hide');
    }
}


ModalService.$inject = ['$modal'];
function ModalService($modal) {

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