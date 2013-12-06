'use strict'

angular.module('DogboardUiApp.projects')
  .service 'CurrentProjectsService', ($http, $timeout) ->

    # placeholder for the current projects hash
    currentProjects = {}
    loaded = false

    # continuousely poll for the projects 
    (pollCurrentProjects = -> 

      # make the remote request
      $http.get('http://localhost:9393/current_projects').success (res) ->
      
        # once the request finishes, update the local cache, wait for 10 seconds and then re-fetch
        currentProjects = res
        loaded = true
        $timeout pollCurrentProjects, 5000

    )()

    # has the content been loaded yet
    isContentLoaded = ->
      loaded

    # how many projects are there
    projectCount = ->
      currentProjects.length

    # return the project at the planned position
    projectAtPosition = (position) ->
      currentProjects[position]

    # return the project at the current position
    isLastProject = (position) ->
      return currentProjects.length == position + 1

    # Public API
    isContentLoaded: isContentLoaded
    projectCount: projectCount
    projectAtPosition: projectAtPosition
    isLastProject: isLastProject

