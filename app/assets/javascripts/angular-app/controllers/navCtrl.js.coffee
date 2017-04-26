angular.module('expenseTracker').controller 'navCtrl', ($scope, Auth, $rootScope) ->
  $scope.signedIn = Auth.isAuthenticated
  $scope.logout = Auth.logout
  Auth.currentUser().then (user) ->
    $rootScope.user = user
  $scope.$on 'devise:new-registration', (e, user) ->
    $rootScope.user = user
  $scope.$on 'devise:login', (e, user) ->
    $rootScope.user = user
  $scope.$on 'devise:logout', (e, user) ->
    alert 'You have been logged out.'
    $rootScope.user = undefined
