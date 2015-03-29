//angular.module('GlobalModule', [])
//.controller('ChangePasswordController', ['$scope', function ($scope) {
//    $scope.passold = '';
//    $scope.CheckPass = function () {
//        $scope.success = 'Đổi mật khẩu thành công';
//        $scope.fail = 'Sai mật khẩu';
//        if ($scope.passold == 'vinh') {
//            alert($scope.success);
//        }
//        else { alert($scope.fail); }
//    };
//}]);


//$.ajax({
//    type: 'POST',
//    url: 'ChangePasswordController.cs/CheckPass',
//    data: JSON.stringify({ passold: 'John', pass : 'new' }),
//    contentType: 'application/json; charset=utf-8',
//    dataType: 'json',
//    success: function (msg) {
//        // Do something interesting here.
//        alert(msg.d);
//    }
//});


angular.module("GlobalModule").controller("changePasswordController", ChangePasswordController);
ChangePasswordController.$inject = ['$scope', '$http'];
function ChangePasswordController($scope, $http) {
    $scope.passold = '';
    $scope.passnew = '';
    var m = { AccountName: 'vinhpham', Password: $scope.passold };
    
    //aler(myData.passold);
    $scope.CheckPass = function () {
        $http.post("/ChangePassword/CheckPass", JSON.stringify({model: m, passnew: $scope.passnew }).success(function (data, status, headers, config) {
            if (data) {
                if (data == 0)
                {
                    alert("Mật khẩu hiện tại không đúng");
                }
                else alert("Đổi mật khẩu thành công");
                
            }
        }).error(function (data, status, headers, config) {
            // log 
            alert("I am an alert box bug!");
        });

    }

}