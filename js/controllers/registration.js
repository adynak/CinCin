draanks.controller('RegistrationController', ['$scope', '$http', '$location', 'Data', '$rootScope', 'toaster',
    function($scope, $http, $location, Data, $rootScope, toaster) {

        $scope.prompts    = txtLogin;
        $scope.promptsReg = txtProfile;
        $scope.required   = false;
        $scope.image      = 'resources/images/drinks.jpeg';
        
        $scope.login = function() {
            member = $scope.member;
            // if (typeof(member) == 'undefined') member = {email:'guest',password:'guest',onlineID:'guest'};
            if (typeof(member) == 'undefined') member = {email:'adynak@gmail.com',password:'adynak',onlineID:'adynak'};

            Data.validateCredentials(member).then(function(status) {
                if (status.validated == 'success') {
                    Data.setCurrentMember(status.member);
                    if (member.email == 'guest'){
                        $location.path('/cocktailLibrary');
                    } else {
                        $location.path('/success');
                    }
                    toaster.pop('success', "", txtLogin.credentialsValid, 3000, 'trustedHtml');
                } else {
                    Data.setCurrentMember('');
                    $scope.invalidMessage = txtLogin.credentialsInvalid;
                    toaster.pop('error', "", txtLogin.credentialsInvalid, 3000, 'trustedHtml');
                }

            }, function(err) {
                $scope.invalidMessage= err;
            });

        };

        $scope.register = function() {
              // action="https://script.google.com/macros/s/AKfycbwL0BWFFP7Pz-qsjqpuLUCEtjlN2qSvxehkmLXzued3xhron0lS/exec">
            toaster.pop('warning', "", txtLogin.registrationSent, 3000, 'trustedHtml');
            
            Data.registerMember($scope.member).then(function(status) {
                status = 'success';
                if (status == 'success') {
                    $scope.member = {onlineID:'guest',password:'guest',email:'guest'};
                    $scope.login();
                    toaster.pop('success', "", txtLogin.registrationSuccess, 5000, 'trustedHtml');
                } else {
                    Data.setCurrentMember('');
                    txtLogin.credentialsInvalid = status;
                    toaster.pop('warning', "", status, 3000, 'trustedHtml');
                }

            }, function(err) {
                $scope.invalidMessage= err;
            });
        };

        $scope.logout = function() {
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
        };

    }
]);