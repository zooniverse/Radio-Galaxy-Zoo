
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      elem.on("click", ->
        scope.$apply( ->
          scope.model.example = elem.data().type
        )
      )
      return
      el = document.querySelector(".example")
      el.onclick = (e) ->
        
        # Count number of selected contours
        if scope.model.selectedContours.length > 0
          elem.removeAttr("disabled")
        else
          elem.attr("disabled", "disabled")
      
      # Recover state for continue button
      el.onclick()
  }