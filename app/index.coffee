
# Import controllers
ClassifierCtrl  = require './controllers/classifier'

# Import directives
ImageOpacityDirective = require './directives/image_opacity'
ContinueBtnDirective  = require './directives/continue_button'
MarkingDirective      = require './directives/marking'
toggleContoursDirective  = require './directives/toggle_contours'
scienceDirective      = require './directives/science'

# Import services
ClassifierModel = require './services/ClassifierModel'

# Import templates
homeTemplate        = require './partials/home'
classifierTemplate  = require './partials/classifier'
profileTemplate     = require './partials/profile'
scienceTemplate     = require './partials/science'
teamTemplate        = require './partials/team'

# Set up application module
RadioGalaxyZoo = angular.module('radio-galaxy-zoo', [])

# Connect controllers and services and directives

RadioGalaxyZoo.controller('ClassifierCtrl', ["$scope", "$routeParams", "classifierModel", ClassifierCtrl])
RadioGalaxyZoo.service('classifierModel', ["$rootScope", "$http", ClassifierModel])

RadioGalaxyZoo.directive('science', scienceDirective)
RadioGalaxyZoo.directive('imageOpacity', ImageOpacityDirective)
RadioGalaxyZoo.directive('marking', MarkingDirective)
RadioGalaxyZoo.directive('continue', ContinueBtnDirective)
RadioGalaxyZoo.directive('toggleContours', toggleContoursDirective)

# Configure Zooniverse API
if window.location.origin is "http://0.0.0.0:9294"
  api = new zooniverse.Api
    project: 'radio'
    host: "https://dev.zooniverse.org"
    path: '/proxy'
else
  # new Analytics
  #   account: "UA-XXXXXXX-XX"
  
  api = new zooniverse.Api
    project: 'radio'
    host: "https://api.zooniverse.org"
    path: '/proxy'

topBar = new zooniverse.controllers.TopBar
zooniverse.models.User.fetch()
topBar.el.appendTo 'body'

# Configure routes
RadioGalaxyZoo.config(['$routeProvider', ($routeProvider) ->
  
  $routeProvider
    .when("/home",
      template: homeTemplate
    )
    .when("/classify",
      template: classifierTemplate
    )
    .when("/science",
      template: scienceTemplate
    )
    .when("/team",
      template: teamTemplate
    )
    .when("/profile",
      template: profileTemplate
    )
    .otherwise redirectTo: "/home"
])
