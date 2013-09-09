
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      elem.on("click", ->
        scope.$apply( ->
          scope.model.example = elem.data().type
        )
      )
  }