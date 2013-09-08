
Step = zootorial.Step


addBlock = ->
  el = angular.element( document.querySelector(".viewport") )
  el.addClass('block')
removeBlock = ->
  el = angular.element( document.querySelector(".viewport") )
  el.removeClass('block')


module.exports =
  length: 2
  
  welcome: new Step
    number: 1
    header: "Welcome to Radio Galaxy Zoo!"
    details: "We need your help cross-matching radio sources with their infrared counterpart."
    attachment: "center center .viewport center center"
    onEnter: -> addBlock()
    onExit: -> removeBlock()
    next: "radio"
  
  radio: new Step
    number: 2
    header: "Radio Sky"
    details: "The image shown is a radio image containing four strong emissions.  The two leftmost blobs are powerful radio jets emitting from a single galaxy."
    attachment: "center center .viewport center left"
    onEnter: ->
      addBlock()
      
      for id in ["26", "27"]
        el = d3.select("#svg-contours path[contourid='#{id}']")
        el.attr("class", "svg-contour radiate")
    onExit: ->
      removeBlock()
      
      for id in ["26", "27"]
        el = d3.select("#svg-contours path[contourid='#{id}']")
        el.attr("class", "svg-contour")
    next: "slide"
  
  slide: new Step
    number: 3
    header: "Infrared Sky"
    details: "To see the host galaxy use the slider to switch to the infrared image."
    attachment: "right center .image-slider left center"
    className: "arrow-right"
    onEnter: -> addBlock()
    onExit: -> removeBlock()
    next:
      "change input.image-opacity": (e, tutorial, step) ->
        value = parseFloat(e.target.value)
        return if value > 0.9 then "infrared" else false
  
  infrared: new Step
    number: 4
    header: "Infrared Sky"
    details: "The host galaxy lies in-between the radio emissions. Woot!"
    onEnter: ->
      addBlock()
      
      svg = d3.select(".svg-contours")
      svg.append("circle")
        .attr("class", "tutorial")
        .attr("r", 10)
        .attr("cx", 213)
        .attr("cy", 211)
    onExit: ->
      removeBlock()
      
      d3.select("circle.tutorial").remove()
    next: "task1"
  
  task1: new Step
    number: 5
    header: "Select Radio Contours"
    details: "We need your help to find these correspondences. Select the two emissions from the radio jets by clicking on the contours. Click 'Continue' when done."
    onEnter: ->
      # Switch image back to radio
      document.querySelector("p[data-band='radio']").click()
      
      # Block the continue button
      buttonEl = angular.element( document.querySelector("button.continue") )
      buttonEl.attr("disabled", "disabled")
      
      $("#svg-contours").on("click", ->
        ids = d3.selectAll("path.selected")[0].map( (el) -> return d3.select(el).attr("contourid") )
        if "26" in ids and "27" in ids and ids.length is 2
          buttonEl.removeAttr("disabled")
        else
          buttonEl.attr("disabled", "disabled")
      )
    onExit: ->
      $("#svg-contours").off("click")
    next:
      "click button.continue": "task2"
  
  task2: new Step
    number: 6
    header: "Select Infrared Source"
    details: "Now select the corresponding IR source by clicking and dragging from the center of the IR source."
    next:
      "mouseup #svg-contours": (e, tutorial, step) ->
        g = d3.select("g")
        transform = g.attr("transform")
        translateRegEx = /translate\((-?\d+), (-?\d+)\)/
        match = transform.match(translateRegEx)
        x = parseInt match[1]
        y = parseInt match[2]
        
        if x > 203 and x < 223 and y > 201 and y < 221
          return "complete"
        return false
  
  complete: new Step
    number: 2
    header: "Well done!"
    details: "You helped make a correspondence between two radio jets and it's host galaxy."