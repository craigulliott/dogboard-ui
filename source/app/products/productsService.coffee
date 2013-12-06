'use strict'

angular.module('DogboardUiApp.products')
  .service 'ProductsService', ($http, $timeout) ->

    # placeholder for the planned products hash
    products = {}
    loaded = false

    # continuousely poll for the products 
    (pollProducts = -> 

      # make the remote request
      $http.get('http://localhost:9393/products').success (res) ->
      
        # once the request finishes, update the local cache, wait for 10 seconds and then re-fetch
        products = res
        loaded = true
        $timeout pollProducts, 5000

    )()

    # has the content been loaded yet
    isContentLoaded = ->
      loaded

    # how many products are there
    productCount = ->
      products.length

    # return the product at the planned position
    productAtPosition = (position) ->
      products[position]

    # return the product at the current position
    isLastProduct = (position) ->
      return products.length == position + 1

    # Public API
    isContentLoaded: isContentLoaded
    productCount: productCount
    productAtPosition: productAtPosition
    isLastProduct: isLastProduct


