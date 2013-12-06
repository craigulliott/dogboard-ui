'use strict'

angular.module('DogboardUiApp.projects')

  .controller 'PlannedProjectsController', ($scope, $timeout, $location, $routeParams, PlannedProjectsService, TeamMembersService) ->

    sceneLength = 4000
    position = parseInt($routeParams.position)
    nextPosition = position + 1

    # if the remote content is not ready, then go to the loading screen 
    unless PlannedProjectsService.isContentLoaded()
      $location.path( "/loading" ).search("next", "/projects/planned/" + position)
      return

    lastProject = PlannedProjectsService.isLastProject(position)

    goToNextScene = ->
      $location.path( "/products/1" )

    goToNextProject = ->
      $location.path( "/projects/planned/" + nextPosition )

    # update the view
    $scope.projectCount = PlannedProjectsService.projectCount()
    $scope.project = PlannedProjectsService.projectAtPosition(position)
    $scope.project.position = position

    # while there are projects to show, keep looping every second
    if lastProject
      $timeout goToNextScene, sceneLength
    else
      $timeout goToNextProject, sceneLength