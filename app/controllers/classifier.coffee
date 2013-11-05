
Subject = zooniverse.models.Subject


Classifier = ($scope, model) ->
  
  $scope.model = model
  $scope.showContours = model.showContours
  $scope.step = model.step
  $scope.showSED = model.showSED
  $scope.example = model.example
  $scope.subExample = model.subExample
  
  $scope.getInfraredSource = ->
    return model.infraredSource
  $scope.getRadioSource = ->
    return model.radioSource
  $scope.getStep = ->
    console.log(model.step)
    return model.step
  $scope.getShowContours = ->
    return model.showContours
  $scope.getNextInfraredSource = ->
    return model.nextInfraredSource
  $scope.getNextRadioSource = ->
    return model.nextRadioSource
  $scope.getExample = ->
    model.example = false if model.example is "false"
    return model.example
  $scope.getSubExample = ->
    return model.subExample
  $scope.getIsDisabled = ->
    return model.isDisabled
  $scope.getAnnotationCount = ->
    return if model.annotations.length > 0 then true else false
  
  #
  # Recover last state
  #
  
  if model.subjectContours.length > 0
    
    # Start tutorial if exists
    model.startFirstTutorial() if model.hasTutorial
    
    # Draw contours if they exist
    model.drawContours(model.subjectContours[0])
    
    for contourid in model.selectedContours
      path = d3.select("path[contourid='#{contourid}']")
      path.attr("class", "svg-contour selected")
  
  #
  # Workflow handlers
  #
  
  # TODO: Set state on model for every user action.
  #       This needs to be done because the controller is stateless
  #       so it cannot recover without the model.
  
  $scope.onCancel = ->
    model.resetMarking()
    model.step = 0
  
  $scope.onNoCorrespondingFlux = ->
    model.getMatch()
    model.showContours = true
    model.step = 3
  
  $scope.onNextRadio = ->
    model.getMatch()
    model.step = 0
  
  $scope.onDone = ->
    console.log('here')
    model.getMatch()
    model.showContours = true
    model.ready = false
    model.step = 3
  
  $scope.onNext = ->
    model.getClassification()
    
    # Request next subject and return to step 1
    model.getSubject()
    
    # Remove annotation
    d3.select("g.contours").remove()
    d3.selectAll("g.infrared g").remove()
    
    # Update state to first step
    model.step = 0
    model.showSED = false
    
  # TODO: Post Favorite
  $scope.onFavorite = (e) ->
    angular.element(e.target).toggleClass("active")
    model.toggleFavorite()
  
  # TODO: Open in Talk
  $scope.onDiscuss = ->
    alert "Sorry, Talk doesn't work yet"


module.exports = Classifier