'use strict';

angular.
    module('fetchGroups').
    component('fetchGroups',
    {
        templateUrl: 'app/fetch-groups/fetch-groups.template.html',
        controller: function FetchGroupsController($scope, $resource, Api)
        {
            $scope.data = {};
            $scope.filterGroups = {
                iam: null,
                system: null,
                game: null,
                activity: null,
                language: null
            }
            $scope.limit = 10;

            angular.element(document).ready(function(){
                $scope.init();
                $scope.getLatest();
                // $scope.applyFilter();
            });

            $scope.init = function()
            {
                $scope.systems = Api.Systems.get();
                $scope.games = Api.Games.get();
                $scope.getLatest();
            }

            $scope.getLatest = function()
            {
                var data = "[[],"+$scope.limit+"]";
                $scope.lastRequest = data;
                Api.GetGroup.get(data, function(response, getResponseHeaders)
                {
                    $scope.groupList = response.data;
                });

            }

            $scope.refresh = function()
            {
                Api.GetGroup.get($scope.lastRequest, function(response, getResponseHeaders)
                {
                    $scope.groupList = response.data;
                });
            }

            $scope.getGames = function()
            {
                $scope.games = ($scope.filterGroups.system) ? Api.Games.get({systemId:$scope.filterGroups.system}) : Api.Games.get();

                $scope.activites = null; //Ensure we do not mix activities with other games.
            }

            $scope.getActivities = function()
            {
                if ($scope.filterGroups.system)
                {
                    $scope.activities = Api.Activities.single({systemId:$scope.filterGroups.system, gameId:$scope.filterGroups.game});
                }
                else
                {
                    $scope.activities = Api.Activities.all({gameId:$scope.filterGroups.game});
                }
            }

            $scope.applyFilter = function()
            {

                var filters = {},
                    data = new Array;

                if ($scope.filterGroups.iam) { filters["group_iam"] = $scope.filterGroups.iam; }
                if ($scope.filterGroups.system) { filters["group_system"] = $scope.filterGroups.system; }
                if ($scope.filterGroups.game) { filters["group_game"] = $scope.filterGroups.game; }
                if ($scope.filterGroups.activity) { filters["group_activity"] = $scope.filterGroups.activity; }
                if ($scope.filterGroups.language) { filters["group_language"] = $scope.filterGroups.language; }

                var data = new Array(filters, $scope.limit);
                $scope.lastRequest = data;
                data = JSON.stringify(data);

                Api.GetGroup.get(data, function(response, getResponseHeaders)
                    {
                        $scope.groupList = response.data;
                    });
            }

            $scope.hideMenu = function()
            {
                $("#filterGlyph").toggleClass("flipped");
                $('#formTray').toggleClass("fetchTrayUp");
                $('#submitForm').toggleClass("fetchFormUp");
            }

        }
    });
