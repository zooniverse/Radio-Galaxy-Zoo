
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      console.log 'linking marking directive'
      
      # Drag callback to move annotation
      dragmove = ->
        g = d3.select(this)
        g.attr("transform", "translate(#{d3.event.x}, #{d3.event.y})")
      
      # Drag callback to scale annotation
      dragscale = ->
        console.log "scale drag"
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
          console.log "move dragstart"
          d3.event.sourceEvent.stopPropagation()
        )
        .on("drag", dragmove)
        .on("dragend", ->
          console.log "move dragend"
        )
      
      scale = d3.behavior.drag()
        .on("dragstart", ->
          console.log "scale dragstart"
          d3.event.sourceEvent.stopPropagation()
        )
        .on("drag", dragscale)
        .on("dragend", ->
          console.log "scale dragend"
        )
      
      svg = d3.select("svg")
      
      g = h = a = null
      mainDrag = d3.behavior.drag()
        .on("dragstart", ->
          # return if scope.step is 1
          console.log 'mainDrag dragstart'
          x = d3.event.sourceEvent.layerX
          y = d3.event.sourceEvent.layerY
          
          # Create new annotation
          g = svg.append("g")
                .attr("transform", "translate(#{x}, #{y})")
          
          a = g.append("circle")
                .attr("class", "annotation")
                .attr("r", 1)
                .attr("cx", 0)
                .attr("cy", 0)
          
          h = g.append("circle")
            .attr("class", "handle")
            .attr("r", 10)
            .attr("cx", 0)
            .attr("cy", 0)
          
          h.call(scale)
          g.call(move)
        )
        .on("drag", ->
          console.log "mainDrag drag"
          # return if scope.step is 1
          x = parseFloat( h.attr("cx") ) + d3.event.dx
          y = parseFloat( h.attr("cy") ) + d3.event.dy
          
          h.attr("cx", x)
          h.attr("cy", y)
          
          a.attr("r", Math.sqrt(x * x + y * y))
        )
        .on("dragend", ->
          # return if scope.step is 1
          console.log "mainDrag dragend"
          g = h = a = null
        )
      
      d3.select(elem[0]).call(mainDrag)
  }