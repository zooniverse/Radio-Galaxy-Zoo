
module.exports = ->
  restrict: 'C'
  link: (scope, elem, attrs) ->
    elem.on("click", ->
      scope.$apply(->
        scope.model.subExample = elem.data().subexample
      )
    )
