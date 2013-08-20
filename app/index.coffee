
# Import controllers
ClassifierCtrl  = require './controllers/classifier'

# Import directives
ImageOpacityDirective = require './directives/image_opacity'
ContinueBtnDirective  = require './directives/continue_button'
MarkingDirective      = require './directives/marking'
toggleContoursDirective  = require './directives/toggle_contours'

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
RadioGalaxyZoo.directive('marking', MarkingDirective)
RadioGalaxyZoo.directive('continue', ContinueBtnDirective)
RadioGalaxyZoo.directive('toggleContours', toggleContoursDirective)


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