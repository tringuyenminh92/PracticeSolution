
(function () {

    angular.module("GlobalModule", ['ui.bootstrap', 'ngTouch', 'ui.grid', 'ui.grid.pagination', 'ui.grid.edit', 'ui.grid.resizeColumns',
                                    'ui.grid.selection', 'ui.grid.moveColumns', 'ui.grid.saveState', 'ui.bootstrap']);

})();

//Alert class to show error message
function Alert(element, message, type, position, size, delayTime) {

    position = position || "right";
    size = delayTime || "4";
    delayTime = delayTime || 3000;
    var selft = $("#" + element);

    this.ShowAlert = function () {
        $(selft).removeClass();
        $(selft).addClass("pull-" + position);
        $(selft).addClass("col-md-" + size);
        $(selft).addClass("alert alert-" + type);
        $(selft).text(message);
        $(selft).fadeIn().delay(delayTime).fadeOut();
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