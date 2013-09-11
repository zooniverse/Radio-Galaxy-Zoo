
Step = zootorial.Step


addBlock = ->
  el = angular.element( document.querySelector(".viewport") )
  el.addClass("block")
  
  el = angular.element( document.querySelector("button.no-flux") )
  el.addClass("block")
  
removeBlock = ->
  el = angular.element( document.querySelector(".viewport") )
  el.removeClass("block")
  
  el = angular.element( document.querySelector("button.no-flux") )
  el.removeClass("block")


module.exports =
  length: 2
  
  welcome: new Step
    number: 1
    header: "Welcome to Radio Galaxy Zoo!"
    details: "Astronomers need your help to discover supermassive black holes in large galaxies. These black holes emit enormous jets of plasma, which can be detected by radio telescopes. The host galaxies themselves are often not seen in radio wavelengths, but are detected by infrared telescopes.  We need your help to combine the two: identify emission in radio wavelengths, and then associate that with its host galaxy."
    attachment: "center center .viewport center center"
    onEnter: -> addBlock()
    onExit: -> removeBlock()
    next: "radio1"
  
  radio1: new Step
    number: 2
    header: "Radio Emissions"
    details: "This is a radio image containing four strong components of emission."
    attachment: "center top .viewport center -0.12"
    onEnter: -> addBlock()
    onExit: -> removeBlock()
    next: "radio2"
  
  radio2: new Step
    number: 3
    header: "Radio Emissions"
    details: "The two large components in the center of the image actually come from the same host galaxy, due to jets of plasma coming from the supermassive black hole."
    attachment: "center top .viewport center -0.12"
    className: "arrow-bottom"
    onEnter: (tutorial) ->
      addBlock()
      
      for id in tutorial.contours
        el = d3.select("#svg-contours path[contourid='#{id}']")
        el.attr("class", "svg-contour radiate")
    onExit: (tutorial) ->
      removeBlock()
      
      for id in tutorial.contours
        el = d3.select("#svg-contours path[contourid='#{id}']")
        el.attr("class", "svg-contour")
    next: "infrared"
  
  infrared: new Step
    number: 4
    header: "Infrared Galaxy"
    details: "Switching to the corresponding infrared image, taken by the Spitzer Space Telescope, we can see the host galaxy lying between the two radio components."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      addBlock()
      infraredEl = document.querySelector("p.band[data-band='infrared']")
      contoursEl = document.querySelector(".toggle-contours")
      infraredEl.click()
      contoursEl.click()
      
      # Highlight the host galaxy
      svg = d3.select(".svg-contours")
      svg.append("circle")
        .attr("class", "tutorial")
        .attr("r", 10)
        .attr("cx", 213)
        .attr("cy", 211)
      
    onExit: ->
      removeBlock()
      d3.select("circle.tutorial").remove()
    next: "matching1"
  
  matching1: new Step
    number: 5
    header: "Matching Radio and Infrared Sources"
    details: "<p>We need your help to match radio components with their host galaxy. Let's match the radio components in the center of the image.</p><b>Click</b> the two large components in the center of the image, then <b>click</b> 'Continue'."
    attachment: "center top .viewport center -0.12"
    className: "arrow-bottom"
    onEnter: (tutorial) ->
      radioEl = document.querySelector("p.band[data-band='radio']")
      contoursEl = document.querySelector(".toggle-contours")
      radioEl.click()
      contoursEl.click()
      
      # Block the continue button
      buttonEl = angular.element( document.querySelector("button.continue") )
      buttonEl.attr("disabled", "disabled")
      
      contours = tutorial.contours
      $("#svg-contours").on("click", ->
        ids = d3.selectAll("path.selected")[0].map( (el) -> return d3.select(el).attr("contourid") )
        if contours[0] in ids and contours[1] in ids and ids.length is 2
          buttonEl.removeAttr("disabled")
        else
          buttonEl.attr("disabled", "disabled")
      )
      
    next:
      "click button.continue": "matching2"
  
  matching2: new Step
    number: 6
    header: "Matching Radio and Infrared Sources"
    details: "Draw a circle around the corresponding infrared source by <b>clicking and dragging</b> from its center."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      svg = d3.select(".svg-contours")
      svg.append("circle")
        .attr("class", "tutorial radiate")
        .attr("r", 10)
        .attr("cx", 213)
        .attr("cy", 211)
    onExit: ->
      d3.select("circle.tutorial").remove()
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
    number: 7
    header: "Well done!"
    details: "<p>You helped match a galaxy to the two radio jets emanating from an invisible supermassive black hole at its center!</p> Click 'Done' to continue."
    attachment: "center top .viewport center -0.12"
    next:
      "click button.done": "finish"
  
  finish: new Step
    number: 8
    header: "Great job!"
    details: "Thanks for helping! Click 'Next' to help match the next patch of sky."
    attachment: "center top .viewport center -0.12"
    next:
      "click button.next": true
