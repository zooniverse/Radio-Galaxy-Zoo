
# Import controllers
ClassifierCtrl  = require './controllers/classifier'
ScienceCtrl  = require './controllers/science'
TeamCtrl  = require './controllers/team'

# Import directives
ImageOpacityDirective   = require './directives/image_opacity'
MarkingDirective        = require './directives/marking'
ToggleContoursDirective = require './directives/toggle_contours'
ExampleDirective        = require './directives/example'
SubExampleDirective     = require './directives/sub_example'

# Import services
ClassifierModel = require './services/ClassifierModel'

# Import templates
homeTemplate        = require './partials/home'
classifierTemplate  = require './partials/classifier'
profileTemplate     = require './partials/profile'
scienceTemplate     = require './partials/science'
teamTemplate        = require './partials/team'

# Set up application module
RadioGalaxyZoo = angular.module("radio-galaxy-zoo", ['ngRoute'])

RadioGalaxyZoo.constant("imageDimension", 424)
RadioGalaxyZoo.constant("contourThreshold", 8)
RadioGalaxyZoo.constant("fitsImageDimension", 301)
RadioGalaxyZoo.constant("translateRegEx", /translate\((-?\d+), (-?\d+)\)/)
RadioGalaxyZoo.run(["classifierModel", (classifierModel) ->])

# Controllers
RadioGalaxyZoo.controller('ClassifierCtrl', ["$scope", "classifierModel", ClassifierCtrl])
RadioGalaxyZoo.controller('ScienceCtrl', ["$scope", "$routeParams", ScienceCtrl])
RadioGalaxyZoo.controller('TeamCtrl', ["$scope", TeamCtrl])

# Directives
RadioGalaxyZoo.directive('imageOpacity', ImageOpacityDirective)
RadioGalaxyZoo.directive('marking', MarkingDirective)
RadioGalaxyZoo.directive('toggleContours', ToggleContoursDirective)
RadioGalaxyZoo.directive('example', ExampleDirective)
RadioGalaxyZoo.directive('subExample', SubExampleDirective)

# Services
RadioGalaxyZoo.service('classifierModel', ["$rootScope", "$q", "translateRegEx", "imageDimension", "fitsImageDimension", "contourThreshold", ClassifierModel])

# Configure Zooniverse API
host = if window.location.port is "9296" then "http://0.0.0.0:3000" else "https://dev.zooniverse.org"
if window.location.hostname in ["0.0.0.0", "radio.galaxyzoo.org"]
  api = new zooniverse.Api
    project: 'radio'
    host: host
    path: '/proxy'
else
  new Analytics
    account: "UA-1224199-49"
  
  api = new zooniverse.Api
    project: 'radio'
    host: "https://api.zooniverse.org"
    path: '/proxy'

topBar = new zooniverse.controllers.TopBar
zooniverse.models.User.fetch()
topBar.el.appendTo 'body'

footer = new zooniverse.controllers.Footer
footer.el.appendTo '#footer'

# Check for necessary APIs
checkDataView = window.DataView?
checkBlob = window.Blob?
checkWorker = window.Worker?
checkURL = window.URL or window.webkitURL
checkTypedArray = window.Uint8Array?

check = checkDataView and checkBlob and checkWorker and checkURL and checkTypedArray
unless check
  alert "Sorry, but your browser is not supported."

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
    .when("/science/:category",
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
