
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      img = document.querySelector("img.infrared")
      img = angular.element(img)
      img.css("opacity", 0)
      
      infraredEl = document.querySelector("p.band[data-band='infrared']")
      radioEl = document.querySelector("p.band[data-band='radio']")
      
      # TODO: Touch events?
      radioEl.onclick = ->
        elem[0].value = 0
        elem[0].onchange()
      infraredEl.onclick = ->
        elem[0].value = 1
        elem[0].onchange()
      
      elem[0].onchange = (e) ->
        value = elem[0].value
        img.css('opacity', value)
      
      # Watch scope.step to update image opacity accordingly
      scope.$watch('step', (step) ->
        if step is 1
          radioEl.onclick()
        else if step is 2
          infraredEl.onclick()
      )
  }