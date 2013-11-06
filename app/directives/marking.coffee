
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      # Regular expression for capturing group translation
      translateRegEx = /translate\((-?\d+), (-?\d+)\)/
      
      svg = d3.select("svg.svg-contours")
      
      # Create group for infrared annotations
      infraredGroup = d3.select("svg").append("g")
        .attr("class", "infrared")
      
      dx = dy = null
      img = document.querySelector("img.infrared")
      img = angular.element(img)
      elem = document.querySelector("input.image-opacity")
      
      onDragStart = ->
        img.addClass("no-transition")
        return unless scope.model.step is 1
        
        dx = d3.event.sourceEvent.layerX
        dy = d3.event.sourceEvent.layerY
      
      onDrag = ->
        
        # Update image opacity
        value = parseFloat( elem.value ) + d3.event.dx / 200
        elem.value = value
        img.css("opacity", value)
      
      onDragEnd = ->
        img.removeClass("no-transition")
        return unless scope.model.step is 1
        
        x = d3.event.sourceEvent.layerX
        y = d3.event.sourceEvent.layerY
        dx -= x
        dy -= y
        
        if dx is 0 and dy is 0
          group = infraredGroup.append("g")
            .attr("transform", "translate(#{x}, #{y})")
            .attr("class", "")  # Need to specify empty class for above interaction
          circle = group.append("circle")
                    .attr("class", "annotation")
                    .attr("cx", 0)
                    .attr("cy", 0)
                    .attr("r", 10)

      create = d3.behavior.drag()
        .on("dragstart", onDragStart)
        .on("drag", onDrag)
        .on("dragend", onDragEnd)
      
      svg.call(create)
  }