
(function () {

    angular.module("GlobalModule", ['ui.bootstrap', 'ngTouch', 'ui.grid', 'ui.grid.pagination', 'ui.grid.edit', 'ui.grid.resizeColumns', 'ui.grid.selection', 'ui.grid.moveColumns', 'ui.grid.saveState','ui.bootstrap']);
})();

function Alert(element, message, type, position, size, delayTime) {

    position = typeof position !== 'undefined' ? position : "right";
    size = typeof size !== 'undefined' ? delayTime : "4";
    delayTime = typeof delayTime !== 'undefined' ? delayTime : 3000;
    var selft = $("#" + element);

    this.ShowAlert = function () {
        $(selft).removeClass();
        $(selft).addClass("pull-"+position);
        $(selft).addClass("col-md-"+size);
        $(selft).addClass("alert alert-" + type);
        $(selft).text(message);
        $(selft).fadeIn().delay(delayTime).fadeOut();
    }
}
