draanks.controller('CocktailLibraryController', ['$scope', '$http', '$location', 'Data', '$rootScope', '$routeParams', 'toaster', '$timeout', '$filter', 'ListServices',
    function($scope, $http, $location, Data, $rootScope, $routeParams, toaster, $timeout, $filter, ListServices) {

        $scope.prompts = txtCocktailLibrary;
        $scope.modalShown = false;

        var allCocktails;

        // var myHeaderCellTemplate = '<div class="ngHeaderSortColumn {{col.headerClass}}" ng-style="{cursor: col.cursor}" ng-class="{ ngSorted: !noSortVisible }">'+
        //                               '<div ng-click="col.sort($event)" ng-class="\'colt\' + col.index" class="ngHeaderText">{{col.displayName}}</div>'+
        //                               '<div class="ngSortButtonDown" ng-show="col.showSortButtonDown()"></div>'+
        //                               '<div class="ngSortButtonUp" ng-show="col.showSortButtonUp()"></div>'+
        //                               '<div class="ngSortPriority">{{col.sortPriority}}</div>'+
        //                            '</div>'+
        //                            '<div ng-show="col.resizable" class="ngHeaderGrip" ng-click="col.gripClick($event)" ng-mousedown="col.gripOnMouseDown($event)"></div>';

        $scope.gridOptions = {
            saveState: true,
            // enableFiltering: true,
            enableFiltering: false,            
            treeRowHeaderAlwaysVisible: true,
            enableColumnMenus: false,
            columnDefs: [
                { 
                    name: 'cocktail',
                    // displayName: txtCocktailLibrary.columnCocktail,
                    // enableFiltering: true,
                    // width: 335,
                    enableSorting: false,
                    filter: {
                        // condition: uiGridConstants.filter.ENDS_WITH,
                        placeholder: ' search for a cocktail by name'
                    },                    
                    // sort: { priority: 1, direction: 'asc' }, 
                    // headerCellTemplate: myHeaderCellTemplate, 
                    cellTemplate: '<div ng-click="grid.appScope.showRecipe(row)" class="ui-grid-cell-contents">{{row.entity.cocktail}}</div>'
                },

                { 
                    name: 'category', 
                    showHeader: false,
                    grouping: { groupPriority: 0 }, 
                    sort: { priority: 0, direction: 'asc' },  
                    enableFiltering: false,                   
                    width: 135,
                    displayName: txtCocktailLibrary.columnCategory,
                    enableSorting: false,
                    cellTemplate: '<div><div ng-if="!col.grouping || col.grouping.groupPriority === undefined || col.grouping.groupPriority === null || ( row.groupHeader && col.grouping.groupPriority === row.treeLevel )" class="ui-grid-cell-contents" title="TOOLTIP">{{COL_FIELD CUSTOM_FILTERS}}</div></div>',
                    headerCellTemplate: '<div class="ui-grid-cell-contents">' + txtCocktailLibrary.columnCategory + '</div>'
                },
                {
                    name: 'ingredient',
                    displayName: 'Ingredients',
                    visible: false,
                    filter: {
                        placeholder: ' search for a cocktail by ingredient'
                    },
                    cellTemplate: '<div ng-click="grid.appScope.showRecipe(row)" class="ui-grid-cell-contents">{{row.entity.ingredient}}</div>'
                }
            ],
            onRegisterApi: function( gridApi ) {
                $scope.gridApi = gridApi;

                $scope.gridApi.grid.registerDataChangeCallback(function() {
                    $scope.gridApi.treeBase.expandAllRows();
                });

                // $scope.gridApi.grid.registerRowsProcessor( $scope.singleFilter, 200 );

                // $scope.gridApi.core.on.filterChanged($scope, function() {
                //     $timeout(function() {
                //         $scope.gridApi.treeBase.expandAllRows();
                //     },100);
                // });
              
            }
        };

        Data.getSession('getCocktails').then(function(results) {
            allCocktails = results;
            $scope.gridOptions.data = results;
        });

        $scope.showRecipe  = function(row){
            $scope.selectedRecipeName = row.entity.cocktail;
            $scope.portions           = row.entity.portions;
            $scope.recipe             = row.entity.recipe;
            $scope.modalShown = true;
        };

        $scope.closeModal = function() {
            $scope.modalShown = false;
        };

        $scope.btnAction = function(){
            member = Data.getCurrentMember();
            if (member.member_type == 0){
                Data.logout(member);
                $location.path('/login');                
            } else {
                window.history.go(-1);
            }
        };

        $scope.searchDranks = function() {
            $scope.gridOptions.data = $filter('filter')(allCocktails, $scope.searchText, undefined);
            gridDimensions = ListServices.getGridHeight($scope.gridOptions, $scope.gridApi);
            $scope.gridHeight = gridDimensions.gridHeight;
            $scope.moveUp = gridDimensions.moveUp;
            // $scope.gridApi.grid.refresh();
        };

        $scope.singleFilter = function( renderableRows ){
            var matcher = new RegExp($scope.filterValue, 'i');
            renderableRows.forEach( function( row ) {
              var match = false;
              ['cocktail', 'ingredient'].forEach(function( field ){
                if ( row.entity[field].match(matcher) ){
                  match = true;
                }
              });
              if ( !match ){
                row.visible = false;
              }
            });
            $scope.filterValue = '';
            return renderableRows;
          };        

    }
]);