draanks.factory("Data", ['$http', '$q', '$rootScope',
    function($http, $q, $rootScope) {

        var factoryVariables = {
            activeMember : null,
            securityInfo : {
                schema: null,
                dbPass: null,
                pgPort: null,
                stop: true
            }
        };

        var setIsNotLoggedIn = function(flag){
            factoryVariables.isNotLoggedIn = flag;
        }

        var getIsNotLoggedIn = function(){
            return factoryVariables.isNotLoggedIn;
        }

        var setAuthenticated = function(flag){
            factoryVariables.authenticated = flag;
        }

        var getAuthenticated = function(){
            return factoryVariables.authenticated;
        }

        var setCurrentMember = function(currentMember){
            factoryVariables.currentMember = currentMember;
        }

        var getCurrentMember = function(){
            return factoryVariables.currentMember;
        }

        var setActiveMember = function(activeMember){
            factoryVariables.activeMember = activeMember;
        }

        var getActiveMember = function(){
            return factoryVariables.activeMember;
        }

        var setSecurityInfo = function(securityInfo){
            localStorage.setItem('goofyLuvin', securityInfo.schema);
            localStorage.setItem('raininspain', securityInfo.dbPass);
            localStorage.setItem('misoandgrace', securityInfo.pgPort);            
            factoryVariables.securityInfo = securityInfo;
        }

        var getSecurityInfo = function(){
            if (factoryVariables.securityInfo.schema == null || factoryVariables.securityInfo.dbPass == null || factoryVariables.securityInfo.pgPort == null){
                factoryVariables.securityInfo.schema = localStorage.getItem('goofyLuvin');
                factoryVariables.securityInfo.dbPass = localStorage.getItem('raininspain');
                factoryVariables.securityInfo.pgPort = localStorage.getItem('misoandgrace');

                factoryVariables.securityInfo.schema = "catsndogs";
                factoryVariables.securityInfo.dbPass = "teainchina";
                factoryVariables.securityInfo.pgPort = "raininspain";
                

                if (factoryVariables.securityInfo.schema !== null && factoryVariables.securityInfo.dbPass !== null && factoryVariables.securityInfo.pgPort !== null){
                    factoryVariables.securityInfo.stop = false;
                }
            }
            return factoryVariables.securityInfo;
        }        

        var validateCredentials = function(member){
            var qObject = $q.defer();
            var params = {
                email: member.email,
                password: member.password,
                task: 'validate',
                securityInfo: getSecurityInfo()
            };
            $http({
                method: 'POST',
                url: 'resources/dataServices/dataService.php',
                data: params,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
            }).then(function(success) {
                qObject.resolve(success.data);
            }, function(err) {
                console.log(err);
            });
            return qObject.promise;            
        }

        var registerMember = function(member) {
            // https://script.google.com/macros/d/MNYmhNDROwSuCBulBjpCOBQxbFS9WIK2d/edit?uiv=2&mid=ACjPJvEKyT7zYT3fN-Bh1kBFyqiw_j-NG0SCSo6rc8dz7_7-9NTrsj5jSdurrMX2vu4lYc7bcXFNQFhfPeq_OqzPSlpd9Gs2g6YQLT_tIItlrJTTIi-nhs6yiSsIL-QsJeoPX6K2BBxTuGc
            var qObject = $q.defer();
            delete member.confirmpassword;
            member.onlineid = member.email.substring(0, member.email.lastIndexOf("@"));
            member.webApp = txtNavigation.brandName;
            member.replyTo = txtNavigation.replyTo;
            member.appDomain = txtNavigation.appDomain;
            var params = "&" + $.param(member);
            var webApp = 'https://script.google.com/macros/s/AKfycbwL0BWFFP7Pz-qsjqpuLUCEtjlN2qSvxehkmLXzued3xhron0lS/exec';
            $http({
                method: 'POST',
                url: webApp,
                data: params,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
            }).then(function(success) {
                qObject.resolve(success.data);
            }, function(err) {
                console.log(err);
            });
            return qObject.promise;            
        }

        var updateMemberInfo = function(member){
            var qObject = $q.defer();
            var params = {
                userInfo: member,
                task: 'updateuser',
                securityInfo: getSecurityInfo()                
            };
            $http({
                method: 'POST',
                url: 'resources/dataServices/dataService.php',
                data: params,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
            }).then(function(success) {
                qObject.resolve(success.data);

            }, function(err) {
                console.log(err);
            });
            return qObject.promise;
        }

        var addToLibrary = function(cocktail){
            var qObject = $q.defer();
            var params = {
                cocktail: cocktail,
                task: 'addToLibrary',
                securityInfo: getSecurityInfo()                
            };

            $http({
                method: 'POST',
                url: 'resources/dataServices/dataService.php',
                data: params,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
            }).then(function(success) {
                qObject.resolve(success.data);
            }, function(err) {
                console.log(err);
            });
            return qObject.promise;            
        }

        var getCocktails = function(){
            var qObject = $q.defer();
            var params = {
                task: 'getCocktails',
                securityInfo: getSecurityInfo()                
            };

            $http({
                method: 'POST',
                url: 'resources/dataServices/dataService.php',
                data: params,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
            }).then(function(success) {
                qObject.resolve(success.data);
            }, function(err) {
                console.log(err);
            });
            return qObject.promise;            
        }

        var logout = function(member){
            var qObject = $q.defer();
            var params = {
                task: 'logout',
                securityInfo: getSecurityInfo()                
            };
            $http({
                method: 'POST',
                url: 'resources/dataServices/dataService.php',
                data: params,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
            }).then(function(success) {
                qObject.resolve(success.data);
            }, function(err) {
                console.log(err);
            });
            return qObject.promise;
        }

        var trackDraanks = function(row){
            var qObject = $q.defer();
            var params = {
                task : 'trackDraanks',
                cocktail: row.entity.cocktail
            };
            $http({
                method: 'POST',
                url: 'resources/dataServices/dataService.php',
                data: params,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
            }).then(function(success) {
                qObject.resolve(success.data);
            }, function(err) {
                console.log(err);
            });
            return qObject.promise;
        }

        var getSession = function(task){
            var qObject = $q.defer();
            var params = {
                task: task,
                securityInfo: getSecurityInfo()                
            };
            $http({
                method: 'POST',
                url: 'resources/dataServices/dataService.php',
                data: params,
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
            }).then(function(success) {
                qObject.resolve(success.data);
            }, function(err) {
                console.log(err);
            });
            return qObject.promise;
        }

        var setGridHeight = function(screen){

            var orientation,height;
            orientation = getOrientation(screen);
            var deviceType = getDeviceType().toLowerCase();
            switch (deviceType+orientation) {
                case "iphoneportrait":
                    height = "75vh";
                    searchHeight = "85vh";
                    reconcileHeight = "80vh";
                    break;
                case "iphonelandscape":
                    height = "60vh";
                    searchHeight = "75vh";
                    reconcileHeight = "50vh";
                    break;                    
                case "ipadportrait":
                    height = "89vh";
                    searchHeight = "92vh";
                    reconcileHeight = "88vh";
                    break;
                case "ipadlandscape":
                    height = "84vh";
                    searchHeight = "88vh";
                    reconcileHeight = "88vh";
                    break;
                default:
                    var ratio = 0.098032806;
                    var vh = window.innerHeight/window.outerHeight*window.screen.availHeight*ratio;
                    var height = 80 + "vh";
                    searchHeight = vh-3 + "vh";
                    reconcileHeight = "88vh";
                    break;
            }
            // var ratio = window.devicePixelRatio || 1;
            // var w = screen.width * ratio;
            // var height = screen.height * ratio;
            factoryVariables.gridHeight = {
                gridHeight: height,
                searchGridHeight: searchHeight,
                reconcileHeight: reconcileHeight
            }
        }

        var getGridHeight = function(){
            return factoryVariables.gridHeight;
        }

        var setDeviceType = function(userAgent){
            var deviceType = "desktop";
            userAgent = userAgent.toLowerCase();

            if (userAgent.indexOf("iphone") != -1){
                deviceType = "iPhone";
            }
            if (userAgent.indexOf("ipod") != -1){
                deviceType = "iPod";
            }
            if (userAgent.indexOf("ipad") != -1){
                deviceType = "iPad";
            }

            if (deviceType == "desktop"){
                var pixels = window.screen.width * window.screen.height;
                if (pixels == 786432){
                    deviceType = "iPad";
                }
            }

            factoryVariables.deviceType = deviceType;
        }

        var getDeviceType = function(){
            return factoryVariables.deviceType;
        }

        var getOrientation = function(screen){
            if (screen == ""){
                if (window.matchMedia("(orientation: portrait)").matches) {
                    return "portrait";
                }

                if (window.matchMedia("(orientation: landscape)").matches) {
                    return "landscape";
                }
            } else {
                if (screen.orientation.type.includes("portrait")) {
                    return "portrait";
                }

                if (screen.orientation.type.includes("landscape")) {
                    return "landscape";
                }
            }
        }

        return {
            validateCredentials: validateCredentials,
            registerMember: registerMember,
            updateMemberInfo: updateMemberInfo,
            logout: logout,
            getSession: getSession,
            setCurrentMember: setCurrentMember,
            getCurrentMember: getCurrentMember,
            setIsNotLoggedIn: setIsNotLoggedIn,
            getIsNotLoggedIn: getIsNotLoggedIn,
            setAuthenticated: setAuthenticated,
            getAuthenticated: getAuthenticated,
            getActiveMember: getActiveMember,
            setActiveMember: setActiveMember,
            addToLibrary: addToLibrary,
            getCocktails: getCocktails,
            setSecurityInfo: setSecurityInfo,
            getSecurityInfo: getSecurityInfo,
            setGridHeight: setGridHeight,
            getGridHeight: getGridHeight,
            setDeviceType: setDeviceType,
            getDeviceType: getDeviceType,
            getOrientation: getOrientation,
            trackDraanks: trackDraanks
        };
    }
]);