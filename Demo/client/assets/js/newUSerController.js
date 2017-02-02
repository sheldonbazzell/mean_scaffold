app.controller('newUSerController',['$scope', '$location' 
'USersFactory', 
function($scope, $location, 
) {
 $scope.newUSer = function() { 
   USersFactory.create(function(data) {  
      $scope.USer = data;
       $location.url('/');
    })
 }

}])
