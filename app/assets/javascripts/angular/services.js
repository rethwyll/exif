'use strict';

/* Services */


// Demonstrate how to register services
// In this case it is a simple value service.
angular.module('exif.services', []).
  value('version', '0.1').
	service('CurrentPlaceService', function(){
		this.currentPlace = false;
		this.get = function () {
			return this.currentPlace;
		};
		this.set = function(value) {
		  this.currentPlace = value;
		};
	});
