'user strict';

angular.
    module('mainNav').
    component('mainNav',
    {
        templateUrl: "app/main-nav/main-nav.template.html",
        controller: function MainNavController($scope, $location)
        {

            angular.element(document).ready(function(){
                $scope.init();
            });

            $scope.init = function()
            {
                var path = $location.path().replace("/", "");
                $("#"+path+"Link").toggleClass("navActive");
            }

            $scope.setActive = function($event)
            {
                var urlPath = $location.path().replace("/", "");
                var linkPath = $event.currentTarget.id;

                if (linkPath == "logoLink") {linkPath = "homeLink";}

                $("#"+urlPath+"Link").toggleClass("navActive");
                $("#"+linkPath).toggleClass("navActive");

                window.scrollTo(0,0);
            }

            $scope.hideBar = function()
            {
                $('#messageBar').removeClass("messageActive");
            }
        }
    });