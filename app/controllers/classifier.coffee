

Classifier = ($scope, $rootScope, $http) ->
  
  # Declare some models
  $scope.extent = {}
  $scope.selected = null
  $scope.level = 3
  $scope.canvases = []
  $scope.contours = true
  
  $scope.onClick = (e) ->
    @x = e.layerX
    @y = e.layerY
  
  $scope.setBand = (val) ->
    @currentSrc = if val is 'ir' then @irSrc else @radioSrc
  
  $scope.getSubject = ->
    
    $http.get('subjects.json')
      .success( (data) =>
        
        # Choose a random subject for now
        @subject = data[ Math.floor( Math.random() * data.length ) ]
        @subjectId = @subject.id
        
        @irSrc = @subject.location.ir
        @radioSrc = @subject.location.radio
        @currentSrc = @radioSrc
      )
  
  # Get first subject
  $scope.getSubject()


module.exports = Classifier