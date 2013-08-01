

Classifier = ($scope, $routeParams, classifierModel) ->
  console.log 'Classifier'
  
  $scope.classifierModel = classifierModel
  $scope.opacity = 0
  $scope.showContours = true
  $scope.step = 1
  $scope.level = 3
    
  $scope.min = 0
  $scope.max = 1000
  
  if $routeParams.subject?
    classifierModel.getSubject($routeParams.subject)
  
  $scope.updateContourParam = ->
    classifierModel.updateContourParam($scope.min, $scope.max, $scope.level)
  
  $scope.getInfraredSource = ->
    return classifierModel.infraredSource
  
  $scope.getRadioSource = ->
    return classifierModel.radioSource
  
  $scope.onNoFlux = ->
    console.log 'No Flux'
    
    # Post classification
    
    # Request next subject
    classifierModel.getSubject()
    
    $scope.step = 1
  
  $scope.onContinue = ->
    console.log 'Continue'
    $scope.step = 2
    classifierModel.drawSelected()
  
  $scope.onDone = ->
    console.log 'Done'
    
    # Post classification
    
    # Request next subject and return to step 1
    classifierModel.getSubject()
    $scope.step = 1


module.exports = Classifier