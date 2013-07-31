
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      scope.$watch('opacity', (val) ->
        elem.css('opacity', 1.0 - val)
      )
  }