'use strict'

angular.module('DogboardUiApp.projects')
  .service 'PlannedProjectsService', ($http, $timeout) ->

    # placeholder for the planned projects hash
    plannedProjects = {}
    loaded = false

    # continuousely poll for the projects 
    (pollPlannedProjects = -> 

      # make the remote request
      $http.get('http://localhost:9393/upcomming_projects').success (res) ->
      
        # once the request finishes, update the local cache, wait for 10 seconds and then re-fetch
        plannedProjects = res
        loaded = true
        $timeout pollPlannedProjects, 5000

    )()

    # has the content been loaded yet
    isContentLoaded = ->
      loaded

    # how many projects are there
    projectCount = ->
      plannedProjects.length

    # return the project at the planned position
    projectAtPosition = (position) ->
      plannedProjects[position]

    # return the project at the current position
    isLastProject = (position) ->
      return plannedProjects.length == position + 1

    # Public API
    isContentLoaded: isContentLoaded
    projectCount: projectCount
    projectAtPosition: projectAtPosition
    isLastProject: isLastProject


