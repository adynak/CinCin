draanks.controller('NewRecipeController', ['$scope', '$http', '$location', 'Data', '$rootScope', '$routeParams', 'toaster',
    function($scope, $http, $location, Data, $rootScope, $routeParams, toaster) {

        $scope.usePlurals = 't';
        $scope.allowNext = false;

        $scope.lists = {
            "Ingredients": []
        };

        $scope.serves = [];
        for (var i = 1; i <= 10; ++i) {
            $scope.serves.push({
              name: i,
              id: i
            });
        }

        $scope.amounts = [];
        for (var i = 0; i <= 825; i+=25) {
            $scope.amounts.push({
              name: i/100,
              id: i/100
            });
        }        

        $scope.removeItem = function(rowNumber,listName){
            switch (listName) {
                case "Ingredients":
                    $scope.lists.Ingredients.splice(rowNumber, 1);
                    if ($scope.lists.Ingredients.length == 0){
                        $scope.allowNext = false;
                    }            
                    break;
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
            cocktail.ingredients  = $scope.lists.Ingredients;
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
            var amountFraction = (new Fraction($scope.recipe.amount.name)).toString();
            var recipeIngredient = amountFraction +
                                  ' ' + 
                                  $scope.recipe.measure.name + 
                                  ' ' + 
                                  $scope.recipe.ingredient.name;

            ingredient.label        = recipeIngredient;
            ingredient.amount       = amountFraction;
            ingredient.measureID    = $scope.recipe.measure.id;
            ingredient.ingredientID = $scope.recipe.ingredient.id;
            ingredient.garnishFlag  = 19;
            $scope.lists.Ingredients.push(ingredient);
            $scope.allowNext = true;
            $scope.recipe.amount = '';
            $scope.recipe.measure = '';
            $scope.recipe.ingredient = '';

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