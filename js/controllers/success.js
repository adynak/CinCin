draanks.controller('SuccessController', ['$scope', '$http', '$location', 'Data', '$rootScope', '$routeParams', 'toaster',
    function($scope, $http, $location, Data, $rootScope, $routeParams, toaster) {

        $scope.prompts = txtSideMenu;
        $scope.member = Data.getCurrentMember();

        if (typeof($scope.member) !== 'undefined'){
            if ($scope.member.onlineid == 'guest'){
                Data.logout().then(function(status) {
                    if (status == 'success') {
                        $location.path('/login');
                        toaster.pop('info', "", txtLogin.logOut, 3000, 'trustedHtml');
                    } else {
                        $scope.invalidmessage = 'log out failed';
                    }
                }, function(err) {
                    $scope.invalidmessage = err;
                });                
            }
        }

        $scope.applyThisClass = function(memberProfile) {
            if (typeof(memberProfile) !== 'undefined'){
                if (memberProfile.member_type) {
                    return "";
                } else {
                    return "sr-only";
                }
            }
        };

        $scope.updateMemberInfo = function() {
            Data.updateMemberInfo().then(function(status) {
                toaster.clear();
                if (status == 'success') {
                    $location.path('/success');
                    toaster.pop('info', "", 'successfully updated', 3000, 'trustedHtml');
                } else if (status == 'usernameexists') {
                    $scope.invalidmessage = 'Member name already exists';
                    toaster.pop('warning', "", 'username exists', 3000, 'trustedHtml');
                } else {
                    $scope.invalidmessage = 'Update failed';
                }
            }, function(err) {
                $scope.invalidmessage = err;
            });
        };
    }
]);