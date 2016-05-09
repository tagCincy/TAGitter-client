module.exports = (Restangular) ->
   service =
     getAll: () ->
       Restangular.all('public/posts').getList()
