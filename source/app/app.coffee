'use strict'

# what is a directive 
# what is a factory
# what is a filter

# # some kind of harness to load all scenes (plugins) into
# angular.module('DogboardUiApp.plugins')

# DogboardUI.plugins["pluginName"] = ->
#   # plugin content here
#   the controller could be built dynamically
#   # the service should probably be included somehow, the service likelt includes some reusable polling logic
#   something service related
#   # possible routes should be exported to the driver, they should use search params
#   # at the end of all routes, the driver should switch to the next scene



angular.module('DogboardUiApp.loading', [])
angular.module('DogboardUiApp.projects', [])
angular.module('DogboardUiApp.products', [])
angular.module('DogboardUiApp.teamMembers', [])

# Initialize namespaced modules
angular.module 'DogboardUiApp', ['ngRoute', 'ngAnimate', 'DogboardUiApp.projects', 'DogboardUiApp.products', 'DogboardUiApp.loading', 'DogboardUiApp.teamMembers'], ($routeProvider, $locationProvider) ->
    $routeProvider

      # should we use a /scenes/:sceneName path which passes everything to a ScenesController
      # or should each plugin inject somethng into the routeProvider
      .when '/scenes/:sceneName',
        title: 'Current Projects',
        templateUrl: 'app/projects/current/currentProjects.html'
        controller: 'CurrentProjectsController'

      .when '/projects/current/:position',
        title: 'Current Projects',
        templateUrl: 'app/projects/current/currentProjects.html'
        controller: 'CurrentProjectsController'

      .when '/projects/planned/:position',
        title: 'Planned Projects',
        templateUrl: 'app/projects/planned/plannedProjects.html'
        controller: 'PlannedProjectsController'

      .when '/products/:position',
        title: 'Products',
        templateUrl: 'app/products/products.html'
        controller: 'ProductsController'

      .when '/team_members/:position',
        title: 'Team Members',
        templateUrl: 'app/team_members/teamMembers.html'
        controller: 'TeamMembersController'

      .when '/loading',
        title: 'Loading',
        templateUrl: 'app/loading/loading.html'
        controller: 'LoadingController'

      .otherwise
        redirectTo: '/loading'

.run ['$location', '$rootScope', '$route', '$routeParams', '$timeout', 'ProductsService',
  ($location, $rootScope, $route, $routeParams, $timeout, ProductsService) ->

    # each time the route changes, update the page title
    $rootScope.$on '$routeChangeSuccess', (event, current) ->
      route = current.$$route
      $rootScope.pageTitle = route.title if route?.title
      $rootScope.pageHeader = route.title if route?.title

    # TODO:
    # drive the dashboard from here instead of the individual controllers
    #####################################################################

]
