'use strict'

angular.module('DogboardUiApp.teamMembers')
  .service 'TeamMembersService', ($http, $timeout) ->

    # placeholder for the planned teamMembers hash
    teamMembers = {}
    loaded = false

    # continuousely poll for the teamMembers 
    (pollTeamMembers = -> 

      # make the remote request
      $http.get('http://localhost:9393/team_members').success (res) ->
      
        # once the request finishes, update the local cache, wait for 30 minutes and then re-fetch
        teamMembers = res
        loaded = true
        $timeout pollTeamMembers, 1000*60*30

    )()

    # has the content been loaded yet
    isContentLoaded = ->
      loaded

    # how many team members are there
    teamMemberCount = ->
      teamMembers.length

    # return the team member at the planned position
    teamMemberAtPosition = (position) ->
      teamMembers[position]

    # return the team member by id
    teamMemberWithID = (id) ->
      id = parseInt(id)
      for el in teamMembers
        return el if parseInt(el.id) == id
      throw "Could not find team member with id " + id

    # return the team member at the current position
    isLastTeamMember = (position) ->
      return teamMembers.length == position + 1

    # Public API
    isContentLoaded: isContentLoaded
    teamMemberCount: teamMemberCount
    teamMemberAtPosition: teamMemberAtPosition
    isLastTeamMember: isLastTeamMember
    teamMemberWithID: teamMemberWithID
