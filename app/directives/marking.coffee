
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      console.log 'linking marking directive'
      elem.bind("mousedown", (e) ->
        x = e.layerX
        y = e.layerY
        
        scope.addCircle(x, y)
      )
  }