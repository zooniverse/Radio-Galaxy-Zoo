
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      el = document.querySelector(".svg-contours")
      el.onclick = (e) ->
        
        # Count number of selected contours
        if scope.classifierModel.selectedContours.length > 0
          angular.element(elem).removeAttr("disabled")
        else
          angular.element(elem).attr("disabled", "disabled")
  }