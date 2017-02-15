'use strict';

angular.
    module('addGroup').
    component('addGroup',
    {
        templateUrl: 'app/add-group/add-group.template.html',
        controller: function groupComponentsController($scope, $resource, $timeout, Api, MessageBar)
        {
            $scope.data = {};
            $scope.groupComponents = {
                user: null,
                iam: null,
                system: null,
                game: null,
                activity: null,
                details: null,
                language: null
            }
            $scope.limit = 10;

            angular.element(document).ready(function(){
                $scope.init();
            });

            $scope.init = function()
            {
                $scope.getSystems();
                $scope.getGames();
            }

            $scope.getSystems = function()
            {
                Api.Systems.get({},
                    function(response)
                    {
                        $scope.systems = response;
                    });
            }

            $scope.getGames = function()
            {
                
                var response = ($scope.groupComponents.system) ? Api.Games.get({systemId:$scope.groupComponents.system}) : Api.Games.get();

                response.$promise.then(function(){
                    $scope.games = response.data;
                });

                $scope.activites = null; //Ensure we do not mix activities with other games.
            }

            $scope.getActivities = function()
            {

                var response = ($scope.groupComponents.system) ? Api.Activities.single({systemId:$scope.groupComponents.system, gameId:$scope.groupComponents.game}) : Api.Activities.all({gameId:$scope.groupComponents.game});

                response.$promise.then(
                    function()
                    {
                        $scope.activities = response;
                    });
            }

            $scope.submitGroup = function()
            {
                var filters = {},
                    data = new Array,
                    error = false;

                var requirements = [["user","group_user","#addGroupUser"],["iam","group_iam","#addGroupIam"],["system","group_system","#addGroupSystem"],["game","group_game","#addGroupGame"],["activity","group_activity","#addGroupActivity"],["language","group_language","#addGroupLanguage"]];

                for (var i = 0; i < requirements.length; i++)
                {
                    if ($scope.groupComponents[requirements[i][0]])
                    {
                        filters[requirements[i][1]] = $scope.groupComponents[requirements[i][0]];
                        $(requirements[i][2]).removeClass("formError");
                    }
                    else
                    {
                        $(window).scrollTop($('#submitGroup').position().top);
                        $(requirements[i][2]).removeClass("formError");
                        $(requirements[i][2]).addClass("formError");
                        error = true;
                    }
                }

                //group_details is the only one that can be null
                filters["group_details"] = $scope.groupComponents.details;

                if (error) { return; }

                $('.loadingGear').toggleClass('gearUp');

                data = filters;
                data = JSON.stringify(data);

                Api.AddGroup.save(data, function(response, getResponseHeaders)
                    {

                        $('.loadingGear').toggleClass('gearUp');

                        if (response.status == "success")
                        {
                            MessageBar.displaySuccess("Group Added!");
                            // document.getElementById("message").innerHTML = "Group Added!";
                        }
                        else if (response.status == "error")
                        {
                            MessageBar.displayError("Submission Error", response.errorCode);
                        }
                        else
                        {
                            MessageBar.displayError("Site Error, Contact Admin", response.errorCode);
                        }

                        MessageBar.enableDisplay();

                    });
            }

            $scope.hideMenu = function()
            {
                $("#addGlyph").toggleClass("flipped");
                $('#addTray').toggleClass("addTrayUp");
                $('#addForm').toggleClass("addFormUp");
            }

        }
    });
