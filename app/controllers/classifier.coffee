

Classifier = ($scope, $routeParams, classifierModel) ->
  console.log 'Classifier'
  
  $scope.classifierModel = classifierModel
  $scope.showContours = true
  $scope.step = 1
  $scope.level = 3
    
  $scope.min = 0
  $scope.max = 1000
  
  $scope.contours = classifierModel.contours
  $scope.src = classifierModel.src
  $scope.circles = classifierModel.circles
  
  if $routeParams.subject?
    classifierModel.getSubject($routeParams.subject)
  
  $scope.$on('ready', (e) ->
    console.log 'ready'
    $scope.circles = classifierModel.circles
    $scope.contours = classifierModel.contours
    $scope.src = classifierModel.src
    $scope.$digest()
  )
  
  $scope.addCircle = (x, y) ->
    $scope.classifierModel.addCircle(x, y)
  
  $scope.onContour = (e) ->
    el = e.target
    classes = el.className.baseVal
      
    contourid = el.getAttribute("contourid")
    
    if classes.indexOf('selected') > -1
      el.setAttribute('class', 'svg-contour')
      classifierModel.removeContour(contourid)
    else
      el.setAttribute('class', 'svg-contour selected')
      classifierModel.addContour(contourid)
  
  $scope.drawContour = (contour) ->
    return unless contour
    console.log 'drawContour'
    
    factor = 500 / 301
    
    path = []
    for point, index in contour
      path.push "#{factor * point.y}, #{factor * point.x}"
    return "M#{path.join(" L")}"
  
  $scope.updateContourParam = ->
    classifierModel.updateContourParam($scope.min, $scope.max, $scope.level)
  
  $scope.getInfraredSource = ->
    return classifierModel.infraredSource
  
  $scope.getRadioSource = ->
    return classifierModel.radioSource
  
  $scope.onContinue = ->
    console.log 'Continue'
    $scope.step = 2
    
    contours = []
    for index in classifierModel.selectedContours
      contours.push classifierModel.contours[index]
    $scope.contours = contours
  
  $scope.onNoFlux = ->
    console.log 'No Flux'
    
    # Post classification
    
    # Request next subject
    classifierModel.getSubject()
    
    $scope.step = 1
  
  $scope.onDone = ->
    console.log 'Done'
    
    # Post classification
    
    # Request next subject and return to step 1
    classifierModel.getSubject()
    $scope.step = 1


module.exports = Classifier