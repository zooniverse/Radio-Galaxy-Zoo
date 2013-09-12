
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      el = document.querySelector(".svg-contours")
      el.onclick = (e) ->
        
        # Count number of selected contours
        if scope.model.selectedContours.length > 0 or scope.model.matches.length > 0
          elem.removeAttr("disabled")
        else
          elem.attr("disabled", "disabled")
      
      # Recover state for continue button
      el.onclick()
  }