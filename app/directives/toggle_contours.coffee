
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      elem[0].onclick = (e) ->
        scope.$apply( ->
          scope.model.showContours = if scope.model.showContours then false else true
        )
  }