
(function () {
    angular.module("GlobalModule", ['ui.bootstrap', 'ngTouch', 'ui.grid', 'ui.grid.pagination', 'ui.grid.edit', 'ui.grid.resizeColumns',
                                    'ui.grid.selection', 'ui.grid.moveColumns', 'ui.grid.saveState', 'ui.bootstrap']);

})();

//Alert class to show error message in div 
function Alert(element, message, type, position, size, delayTime) {

    position = position || "right";
    size = delayTime || "4";
    delayTime = delayTime || 3000;
    var self = $("#" + element);

    this.Show = function () {

        $(self).empty();
        $(self).removeClass();
        $(self).addClass("pull-" + position);
        $(self).addClass("col-md-" + size);
        $(self).addClass("alert alert-" + type);
        $(self).append('<a href="#" class="close" id="closeAlertTag" >&times;</a>' + message);
        $(self).fadeIn().delay(delayTime).fadeOut();
        var atag = $('#closeAlertTag')
        atag.click(function () {
            $($(atag).parent()).hide();
        });
    }

    this.Hide = function () {
        $(self).fadeOut();
    }
}

//Wait-Dialog class to show Processing message in modal
function WaitDialog() {

    var pleaseWaitDiv = $('<div class="modal fade" id="pleaseWaitDialog" data-backdrop="static" data-keyboard="false" role="dialog" aria-labelledby="basicModal" aria-hidden="true" tabindex="-1"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><h1>Processing...</h1></div><div class="modal-body"><div class="progress progress-striped active"><div class="progress-bar" style="width: 100%;"/></div></div></div></div></div>');

    this.Show = function () {
        pleaseWaitDiv.modal();
    }
    this.Hide = function () {
        pleaseWaitDiv.modal('hide');
    }
}

// Controller xu ly cac thao tac cua message Modal
angular.module("GlobalModule").controller("messageModalController", MessageModalController);
MessageModalController.$inject = ['$scope', '$modalInstance', 'data'];
function MessageModalController($scope, $modalInstance, data) {

    $scope.data = data;

    $scope.ok = function () {
        //Close and Pass return result
        $modalInstance.close();
    };
    //$scope.cancel = function () {
    //    $modalInstance.dismiss('cancel');
    //};

}

//Controller goi modal va truyen input
angular.module("GlobalModule").controller("callingModalController", CallingModalController);
CallingModalController.$inject = ['$scope', '$modal'];
function CallingModalController($scope, $modal) {

    $scope.showMessageError = function (size, template) {

        var modalInstance = $modal.open({
            templateUrl: template,
            controller: 'messageModalController',
            size: size,
            resolve: {
                data: function () { return { Title: 'abc', Content: 'acdss' } }
            }
        });
        //modalInstance.result.then(function (OKData) {
        //    //Read result of modal when user click Ok in modal and set to $scope.selected
        //    $scope.selected = OKData;
        //}, function (cancelData) {
        //    $scope.selected = cancelData;
        //});
    };
}