
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      elem[0].onclick = (e) ->
        return if scope.step is 3
        
        scope.showContours = if scope.showContours then false else true
        scope.$apply()
  }