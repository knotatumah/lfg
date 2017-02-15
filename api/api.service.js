angular.
    module('api').
    factory('Api',['$resource',
        function($resource)
        {
            return {
                AddGroup: $resource("api/index.php/addGroup"),
                GetGroup: $resource("",{},{
                    get: {
                        method: "POST",
                        url: "api/index.php/groups"
                    }
                }),
                Systems: $resource("api/index.php/systems"),
                Games: $resource("api/index.php/games/:systemId"),
                Activities: $resource("",{},{
                    single: {
                        method: "GET",
                        url: "api/index.php/activities/:systemId/:gameId",
                        params: {}
                    },
                    all: {
                        method: "GET",
                        url: "api/index.php/activities/:gameId",
                        params: {}
                    }
                })
            };
        }]);