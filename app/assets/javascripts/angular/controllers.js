'use strict';

/* Controllers */
angular.module('exif.controllers', []). 
  controller('MapCtrl', ['$rootScope','$scope','$http','GetPlacelistService','CurrentPlaceService',function($rootScope,$scope,$http,CurrentPlaceService){
    $scope.placelist = GetPlacelistService.get();
    $scope.sort = "+site";
    $scope.setCurrentPlace = function(id){
      CurrentPlaceService.set( ($scope.placelist.filter(function(v) { return v.id === id }))[0] );
      $rootScope.$broadcast('setCurrentPlace'); 
      $rootScope.$broadcast('getExif');
    };
  }]).
  controller('PlaceCtrl', ['$rootScope','$scope','CurrentPlaceService',function($rootScope,$scope,CurrentPlaceService){
    $scope.$on('setCurrentPlace', function(){
      var currentPlace = CurrentPlaceService.get();
      if (currentPlace) {
        $scope.title = currentPlace.site;
        $scope.lat = currentPlace.latitude;
        $scope.lon = currentPlace.longitude;
      }      
    });
  }]).
  controller('ExifCtrl', ['$rootScope','$scope','$http','CurrentPlaceService','GetExifService',function($rootScope,$scope,$http,CurrentPlaceService,GetExifService) {
    $scope.$on('getExif', function(){
      var currentPlace = CurrentPlaceService.get();
      for (var i=0, l=window.exif.attributes.length; i<l; i++) {
        var exif = GetExifService.get({ place: currentPlace.id, attribute: window.exif.attributes[i] });
        $scope.exiflist.push( new D3({ exif: exif }) )
      }
    });
    $rootScope.time = 12;
  }]);