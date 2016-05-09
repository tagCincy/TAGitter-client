__env = {}
Object.assign(__env, window.__env) if window

@appConstants = angular.module 'app.constants', []
@appConstants.constant('__env', __env)