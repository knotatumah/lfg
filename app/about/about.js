'use strict';

angular.module("about",["ngRoute"])

.config(["$routeProvider", function($routeProvider){
	$routeProvider.when("/about",
	{
		templateUrl: "app/about/about.template.html",
		controller: "AboutControler"
	});
}])

.controller("AboutController",[function(){}]);