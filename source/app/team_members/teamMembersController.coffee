'use strict'

angular.module('DogboardUiApp.teamMembers')

  .controller 'TeamMembersController', ($scope, $timeout, $location, $routeParams, TeamMembersService) ->

    sceneLength = 4000
    position = parseInt($routeParams.position)
    nextPosition = position + 1

    # if the remote content is not ready, then go to the loading screen 
    unless TeamMembersService.isContentLoaded()
      $location.path( "/loading" ).search("next", "/team_members/" + position)
      return

    lastTeamMember = TeamMembersService.isLastTeamMember(position)

    goToNextScene = ->
      $location.path( "/projects/current/1" )

    goToNextTeamMember = ->
      $location.path( "/team_members/" + nextPosition )

    # update the view
    $scope.teamMembersCount = TeamMembersService.teamMemberCount()
    $scope.teamMember = TeamMembersService.teamMemberAtPosition(position)
    $scope.teamMember.position = position

    # while there are team_members to show, keep looping every second
    if lastTeamMember
      $timeout goToNextScene, sceneLength
    else
      $timeout goToNextTeamMember, sceneLength