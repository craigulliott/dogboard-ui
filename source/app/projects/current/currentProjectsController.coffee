'use strict'

angular.module('DogboardUiApp.projects')

  .controller 'CurrentProjectsController', ($scope, $timeout, $location, $routeParams, CurrentProjectsService, TeamMembersService) ->

    sceneLength = 4000
    position = parseInt($routeParams.position)
    nextPosition = position + 1

    # if the remote content is not ready, then go to the loading screen
    unless CurrentProjectsService.isContentLoaded()
      $location.path( "/loading" ).search("next", "/projects/current/" + position)
      return

    lastProject = CurrentProjectsService.isLastProject(position)

    goToNextScene = ->
      $location.path( "/projects/planned/1" )

    goToNextProject = ->
      $location.path( "/projects/current/" + nextPosition )

    # update the view
    $scope.projectCount = CurrentProjectsService.projectCount()
    project = CurrentProjectsService.projectAtPosition(position)
    $scope.project = project

    if project.assignee
      $scope.project.assignee = TeamMembersService.teamMemberWithID(project.assignee.id)

    # while there are projects to show, keep looping every second
    if lastProject
      $timeout goToNextScene, sceneLength
    else
      $timeout goToNextProject, sceneLength