
angular.module("GlobalModule").controller("quoteController", QuoteController);
QuoteController.$inject = ['$scope', '$http', 'Upload', '$location', '$q', 'modalService', 'notifyService'];
function QuoteController($scope, $http, Upload, $location, $q, modalService, notifyService) {

    'use strict';

    $scope.$scope = $scope;


    $scope.timer_running = false;
    $scope.max_count = 25;

    $scope.stopProgress = function () {
        $scope.timer_running = false;
    };

    $scope.startProgress = function () {
        $scope.timer_running = true;
    };

    $scope.fileReaderSupported = window.FileReader != null && (window.FileAPI == null || FileAPI.html5 != false);

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
            //   $scope.ShowModal(null, null, { Title: '', Content: '', OkButton:'',CancelButton:'',Template: '', MessageController: '', Size: '' });

        }).error(function (data, status, headers, config) {
        });
    };

    $scope.dataForTuoi = [{ id: 1, tuoi: 12 }, { id: 2, tuoi: 12 }, { id: 3, tuoi: 17 }, { id: 4, tuoi: 19 }, { id: 5, tuoi: 16 }];

    $scope.gridOptions = {};
    $scope.deleteCellTemplate = '<button ng-click="getExternalScopes().deleteRow(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-trash"/></button> ';
    $scope.detailsCellTemplate = '<button ng-click="getExternalScopes().getDetails(row.entity)" class="btn btn-danger btn-xs"><i class="fa fa-camera"/></button> ';
    $scope.gridOptions.columnDefs = [
          { name: '_delete', displayName: "", cellTemplate: $scope.deleteCellTemplate, width: 25, enableFiltering: false, enableCellEdit: false },
  	      { name: 'name', displayName: 'Name', headerCellTemplate: '<div title="Tooltip Content">Name</div>', width: 150 },
  	      {
  	          name: 'tuoi', displayName: 'tuoi', width: 50, type: 'number', editableCellTemplate: 'ui-grid/dropdownEditor', editDropdownValueLabel: 'tuoi', editDropdownOptionsArray: $scope.dataForTuoi
  	      },
          { name: 'Details', displayName: 'Details', width: 50, cellTemplate: $scope.detailsCellTemplate }
    ];
    $scope.gridOptions.paginationPageSizes = [25, 50, 75];
    $scope.gridOptions.paginationPageSize = 25;
    $scope.gridOptions.data = "myData";
    $scope.gridOptions.enableFiltering = false;


    //angular.copy();


    //Demo show datetime formart
    $scope.Giatri = Date.now();

    //upload file region
    $scope.myFile = {};

    $scope.upload = function (file) {
        if (file && file.length) {
            Upload.upload({
                url: '/Quote/UploadFile',
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

    $scope.ShowGridModal = function () {
        modalService.ShowModal(null, null);
    };

    //$scope.myFile = {};
    //$scope.readURL = function (files, e) {
    //    var input = e.target;
    //    if (input.files && input.files[0]) {
    //        var reader = new FileReader();

    //        reader.onload = function (e) {
    //            //$('#imgAvatar').attr('src', e.target.result);
    //            $timeout(function () {
    //                $scope.img = e.target.result;
    //            });
    //        }

    //        reader.readAsDataURL(input.files[0]);
    //        $scope.myFile = input.files[0];
    //    }
    //}

    $scope.learnEvent = function (e) {
        alert(e.target.id);
    };



    $scope.CallMessage = function () {
        notifyService.add({ type: 'warning', title: 'Wow', body: 'You`re a really good button clicker!' });
    };

}

