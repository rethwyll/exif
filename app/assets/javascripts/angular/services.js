'use strict';

/* Services */


// Demonstrate how to register services
// In this case it is a simple value service.
angular.module('exif.services', []).
  value('version', '0.1').
	service('GetPlacelistService', function(){
		this.placelist = [];
    $http.get('http://localhost:3000/place').then(
      function (r) { 
        this.placelist = r.data;
      },
      function(r,s){    
        this.placelist = [];      
      }
    );
		this.get = function () {
			return this.placelist;
		};
	}).
	service('CurrentPlaceService', function(){
		this.currentPlace = false;
		this.get = function () {
			return this.currentPlace;
		};
		this.set = function(value) {
		  this.currentPlace = value;
		};
	}).
	service('GetExifService', function(){
		this.get = function(options) {
      $http.get('http://localhost:3000/' + options.place + '/' + options.attribute).then(
        function (r) { return r },
        function (r,s) { return [] }
      );
		}
	});
