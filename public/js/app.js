(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/app":[function(require,module,exports){
require('./constants');

require('./routes');

require('./controllers/index');

require('./services/index');

this.app = angular.module('app', ['app.constants', 'app.routes', 'app.controllers', 'app.services', 'ng-token-auth', 'restangular']);

this.app.config([
  '$authProvider', '__env', function($authProvider, __env) {
    return $authProvider.configure({
      apiUrl: __env.apiHost
    });
  }
]);


},{"./constants":"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/constants.coffee","./controllers/index":"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/controllers/index.coffee","./routes":"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/routes.coffee","./services/index":"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/services/index.coffee"}],"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/constants.coffee":[function(require,module,exports){
var __env;

__env = {};

if (window) {
  Object.assign(__env, window.__env);
}

this.appConstants = angular.module('app.constants', []);

this.appConstants.constant('__env', __env);


},{}],"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/controllers/index.coffee":[function(require,module,exports){
this.appControllers = angular.module('app.controllers', []);

this.appControllers.controller('PublicFeedCtrl', ['publicPosts', require('./publicFeedCtrl')]);


},{"./publicFeedCtrl":"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/controllers/publicFeedCtrl.coffee"}],"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/controllers/publicFeedCtrl.coffee":[function(require,module,exports){
module.exports = function(publicPosts) {
  this.helloWorld = "Hello World!";
  this.publicPosts = publicPosts;
  return this;
};


},{}],"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/routes.coffee":[function(require,module,exports){
this.appRoutes = angular.module('app.routes', ['ui.router']);

this.appRoutes.config([
  '$httpProvider', '$stateProvider', '$urlRouterProvider', function($httpProvider, $stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise("/");
    return $stateProvider.state('home', {
      url: '/',
      templateUrl: 'templates/public/home.html',
      controller: 'PublicFeedCtrl',
      controllerAs: 'publicFeed',
      resolve: {
        publicPosts: [
          'PublicPosts', function(PublicPosts) {
            return PublicPosts.getAll();
          }
        ]
      }
    });
  }
]);


},{}],"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/services/index.coffee":[function(require,module,exports){
this.appServices = angular.module('app.services', ['app.constants', 'restangular']);

this.appServices.config([
  'RestangularProvider', '__env', function(RestangularProvider, __env) {
    return RestangularProvider.setBaseUrl(__env.apiUrl + "/api/v1");
  }
]);

this.appServices.factory('PublicPosts', ['Restangular', require('./publicPostsSrv')]);


},{"./publicPostsSrv":"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/services/publicPostsSrv.coffee"}],"/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/services/publicPostsSrv.coffee":[function(require,module,exports){
module.exports = function(Restangular) {
  var service;
  return service = {
    getAll: function() {
      return Restangular.all('public/posts').getList();
    }
  };
};


},{}]},{},["/Users/tim/dev/personal/TAGitter-client/src/coffee/angular/app"]);

//# sourceMappingURL=app.js.map
