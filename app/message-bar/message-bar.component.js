angular.
    module("messageBar").
    factory("MessageBar",
        function($timeout)
        {
            return {

                displaySuccess: function(message)
                {
                    document.getElementById("message").innerHTML = message;
                },

                displayError: function (message, errorCode)
                {
                    document.getElementById("message").innerHTML = message + " (Err: "+errorCode+")";
                },

                enableDisplay: function()
                {
                    $('#messageBar').toggleClass('messageActive');
                    $timeout(function(arg){arg.this.disableDisplay();},5000,true,{this:this});
                },

                disableDisplay: function()
                {
                    $('#messageBar').removeClass('messageActive');
                }
            }
        }
    );