angular.module('expenseTracker').controller 'authCtrl', ($scope, $rootScope, Auth, $state) ->
  config = headers: 'X-HTTP-Method-Override': 'POST'

  $scope.register = ->
    Auth.register($scope.user, config).then ((user) ->
      $rootScope.user = user
      alert 'Thanks for signing up, ' + user.email
      $state.go 'home'
    ), (response) ->
      alert response.data.error

  $scope.login = ->
    Auth.login($scope.user, config).then ((user) ->
      $rootScope.user = user
      alert 'You\'re all signed in, ' + user.email
      $state.go 'home'
    ), (response) ->
      alert response.data.error
