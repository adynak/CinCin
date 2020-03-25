var draanks = angular.module('draanks', 
        [
            'ngRoute', 
            'ngAnimate', 
            'toaster', 
            'ngTouch',
            'ui.grid', 
            'ngMessages',
            'dndLists', 
            'ui.grid.grouping', 
            'ui.grid.autoResize'
        ]
);

draanks.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    
    $locationProvider.hashPrefix(''); 

    document.title = txtNavigation.brandName;
    $routeProvider.
    when('/login', {
        templateUrl: 'views/login.html',
        controller: 'RegistrationController',
        task: 'getsessiondata'
    }).
    when('/register', {
        templateUrl: 'views/register.html',
        controller: 'RegistrationController',
        task: 'getsessiondata'
    }).
    when('/success', {
        templateUrl: 'views/success.html',
        controller: 'SuccessController',
        task: 'getsessiondata'
    }).
    when('/profile', {
        templateUrl: 'views/maintain/profile.html',
        controller: 'ProfileController',
        task: 'getsessiondata'
    }).
    when('/newRecipe', {
        templateUrl: 'views/maintain/newRecipe.html',
        controller: 'NewRecipeController',
        task: 'getsessiondata'
    }).
    when('/cocktailLibrary', {
        templateUrl: 'views/cocktailLibrary.html',
        controller: 'CocktailLibraryController',
        task: 'getsessiondata'
    }).
    when('/maintain/menu', {
        templateUrl: 'views/maintain/menu.html',
        controller: 'MaintainMenuController',
        task: 'getsessiondata'
    }).
    when('/maintain/category', {
        templateUrl: 'views/maintain/maintain.html',
        controller: 'MaintainController',
        task: 'getsessiondata'
    }).
    when('/maintain/ingredient', {
        templateUrl: 'views/maintain/maintain.html',
        controller: 'MaintainController',
        task: 'getsessiondata'
    }).
    when('/maintain/measure', {
        templateUrl: 'views/maintain/maintain.html',
        controller: 'MaintainController',
        task: 'getsessiondata'
    }). 
    when('/getSecurity',{
        templateUrl: 'views/security.html',
        controller: 'SecurityController',
        task: 'getsessiondata'
    }).    
    otherwise({
        redirectTo: '/login',
        task: 'getsessiondata'

    });


}]).run(function($rootScope, $location, Data) {

    Data.setDeviceType(navigator.userAgent);
    Data.setGridHeight("");    

    window.addEventListener("orientationchange", function() {
        $rootScope.$broadcast('orientationchange');
        Data.setGridHeight(screen);
    }, false);


    $rootScope.$on("$routeChangeStart", function(event, next, current) {
        var securityInfo = Data.getSecurityInfo();
        if (securityInfo.stop){
            $location.path("/getSecurity");
            next.templateUrl = 'views/security.html';
        }

        Data.setIsNotLoggedIn(true);
        Data.setAuthenticated(false);

        $rootScope.isnotloggedin = true;
        $rootScope.authenticated = false;

        var nextUrl = next.templateUrl;
        Data.getSession(next.task).then(function(results) {
            if (results[0].id) {

                $rootScope.isnotloggedin = false;
                $rootScope.authenticated = true;

                Data.setIsNotLoggedIn(false);
                Data.setAuthenticated(true);

                if (next.task === 'getsessiondata') {
                    Data.setCurrentMember(results[0]);
                }

                if (nextUrl == 'views/register.html' || nextUrl == 'views/login.html') {
                    $location.path("/success");
                }
            } else {

                if (nextUrl == 'views/register.html' || 
                    nextUrl == 'views/login.html' || 
                    nextUrl == 'views/security.html') {
                } else {
                    $location.path("/login");
                }
            }
        });
    });
});
