angular.module('expenseTracker').config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state('home',
    url: '/home'
    templateUrl: 'angular-app/templates/home/home.html'
    controller: 'HomeCtrl').state('login',
    url: '/login'
    templateUrl: 'angular-app/templates/auth/login.html'
    controller: 'authCtrl'
    onEnter: (Auth, $state) ->
      Auth.currentUser().then ->
        $state.go 'home'
  ).state 'register',
    url: '/register'
    templateUrl: 'angular-app/templates/auth/register.html'
    controller: 'authCtrl'
    onEnter: (Auth, $state) ->
      Auth.currentUser().then ->
        $state.go 'home'
  $urlRouterProvider.otherwise '/home'
