
Subject = zooniverse.models.Subject


Classifier = ($scope, model) ->
  console.log "ClassifierCtrl"
  
  $scope.model = model
  $scope.showContours = model.showContours
  $scope.step = model.step
  $scope.showSED = model.showSED
  $scope.example = model.example
  
  $scope.getInfraredSource = ->
    return model.infraredSource
  $scope.getRadioSource = ->
    return model.radioSource
  $scope.getStep = ->
    return model.step
  $scope.getShowContours = ->
    return model.showContours
  $scope.getNextInfraredSource = ->
    return model.nextInfraredSource
  $scope.getNextRadioSource = ->
    return model.nextRadioSource
  $scope.getExample = ->
    return model.example
  
  #
  # Recover last state
  #
  
  if model.subjectContours.length > 0
    
    # Start tutorial if exists
    if model.hasTutorial
      model.startTutorial()
    
    # Draw contours if they exist
    model.drawContours model.subjectContours[0]
    
    for contourid in model.selectedContours
      path = d3.select("path[contourid='#{contourid}']")
      path.attr("class", "svg-contour selected")
  
  #
  # Workflow handlers
  #
  
  # TODO: Set state on model for every user action.
  #       This needs to be done because the controller is stateless
  #       so it cannot recover without the model.
  
  $scope.onNoFlux = ->
    model.showContours = true
    model.step = 3
    
    # # NOTE: This is symatically weird.
    # model.drawCatalogSources()
  
  $scope.onContinue = ->
    model.step = 2
  
  $scope.onNoCorrespondingFlux = ->
    model.showContours = true
    model.step = 3
    # model.drawCatalogSources()
  
  $scope.onDone = ->
    model.showContours = true
    model.step = 3
    # model.drawCatalogSources()
  
  $scope.onNext = ->
    console.log "onNext"
    
    model.getClassification()
    
    # Request next subject and return to step 1
    model.getSubject()
    
    # Remove annotation
    d3.select("div.sed svg").remove()
    d3.selectAll('path').remove()
    d3.selectAll('circle').remove()
    d3.selectAll('text').remove()
    
    # Update state to first step
    model.step = 1
    model.showSED = false
    
  # TODO: Post Favorite
  $scope.onFavorite = ->
    alert "Sorry, you cannot save favorites yet."
  
  # TODO: Open in Talk
  $scope.onDiscuss = ->
    alert "Sorry, Talk doesn't work yet"


module.exports = Classifier