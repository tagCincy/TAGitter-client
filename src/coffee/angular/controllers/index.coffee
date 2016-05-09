@appControllers = angular.module('app.controllers', [])

@appControllers.controller 'PublicFeedCtrl', ['publicPosts', require('./publicFeedCtrl')]
