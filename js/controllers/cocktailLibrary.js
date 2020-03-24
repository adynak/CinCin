draanks.controller('CocktailLibraryController', ['$scope', '$http', '$location', 'Data', '$rootScope', '$routeParams', 'toaster', '$timeout', '$filter', 'ListServices',
    function($scope, $http, $location, Data, $rootScope, $routeParams, toaster, $timeout, $filter, ListServices) {

        $scope.prompts = txtCocktailLibrary;
        $scope.modalShown = false;

        var allCocktails;
        var expandText = txtCocktailLibrary.collapseAll;
        var expandIcon = 'ui-grid-icon-minus-squared';

        $scope.gridHeight = Data.getGridHeight().gridHeight;

        $scope.gridOptions = {
            saveState: true,
            // enableFiltering: true,
            enableFiltering: false,            
            treeRowHeaderAlwaysVisible: false,
            showTreeRowHeader: false,
            // enableColumnMenus: false,
            columnDefs: [
                { 
                    field: 'category', 
                    displayName: txtCocktailLibrary.columnCategory,
                    showHeader: true,
                    enableColumnMenu: true,
                    grouping: { groupPriority: 0 }, 
                    enableFiltering: false,                   
                    width: 135,
                    enableHiding: false, 
                    enableSorting: false,
                    groupingShowAggregationMenu: false,
                    groupingShowGroupingMenu: false,
                    cellTemplate: 'views/categoryColumn.html',
                    headerCellClass: 'category',
                    menuItems: [
                      {
                        title: expandText,
                        icon:  expandIcon,
                        action: function($event) {
                            if ($scope.gridApi.grid.treeBase.expandAll == true){
                                $scope.gridApi.treeBase.collapseAllRows();
                                $scope.gridOptions.columnDefs[0].menuItems[0].title = txtCocktailLibrary.expandAll;;
                                $scope.gridOptions.columnDefs[0].menuItems[0].icon  = "ui-grid-icon-plus-squared";
                            } else {
                                $scope.gridApi.treeBase.expandAllRows();
                                $scope.gridOptions.columnDefs[0].menuItems[0].title = txtCocktailLibrary.collapseAll;;
                                $scope.gridOptions.columnDefs[0].menuItems[0].icon  = "ui-grid-icon-minus-squared";
                            }
                        },
                        context: $scope
                      }
                    ]
                },
                { 
                    name: 'cocktail',
                    enableSorting: false,
                    headerCellTemplate: '<div class="ui-grid-cell-contents category">' + txtCocktailLibrary.columnCocktail + '</div>',
                    cellTemplate: '<div ng-click="grid.appScope.showRecipe(row)" class="ui-grid-cell-contents">{{row.entity.cocktail}}</div>'
                },                
                {
                    name: 'ingredient',
                    displayName: 'Ingredients',
                    visible: false,
                    cellTemplate: '<div ng-click="grid.appScope.showRecipe(row)" class="ui-grid-cell-contents btn-primary">{{row.entity.ingredient}}</div>'
                }
            ],
            onRegisterApi: function( gridApi ) {
                $scope.gridApi = gridApi;
                $scope.gridApi.grid.registerDataChangeCallback(function() {
                    $scope.gridApi.treeBase.expandAllRows();
                    expandText = "Collapse";
                    expandIcon = 'ui-grid-icon-minus-squared';
                });  
                $rootScope.$on('orientationchange', function () {
                    Data.setGridHeight(window.screen);
                    $scope.gridHeight = Data.getGridHeight().gridHeight;
                });
            }
        };

        Data.getSession('getCocktails').then(function(results) {
            allCocktails = results;
            $scope.gridOptions.data = results;
        });

        $scope.showRecipe  = function(row){
            if (typeof(row.entity.cocktail) == 'undefined'){
                return;
            } else {
                $scope.selectedRecipeName = row.entity.cocktail;
                $scope.portions           = row.entity.portions;
                $scope.recipe             = row.entity.recipe;
                $scope.modalShown = true;
            }
        };

        $scope.closeModal = function() {
            $scope.modalShown = false;
        };

        $scope.toggleRow = function(grid,row){
            if (row.treeNode.state == "collapsed"){
                grid.api.treeBase.expandRow(row);
            } else {
                grid.api.treeBase.collapseRow(row);
            }
        }

        $scope.btnAction = function(){
            member = Data.getCurrentMember();
            if (member.member_type == 0){
                Data.logout(member);
                $location.path('/login');                
            } else {
                window.history.go(-1);
            }
        };

        $scope.searchDranks = function(searchOption) {
            if (searchOption == "clear"){
                scope.searchText = "";
            }
            $scope.gridOptions.data = $filter('filter')(allCocktails, $scope.searchText, undefined);
            gridDimensions = ListServices.getGridHeight($scope.gridOptions, $scope.gridApi);
            $scope.gridHeight = gridDimensions.gridHeight;
            $scope.moveUp = gridDimensions.moveUp;
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