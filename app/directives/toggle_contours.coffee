
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      el = document.querySelector("#svg-contours")
      el = angular.element(el)
      contoursShow = true
      
      elem[0].onclick = (e) ->
        if contoursShow
          el.addClass('fade')
          @textContent = "show contours"
          contoursShow = false
        else
          el.removeClass('fade')
          @textContent = "hide contours"
          contoursShow = true
  }