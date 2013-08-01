
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      scope.$watch('showContours', (val) ->
        if val
          elem.removeClass('fade')
        else
          elem.addClass('fade')
      )
  }