draanks.controller('MaintainController', ['$scope', '$http', '$location', 'Data', '$rootScope', '$routeParams', 'toaster', 'ListServices',
    function($scope, $http, $location, Data, $rootScope, $routeParams, toaster, ListServices) {

        $scope.prompts = txtMaintainTables;
        var getWhat = '';
        var pageName = '';
        var placeholder = '';

        switch($location.$$path){
            case '/maintain/category':
                getWhat     = txtMaintainTables.maintainWhat[0].get;
                pageName    = txtMaintainTables.maintainWhat[0].pageName;
                placeholder = txtMaintainTables.maintainWhat[0].placeHolder;
                tableName   = txtMaintainTables.maintainWhat[0].tableName;
                break;
            case '/maintain/ingredient':
                getWhat     = txtMaintainTables.maintainWhat[1].get;
                pageName    = txtMaintainTables.maintainWhat[1].pageName;
                placeholder = txtMaintainTables.maintainWhat[1].placeHolder;
                tableName   = txtMaintainTables.maintainWhat[1].tableName;
                break;                
            case '/maintain/measure':
                getWhat     = txtMaintainTables.maintainWhat[2].get;
                pageName    = txtMaintainTables.maintainWhat[2].pageName;
                placeholder = txtMaintainTables.maintainWhat[2].placeHolder;
                tableName   = txtMaintainTables.maintainWhat[2].tableName;
                break;
            case '/maintain/garnish':
                getWhat     = txtMaintainTables.maintainWhat[3].get;
                pageName    = txtMaintainTables.maintainWhat[3].pageName;
                placeholder = txtMaintainTables.maintainWhat[3].placeHolder;
                tableName   = txtMaintainTables.maintainWhat[3].tableName;
                break;                
        }
        $scope.prompts.pageName    = pageName;
        $scope.prompts.placeholder = placeholder;

        Data.getSession(getWhat).then(function(results) {
            $scope.infoList = results;
        });

        $scope.removeItem = function(position){
            var sql = {}, butter ;

            sql = ListServices.removeItemSql($scope.infoList, tableName, position);
            ListServices.processUpdate($scope.infoList, sql,'removeItem').then(function(d){
                if (d.success){
                    $scope.infoList.splice(position, 1);
                    butter = txtMaintainTables.removed + ' ' + pageName + ' "' + sql.name + '"';
                    toaster.pop('success', "", butter , 3000, 'trustedHtml');
                } else {
                    butter  = txtMaintainTables.removedFailed + ' ' + pageName + ' "' + sql.name + '"';
                    butter += '<br>';
                    butter += txtMaintainTables.removedFailedInUse + ' ' + pageName + ' "' + sql.name + '"';
                    toaster.pop('error', "", butter , 3000, 'trustedHtml');
                }               
            });
        }


        $scope.addItem = function () {
            var newItem  = {
                name: $scope.addMe,
                id: ''
            }, results = {};
            var uniqueItem = true , found = 0;
            var insertAt ;

            found = $scope.infoList.filter(function(item) {
                return item.name.toLowerCase() === newItem.name.toLowerCase();
            })[0];

            if (found) {
                butter  = '"' + newItem.name + '" ' + txtMaintainTables.addDuplicate + ' "' + found.name + '"';
                butter += '<br>';
                butter += txtMaintainTables.addFailed + ' ' + pageName + ' "' + newItem.name + '"';
                toaster.pop('error', "", butter , 3000, 'trustedHtml');
            } else {
                ListServices.insertNewItem(newItem,$scope.infoList,tableName).then(function(d){
                    if (d.insertAt < 0) {
                        insertAt = $scope.infoList.length-1;
                    } else {
                        insertAt = d.insertAt;
                    }
                    $scope.infoList[insertAt].id = d.newID;
                    butter = $scope.prompts.placeholder + 
                             ' ' + ' "' + newItem.name + '" ' + txtMaintainTables.addPassed;
                    toaster.pop('success', "", butter , 3000, 'trustedHtml');
                });
            }

            $scope.addMe = '' ;

        }        

    }
]);