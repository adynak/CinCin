function countDecimalPlaces(value){
  var decimalPos = String(value).indexOf('.');
  if(decimalPos === -1){
    return 0;
  }else{
    return String(value).length - decimalPos -1;
  }
}

draanks.directive('sbPrecision', function(){
  return {
    restrict: 'A',
    require: 'ngModel',
    link: function(scope, element, attributes, ngModel){
      var precision = attributes.sbPrecision;
      
      function setPrecision(){
        var value = ngModel.$modelValue;
        //since this is just a mask, don't hide decimal values that
        //go beyond our precision and don't format empty values
        if(value && !isNaN(value) && countDecimalPlaces(value) <= precision){
          var formatted = Number(value);
          ngModel.$viewValue = formatted;
          ngModel.$render();
        }
      }
      
      element.bind('blur', setPrecision);
      setTimeout(setPrecision, 0); //after initial page render
    }
    
  };
})

draanks.directive('sbMin', function(){
  return {
    restrict: 'A',
    require: 'ngModel',
    link: function(scope, element, attributes, ngModel){

      function minimum(value){
        if(!isNaN(value)){
          var validity = Number(value) >= attributes.sbMin;
          ngModel.$setValidity('min-value', validity);
          if (validity == false){
            ngModel.$customError = 'Not Enough';
          }
        }
        return value;
      }
      
      ngModel.$parsers.push(minimum); 
      ngModel.$formatters.push(minimum); 
    }
    
  };
})

draanks.directive('sbMax', function(){
  return {
    restrict: 'A',
    require: 'ngModel',
    link: function(scope, element, attributes, ngModel){

      
      function maximum(value){
        if(!isNaN(value)){
          var validity = Number(value) <= attributes.sbMax;
          ngModel.$setValidity('max-value', validity);
          if (validity == false){
            ngModel.$customError = 'Too many';
          }
        }
        
        return value;
      }
      
      ngModel.$parsers.push(maximum);
      ngModel.$formatters.push(maximum); 
    }
    
  };
})

draanks.directive('sbNumber', function(){
  return {
    restrict: 'A',
    require: 'ngModel',
    link: function(scope, element, attributes, ngModel){

      
      function validateNumber(value){
        if (typeof(value) == 'undefined'){
          return 0;
        }
        var ingredientAmount = value.name;
        var validity = !isNaN(value.name);
        ngModel.$setValidity('number', validity);
        if (validity == false){
          ngModel.$customError = 'Must be a number';
        } else {
          if (ingredientAmount > 1){
            scope.usePlurals = 't';
          } else {
            scope.usePlurals = 'f';            
          }
        }
        return value;
      }
      
      ngModel.$parsers.push(validateNumber);
      ngModel.$formatters.push(validateNumber); 
    }
    
  };
})

draanks.directive('modalDialog', function() {
// note that the attribute txtButtonDone is reduced to all lowercase  
  return {
    restrict: 'E',
    scope: {
      show: '=',
      btnDone: '@txtbuttondone'
    },
    replace: true, // Replace with the template below
    transclude: true, // we want to insert custom content inside the directive
    link: function(scope, element, attrs) {
      scope.dialogStyle = {};
      if (attrs.width)
        scope.dialogStyle.width = attrs.width;
      if (attrs.height)
        scope.dialogStyle.height = attrs.height;
      scope.hideModal = function() {
        scope.show = false;
      };
    },
    template: "<div class='ng-modal' ng-show='show'>" + 
                "<div class='ng-modal-overlay' ng-click='hideModal()'></div>" + 
                "<div class='ng-modal-dialog' ng-style='dialogStyle'>" + 
                  // "<div class='ng-modal-close' ng-click='hideModal()'>X</div>" + 
                  "<div class='ng-modal-dialog-content' ng-transclude></div>" + 
                  '<div class="text-center">' + 
                    '<button class="btn btn-md btn-primary" ' + 
                            'type="button" ng-click="hideModal()">{{btnDone}}' + 
                    "</button>" + 
                  "</div>" + 
                  "<br>" +                  
                "</div>" + 
              "</div>"
  };
});

draanks.directive('sbMaxPrecision', function(){
  return {
    restrict: 'A',
    require: 'ngModel',
    link: function(scope, element, attributes, ngModel){
      
      function maxPrecision(value){
        if(!isNaN(value)){
          var validity = countDecimalPlaces(value) <= attributes.sbMaxPrecision;
          ngModel.$setValidity('max-precision', validity);
          if (validity == false){
            ngModel.$customError = 'Too many decimal places';          
          }
        }
        
        return value;
      }
      
      ngModel.$parsers.push(maxPrecision);
      ngModel.$formatters.push(maxPrecision); 
    }
    
  };
});
