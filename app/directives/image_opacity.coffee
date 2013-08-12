
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      img = document.querySelector("img.infrared")
      img = angular.element(img)
      
      elem[0].onchange = (e) ->
        value = elem[0].value
        img.css('opacity', 1.0 - value)
  }