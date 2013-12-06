'use strict'

angular.module('DogboardUiApp.loading')

  .controller 'LoadingController', ($timeout, $location, $routeParams, CurrentProjectsService, PlannedProjectsService, ProductsService, TeamMembersService) ->

    next = if $routeParams.next then $routeParams.next else "/team_members/1"

    goToFirstScene = ->
      $location.path( next ).search('next', null)

    # if the remote content is ready, then display the content immediately, else wait for it to become ready
    (tick = ->
      if CurrentProjectsService.isContentLoaded() and PlannedProjectsService.isContentLoaded() and ProductsService.isContentLoaded() and TeamMembersService.isContentLoaded()
        goToFirstScene()
      else 
        $timeout tick, 50
    )()
