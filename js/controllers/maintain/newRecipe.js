draanks.controller('NewRecipeController', ['$scope', '$http', '$location', 'Data', '$rootScope', '$routeParams', 'toaster',
    function($scope, $http, $location, Data, $rootScope, $routeParams, toaster) {

        $scope.usePlurals = 'f';
        $scope.allowNext = false;

        $scope.lists = {
            "A": []
        };

        $scope.serves = [];
        for (var i = 1; i <= 10; ++i) {
            $scope.serves.push({
              name: i,
              id: i
            });
        }

        $scope.removeItem = function(rowNumber){
            $scope.lists.A.splice(rowNumber, 1);
            if ($scope.lists.A.length == 0){
                $scope.allowNext = false;
            }            
        };

        $scope.dropCallback = function(item, type, listName) {
            return item; // return false to disallow drop
        };

        $scope.config = {
            sbMin: 0.001,
            sbMax: 200,
            sbPrecision: 4,
            sbMaxPrecision: 4
        };

        $scope.recipe = {};
        $scope.prompts = txtNewRecipe;
        $scope.member = Data.getCurrentMember();

        Data.getSession('getIngredients').then(function(results) {
            $scope.ingredients = results;
        });

        Data.getSession('getMeasures').then(function(results) {
            $scope.measures = results;
        });

        Data.getSession('getCategories').then(function(results) {
            $scope.categories = results;
        });


        $scope.sendRecipe = function() {
            var cocktail = {};
            cocktail.name         = $scope.recipeForm.recipeName.$modelValue;
            cocktail.serves       = $scope.recipeForm.serves.$modelValue;
            cocktail.ingredients  = $scope.lists.A;
            cocktail.category     = $scope.recipeForm.category.$modelValue;
            cocktail.tasteProfile = $scope.recipeForm.tasteProfile.$modelValue;

            Data.addToLibrary(cocktail).then(function(results) {
                $scope.recipients = results;
                $location.path('/success');
                toaster.pop('success', "", txtNewRecipe.newRecipe, 3000, 'trustedHtml');
            });
        };

        $scope.addIngredient = function(){
            var ingredient = {};
            var amountFraction = (new Fraction($scope.recipe.amount)).toString();
            var recipeIngredient = amountFraction +
                                  ' ' + 
                                  $scope.recipe.measure.name + 
                                  ' ' + 
                                  $scope.recipe.ingredient.name;

            ingredient.label        = recipeIngredient;
            ingredient.amount       = amountFraction;
            ingredient.measureID    = $scope.recipe.measure.id;
            ingredient.ingredientID = $scope.recipe.ingredient.id
            $scope.lists.A.push(ingredient);
            $scope.allowNext = true;

        };

        $scope.deleteRow = function(row){
            var index = $scope.data.indexOf(row.entity);
            $scope.data.splice(index,1);            
            if ($scope.data.length == 0){
                $scope.recipeForm.$setUntouched();
            }
        }

        $scope.data = [];

    }
]);