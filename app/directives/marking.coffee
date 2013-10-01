
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
      
      # Define drag callback to move the annotation
      onAnnotationDragStart = ->
        d3.event.sourceEvent.stopPropagation()
        return unless scope.model.step is 2
      
      onAnnotationDrag = ->
        d3.event.sourceEvent.stopPropagation()
        return unless scope.model.step is 2
        
        group = d3.select(this)
        transform = group.attr("transform")
        match = transform.match(translateRegEx)
        
        x = parseInt match[1]
        y = parseInt match[2]
        
        x += d3.event.dx
        y += d3.event.dy
        group.attr("transform", "translate(#{x}, #{y})")
      
      move = d3.behavior.drag()
        .on("dragstart", onAnnotationDragStart)
        .on("drag", onAnnotationDrag)
      
      dx = dy = null
      onDragStart = ->
        return unless scope.model.step is 2
        # return if scope.model.nCircles is 1
        dx = d3.event.sourceEvent.layerX
        dy = d3.event.sourceEvent.layerY
      
      onDragEnd = ->
        x = d3.event.sourceEvent.layerX
        y = d3.event.sourceEvent.layerY
        dx -= x
        dy -= y
        
        if dx is 0 and dy is 0
          group = infraredGroup.append("g")
            .attr("transform", "translate(#{x}, #{y})")
          circle = group.append("circle")
                    .attr("class", "annotation")
                    .attr("cx", 0)
                    .attr("cy", 0)
                    .attr("r", 10)
          group.call(move)
      
      create = d3.behavior.drag()
        .on("dragstart", onDragStart)
        .on("dragend", onDragEnd)
      
      svg.call(create)
  }