@appServices = angular.module('app.services', ['app.constants', 'restangular'])

@appServices.config ['RestangularProvider', '__env', (RestangularProvider, __env) ->
  RestangularProvider.setBaseUrl("#{__env.apiUrl}/api/v1")
]

@appServices.factory 'PublicPosts', ['Restangular', require('./publicPostsSrv')]