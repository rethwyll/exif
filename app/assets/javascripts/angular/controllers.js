'use strict';

var flickrUrl = function(options) {
  var url = 'http://api.flickr.com/services/rest/?api_key=06f65c8532aa60de4826737b5abd4101&format=json&nojsoncallback=1';
  for (var key in options) {
    if (options.hasOwnProperty(key)) {
      url += '&' + key + '=' + options[key];
    }
  }
  return url;
}

var CONSTANTS = {
  EXIF_KEYS: ['ExposureTime','FNumber','ExposureProgram','ISO','Flash','FocalLength','MeteringMode','FocalLength','ColorSpace','CreateDate']
}

/* Controllers */
angular.module('exif.controllers', []). 
  controller('MapCtrl', ['$rootScope','$scope','$http','CurrentPlaceService',function($rootScope,$scope,$http,CurrentPlaceService){
    $scope.placelist = [];
    $http.get('http://localhost:3000/place').then(
      function (r) { 
        $scope.placelist = r.data.slice(0,15);
      },
      function(r,s){    
        $scope.placelist = [];      
      }
    );
    $scope.sort = "+site";
    $scope.setCurrentPlace = function(id){
      CurrentPlaceService.set( ($scope.placelist.filter(function(v) { return v.id === id }))[0] );
      $rootScope.$broadcast('selectCurrentPlace'); 
    };
  }]).
  controller('PlaceCtrl', ['$rootScope','$scope','CurrentPlaceService',function($rootScope,$scope,CurrentPlaceService){
    $scope.$on('selectCurrentPlace', function(){
      var currentPlace = CurrentPlaceService.get();
      if (currentPlace) {
        $scope.title = currentPlace.site;
        $scope.lat = currentPlace.latitude;
        $scope.lon = currentPlace.longitude;
      }      
      $rootScope.$broadcast('getPlacePhotos');
    });
  }]).
  controller('ExifCtrl', ['$rootScope','$scope','$http','CurrentPlaceService',function($rootScope,$scope,$http,CurrentPlaceService) {
    $scope.$on('getPlacePhotos', function(){
      var currentPlace = CurrentPlaceService.get();
      $scope.exiflist = [];
      $scope.exiflist_g = [];
      $scope.photolist = [];  
 
      var photoUrl = flickrUrl({ method: 'flickr.photos.search', lat: currentPlace.latitude, lon: currentPlace.longitude });
      $http.get(photoUrl).then(
        function (r) { 
          $scope.photolist = r.data.photos.photo.slice(0,10);     
          for(var i=0,l=$scope.photolist.length; i<l; i++) {
            var id = $scope.photolist[i].id
            var exifUrl = flickrUrl({ method: 'flickr.photos.getExif', photo_id: id });
            $http.get(exifUrl).then(
              function (r) {
                if (r.data.photo.exif.length) {
                  $scope.exiflist.push({ photo_id: id, items: _.select( r.data.photo.exif, function(o){ return _.contains(CONSTANTS.EXIF_KEYS, o.tag) }) });
                }
              }
            )
          }      
        }
      );        
    });
    $rootScope.time = 12;
  }]);