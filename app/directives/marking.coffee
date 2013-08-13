
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      console.log 'linking marking directive'
      
      # Create drag event
      dragmove = (d) ->
        console.log this, d3.event
        d3.select(this)
          .attr("cx", d3.event.x)
          .attr("cy", d3.event.y)
      
      drag = d3.behavior.drag()
        .on("drag", dragmove)
      
      svg = d3.select("svg")
      selected = null
      
      # elem.bind("mousemove", (e) ->
      #   return unless selected
      #   
      #   x = e.layerX
      #   y = e.layerY
      #   
      #   selected.attr("cx", x)
      #   selected.attr("cy", y)
      #   
      #   sibling = selected.node().nextSibling
      #   annotation = d3.select(sibling)
      #   cx = annotation.attr("cx")
      #   cy = annotation.attr("cy")
      #   
      #   cx -= x
      #   cy -= y
      #   r = Math.sqrt(cx * cx + cy * cy)
      #   annotation.attr("r", r)
      # )
      
      elem.bind("mousedown", (e) ->
        return if scope.step is 1
        
        group = svg.append("g")
          # .on("mousedown", ->
          #   d3.event.stopPropagation()
          # )
        
        handle = group.append("circle")
          .attr("class", "handle")
          .attr("r", 10)
          .attr("cx", e.layerX)
          .attr("cy", e.layerY)
        
        annotation = group.append("circle")
          .attr("class", "annotation")
          .attr("r", 1)
          .attr("cx", e.layerX)
          .attr("cy", e.layerY)
        
        handle.call(drag)
        
        # # Events for adjusting annotation
        # handle.on("mousemove", ->
        #   e = d3.event
        #   x = e.layerX
        #   y = e.layerY
        #   
        #   item = d3.select(@)
        #   
        #   item.attr("cx", x)
        #   item.attr("cy", y)
        #   
        #   cx = annotation.attr("cx")
        #   cy = annotation.attr("cy")
        #   
        #   cx -= x
        #   cy -= y
        #   r = Math.sqrt(cx * cx + cy * cy)
        #   annotation.attr("r", r)
        # )
      )
  }