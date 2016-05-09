@appRoutes = angular.module('app.routes', ['ui.router'])

@appRoutes.config ['$httpProvider', '$stateProvider', '$urlRouterProvider',
  ($httpProvider, $stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise "/"

    $stateProvider
    .state 'home',
      url: '/'
      templateUrl: 'templates/public/home.html'
      controller: 'PublicFeedCtrl'
      controllerAs: 'publicFeed'
      resolve:
        publicPosts: ['PublicPosts', (PublicPosts) ->
          PublicPosts.getAll()
        ]
  ]
