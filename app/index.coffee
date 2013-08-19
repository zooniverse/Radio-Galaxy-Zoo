
# Import controllers
ClassifierCtrl  = require './controllers/classifier'

# Import directives
ImageOpacityDirective = require './directives/image_opacity'
ContoursDirective     = require './directives/contours'
ContinueBtnDirective  = require './directives/continue_button'
MarkingDirective      = require './directives/marking'

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

RadioGalaxyZoo.directive('imageOpacity', ImageOpacityDirective)
RadioGalaxyZoo.directive('contours', ContoursDirective)
RadioGalaxyZoo.directive('marking', MarkingDirective)
RadioGalaxyZoo.directive('continue', ContinueBtnDirective)


# Configure routes
RadioGalaxyZoo.config ($routeProvider) ->
  
  $routeProvider
    .when("/home",
      template: homeTemplate
    )
    .when("/classify",
      template: classifierTemplate
    )
    .when("/classify/:subject",
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
