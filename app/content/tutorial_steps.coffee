
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
    details: "Astronomers need your help to discover super massive black holes in large galaxies. These black holes emit enormous jets of plasma, which are detected by radio telescope. The host galaxies are often not seen by radio telescopes, but are detected by infrared telescopes.  We need your help to identify radio emissions, and associated it with the host galaxy."
    attachment: "center center .viewport center center"
    onEnter: -> addBlock()
    onExit: -> removeBlock()
    next: "radio1"
  
  radio1: new Step
    number: 2
    header: "Radio Emissions"
    details: "This is a radio image containing four strong radio emissions."
    attachment: "center top .viewport center -0.1"
    onEnter: -> addBlock()
    onExit: -> removeBlock()
    next: "radio2"
  
  radio2: new Step
    number: 3
    header: "Radio Emissions"
    details: "The two large emissions in the center of the image are plasma jets being propelled from the nucleus of a host galaxy."
    attachment: "center top .viewport center -0.1"
    className: "arrow-bottom"
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
    next: "infrared"
  
  infrared: new Step
    number: 4
    header: "Infrared Galaxy"
    details: "Switching to a corresponding infrared image, taken by the Spitzer Space Telescope, we can see the host galaxy lying between the two radio emissions."
    attachment: "center top .viewport center -0.1"
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
    details: "We need your help to match radio emissions with their host galaxy. <b>Click</b> the two large emissions in the center of the image, then <b>click</b> 'Continue'."
    attachment: "center top .viewport center -0.1"
    onEnter: ->
      radioEl = document.querySelector("p.band[data-band='radio']")
      contoursEl = document.querySelector(".toggle-contours")
      radioEl.click()
      contoursEl.click()
      
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
      
    next:
      "click button.continue": "matching2"
  
  matching2: new Step
    number: 6
    header: "Matching Radio and Infrared Sources"
    details: "Select the corresponding infrared source by <b>clicking and dragging</b> from the center of the IR source."
    attachment: "center top .viewport center -0.1"
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
    details: "<p>You helped match a galaxy with two radio jets emanating from it's center!</p> Click 'Done' to continue."
    attachment: "center top .viewport center -0.1"
    next:
      "click button.done": "finish"
  
  finish: new Step
    number: 8
    header: "Great job!"
    details: "Thanks for helping! Click 'Next' to help match the next patch of sky."
    attachment: "center top .viewport center -0.1"
    next:
      "click button.next": true