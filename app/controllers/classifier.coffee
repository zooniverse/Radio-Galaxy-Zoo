
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
  
  # Listen for ready because controller does not seem to
  # trigger when array or object is changed.  This could be 
  # due to model embedded in SVG.
  $scope.$on('ready', (e) ->
    $scope.contours = classifierModel.contours
    $scope.src = classifierModel.src
    $scope.$digest()
  )
  
  $scope.addCircle = (x, y) ->
    if $scope.step is 2
      $scope.classifierModel.addCircle(x, y)
  
  $scope.onCircle = (e) ->
    console.log 'onCircle', e
    e.stopPropagation()
  
  $scope.onContour = (e) ->
    return unless $scope.step is 1
    
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
  
  $scope.getStepMessage = ->
    if $scope.step is 3
      return "Complete!"
    else
      return "Step #{$scope.step} of 2"
  
  $scope.drawCatalogSources = ->
    console.log 'drawCatalogSources'
    catalog = classifierModel.subject.metadata.catalog
    return unless catalog?
    
    svg = d3.select("svg")
    factor = 500 / 300
    
    for object in catalog
      cx = factor * parseFloat(object.x)
      cy = 500 - factor * parseFloat(object.y)
      
      do (object) ->
        svg.append("circle")
            .attr("cx", cx)
            .attr("cy", cy)
            .attr("r", 10)
            .attr("class", "source")
            .on("click", ->
              alert "This is a source from the 2MASS catalog with Bmag: #{object.Bmag}, Rmag: #{object.Rmag}, Jmag: #{object.Jmag}, Hmag: #{object.Hmag}, Kmag: #{object.Kmag}"
            )
  
  #
  # Workflow handlers
  #
  
  $scope.onNoFlux = ->
    $scope.showContours = true
    $scope.step = 3
    $scope.drawCatalogSources()
  
  $scope.onContinue = ->
    $scope.step = 2
    
    # Draw only selected contours
    contours = []
    for index in classifierModel.selectedContours
      contours.push classifierModel.contours[index]
    $scope.contours = contours
  
  $scope.onNoCorrespondingFlux = ->
    $scope.showContours = true
    $scope.step = 3
    $scope.drawCatalogSources()
  
  $scope.onDone = ->
    $scope.showContours = true
    $scope.step = 3
    
    $scope.drawCatalogSources()
  
  $scope.onNext = ->
    
    # TODO: Post classification
    
    # Request next subject and return to step 1
    classifierModel.getSubject()
    $scope.step = 1
    
    # Remove annotation
    d3.selectAll('path').remove()
    d3.selectAll('circle').remove()
    d3.selectAll('text').remove()
  
  # TODO: Post Favorite
  $scope.onFavorite = ->
    alert "OMG THIS PICTURE IS SOOOOO COOL!"
  
  # TODO: Open in Talk
  $scope.onDiscuss = ->
    alert "Sorry, Talk doesn't work yet"


module.exports = Classifier