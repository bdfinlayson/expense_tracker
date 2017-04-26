@app = angular.module('expenseTracker', ['ui.router', 'Devise', 'templates'])

@app.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content') ])

@app.run(-> console.log 'angular app running' )

