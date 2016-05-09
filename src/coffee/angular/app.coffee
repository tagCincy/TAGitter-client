require('./constants')
require('./routes')
require('./controllers/index')
require('./services/index')

@app = angular.module('app', ['app.constants', 'app.routes','app.controllers', 'app.services', 'ng-token-auth', 'restangular'])
@app.config ['$authProvider', '__env', ($authProvider, __env) ->
  $authProvider.configure
    apiUrl: __env.apiHost
]