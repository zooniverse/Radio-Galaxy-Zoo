
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      img = document.querySelector("img.infrared")
      img = angular.element(img)
      
      infraredEl = document.querySelector("p.band[data-band='infrared']")
      radioEl = document.querySelector("p.band[data-band='radio']")
      
      # TODO: Touch events
      infraredEl.onclick = ->
        elem[0].value = 0
        elem[0].onchange()
      radioEl.onclick = ->
        elem[0].value = 1
        elem[0].onchange()
      
      elem[0].onchange = (e) ->
        value = elem[0].value
        img.css('opacity', 1.0 - value)
  }