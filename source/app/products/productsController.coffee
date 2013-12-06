'use strict'

angular.module('DogboardUiApp.products')

  .controller 'ProductsController', ($scope, $timeout, $location, $routeParams, ProductsService, TeamMembersService) ->

    sceneLength = 4000
    position = parseInt($routeParams.position)
    nextPosition = position + 1

    # if the remote content is not ready, then go to the loading screen 
    unless ProductsService.isContentLoaded()
      $location.path( "/loading" ).search("next", "/products/" + position)
      return

    # update the view
    $scope.productCount = ProductsService.productCount()
    $scope.product = ProductsService.productAtPosition(position)

    lastProduct = ProductsService.isLastProduct(position)

    goToNextScene = ->
      $location.path( "/projects/current/1" )

    goToNextProduct = ->
      $location.path( "/products/" + nextPosition )

    # while there are products to show, keep looping every second
    if lastProduct
      $timeout goToNextScene, sceneLength
    else
      $timeout goToNextProduct, sceneLength