

Classifier = ($scope, classifierModel) ->
  console.log 'Classifier'
  
  $scope.classifierModel = classifierModel
  $scope.opacity = 0
  $scope.showContours = true
  $scope.step = 1
  $scope.level = 3
    
  $scope.min = 0
  $scope.max = 1000
  
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
  
  $scope.onDone = ->
    console.log 'Done'
    
    # Post classification
    
    # Request next subject
    classifierModel.getSubject()
    
    $scope.step = 1
    

# Classifier = ($scope, $rootScope, $http) ->
#   
#   # Declare some models
#   $scope.extent = {}
#   $scope.selected = null
#   $scope.level = 3
#   $scope.canvases = []
#   $scope.contours = true
#   
#   $scope.onClick = (e) ->
#     @x = e.layerX
#     @y = e.layerY
#   
#   $scope.setBand = (val) ->
#     @currentSrc = if val is 'ir' then @irSrc else @radioSrc
#   
#   $scope.getSubject = ->
#     
#     $http.get('subjects.json')
#       .success( (data) =>
#         
#         # Choose a random subject for now
#         @subject = data[ Math.floor( Math.random() * data.length ) ]
#         @subjectId = @subject.id
#         
#         @irSrc = @subject.location.ir
#         @radioSrc = @subject.location.radio
#         @currentSrc = @radioSrc
#       )
#   
#   # Get first subject
#   $scope.getSubject()


module.exports = Classifier