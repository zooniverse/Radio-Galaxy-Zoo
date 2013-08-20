
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      # Regular expression for capturing group translation
      r = /translate\((-?\d+), (-?\d+)\)/
      
      # Drag callback to move annotation
      dragmove = ->
        g = d3.select(this)
        transform = g.attr("transform")
        match = transform.match(r)
        
        x = parseInt match[1]
        y = parseInt match[2]
        
        x += d3.event.dx
        y += d3.event.dy
        g.attr("transform", "translate(#{x}, #{y})")
      
      # Drag callback to scale annotation
      dragscale = ->
        x = d3.event.x
        y = d3.event.y
        
        h = d3.select(this)
                  .attr("cx", x)
                  .attr("cy", y)
        
        sibling = h.node().previousSibling
        a = d3.select(sibling)
        a.attr("r", Math.sqrt(x * x + y * y))
      
      move = d3.behavior.drag()
        .on("dragstart", ->
          return unless scope.step is 2
          
          d3.event.sourceEvent.stopPropagation()
          group = d3.select(this)
          
          this.initialX = d3.event.sourceEvent.x
          this.initialY = d3.event.sourceEvent.y
        )
        .on("drag", dragmove)
        .on("dragend", ->
          # Toggle active state if group did not move
          if this.initialX is d3.event.sourceEvent.x and
             this.initialY is d3.event.sourceEvent.y
            group = d3.select(this)
            isActive = group.attr("class")
            if isActive?
              group.attr("class", null)
            else
              group.attr("class", "active")
        )
      
      scale = d3.behavior.drag()
        .on("dragstart", ->
          return unless scope.step is 2
          d3.event.sourceEvent.stopPropagation()
        )
        .on("drag", dragscale)
      
      svg = d3.select("svg")
      
      g = h = a = c = t = null
      mainDrag = d3.behavior.drag()
        .on("dragstart", ->
          return unless scope.step is 2
          
          # Deselect all previously existing groups
          d3.selectAll("g").attr("class", null)
          
          x = d3.event.sourceEvent.layerX
          y = d3.event.sourceEvent.layerY
          
          # Create new annotation group
          g = svg.append("g")
                .attr("transform", "translate(#{x}, #{y})")
          
          # Create the annotation
          a = g.append("circle")
              .attr("class", "annotation")
              .attr("r", 1)
              .attr("cx", 0)
              .attr("cy", 0)
          
          # Create the annotation handle
          h = g.append("circle")
              .attr("class", "handle")
              .attr("r", 6)
              .attr("cx", 0)
              .attr("cy", 0)
          
          # Create the annotation close
          c = g.append("circle")
              .attr("class", "remove")
              .attr("r", "6")
              .attr("cx", "0")
              .attr("cy", "0")
              .on("mousedown", -> d3.event.stopPropagation() )
              .on("mouseup", ->
                d3.select(this.parentNode).remove()
              )
          
          # Create close text
          t = g.append("text")
                .text("x")
                .attr("x", -3)
                .attr("y", 3)
          
          h.call(scale)
          g.call(move)
        )
        .on("drag", ->
          return unless scope.step is 2
          
          x = parseFloat( h.attr("cx") ) + d3.event.dx
          y = parseFloat( h.attr("cy") ) + d3.event.dy
          
          h.attr("cx", x)
          h.attr("cy", y)
          
          a.attr("r", Math.sqrt(x * x + y * y))
        )
        .on("dragend", ->
          return unless scope.step is 2
          
          g = h = a = c = t = null
        )
      
      d3.select(elem[0]).call(mainDrag)
  }