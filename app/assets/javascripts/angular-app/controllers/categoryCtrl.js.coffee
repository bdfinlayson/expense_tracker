angular.module('expenseTracker').controller('categoryCtrl', ['$scope', '$rootScope', '$http', ($scope, $rootScope, $http) ->
  $scope.categories = []
  $scope.newCategory = {}
  $scope.submitForm = ->
    request = $http.post 'http://localhost:3000/categories', category: $scope.newCategory
    request.then (result) ->
      $scope.categories.push result.data
])
