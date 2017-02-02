app.controller('indexController',['$scope', 
'USersFactory', 
function($scope, 
USersFactory 
) {
 $scope.USers = [];
 $scope.getUSers = function() { 
   USersFactory.index(function(data) {  
      $scope.USers = data;
    })
 }

}])
