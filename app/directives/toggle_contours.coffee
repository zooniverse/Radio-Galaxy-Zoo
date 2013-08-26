
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      elem[0].onclick = (e) ->
        scope.showContours = if scope.showContours then false else true
        scope.$apply()
  }