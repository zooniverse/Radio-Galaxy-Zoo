
# Import controllers
AppController = require './controllers/app'
ClassifierController = require './controllers/classifier'

# Import directives
ContoursDirective = require './directives/contours'

# Import templates
homeTemplate = require './partials/home'
classifierTemplate = require './partials/classifier'
profileTemplate = require './partials/profile'
scienceTemplate = require './partials/science'
teamTemplate = require './partials/team'

# Setup application and connect controllers
RadioGalaxyZoo = angular.module('radio-galaxy-zoo', [])
RadioGalaxyZoo.controller('AppController', AppController)
RadioGalaxyZoo.controller('ClassifierController', ClassifierController)

RadioGalaxyZoo.directive('contours', ContoursDirective)

# Configure routes
RadioGalaxyZoo.config ($routeProvider) ->
  
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
