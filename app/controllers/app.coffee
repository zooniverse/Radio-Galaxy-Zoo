
App = ($scope, $rootScope, $http) ->
  
  # Set the slug for menu active class
  $scope.$on "routeLoaded", (event, args) ->
    console.log args
    $scope.slug = args.slug


module.exports = App