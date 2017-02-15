'use strict';

// Declare app level module which depends on views, and components
angular.module('lfgApp',
[
    'api',
    'about',
    'mainNav',
    'fetchGroups',
    'addGroup',
    'ngRoute',
    'home',
    'messageBar'
]).
config(['$locationProvider', '$routeProvider', function($locationProvider, $routeProvider)
{
    $locationProvider.hashPrefix('!');

    $routeProvider.
    when("/about",{ templateUrl: 'app/about/about.template.html' }).
    otherwise({ redirectTo: '/home' });
}]);