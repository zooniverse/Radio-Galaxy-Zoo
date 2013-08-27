
Subject = zooniverse.models.Subject

Classifier = ($scope, $routeParams, classifierModel) ->
  $scope.classifierModel = classifierModel
  
  $scope.showContours = true
  $scope.step = 1
  $scope.min = 0
  $scope.max = 1000
  $scope.sed = false
  
  $scope.getInfraredSource = -> return classifierModel.infraredSource
  $scope.getRadioSource = -> return classifierModel.radioSource
  
  # TODO: Move to service
  $scope.drawCatalogSources = ->
    classifierModel.drawCatalogSources()
  
  #
  # Workflow handlers
  #
  
  $scope.onNoFlux = ->
    $scope.showContours = true
    $scope.step = 3
    $scope.drawCatalogSources()
    Subject.next()
  
  $scope.onContinue = ->
    $scope.step = 2
  
  $scope.onNoCorrespondingFlux = ->
    $scope.showContours = true
    $scope.step = 3
    $scope.drawCatalogSources()
    Subject.next()
  
  $scope.onDone = ->
    $scope.showContours = true
    $scope.step = 3
    $scope.drawCatalogSources()
    Subject.next()
  
  $scope.onNext = ->
    
    # TODO: Post classification
    
    # Request next subject and return to step 1
    classifierModel.getSubject()
    
    # Remove annotation
    d3.select("div.sed svg").remove()
    d3.selectAll('path').remove()
    d3.selectAll('circle').remove()
    d3.selectAll('text').remove()
    
    # Update state to first step
    $scope.step = 1
    $scope.sed = false
    
  # TODO: Post Favorite
  $scope.onFavorite = ->
    alert "OMG THIS PICTURE IS SOOOOO COOL!"
  
  # TODO: Open in Talk
  $scope.onDiscuss = ->
    alert "Sorry, Talk doesn't work yet"


module.exports = Classifier