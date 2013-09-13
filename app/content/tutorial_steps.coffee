
Step = zootorial.Step


addBlock = ->
  el = angular.element( document.querySelector(".viewport") )
  el.addClass("block")
  
  el = angular.element( document.querySelector("span.toggle-contours") )
  el.addClass("block")
  
removeBlock = ->
  el = angular.element( document.querySelector(".viewport") )
  el.removeClass("block")
  
  el = angular.element( document.querySelector("span.toggle-contours") )
  el.removeClass("block")

disableButtons = ->
  els = angular.element( document.querySelectorAll(".workflow .buttons button") )
  els.attr("disabled", "disabled")

enableButtons = ->
  els = angular.element( document.querySelectorAll(".workflow .buttons button") )
  els.removeAttr("disabled")


module.exports =
  length: 2
  
  welcome: new Step
    number: 1
    header: "Welcome to Radio Galaxy Zoo!"
    details: "Astronomers need your help to discover supermassive black holes in large galaxies. These black holes emit enormous jets of plasma, which can be detected by radio telescopes. The host galaxies themselves are often not seen in radio wavelengths, but are detected by infrared telescopes.  We need your help to combine the two: identify emission in radio wavelengths, and then associate that with its host galaxy."
    attachment: "center center .viewport center center"
    onEnter: ->
      addBlock()
      disableButtons()
    onExit: ->
      removeBlock()
      enableButtons()
    next: "radio1"
  
  radio1: new Step
    number: 2
    header: "Radio Emissions"
    details: "This is a radio image containing four strong components of emission."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      addBlock()
      disableButtons()
    onExit: ->
      removeBlock()
      enableButtons()
    next: "radio2"
  
  radio2: new Step
    number: 3
    header: "Radio Emissions"
    details: "The two large components in the center of the image actually come from the same host galaxy, due to jets of plasma coming from the supermassive black hole."
    attachment: "center top .viewport center -0.12"
    className: "arrow-bottom"
    onEnter: (tutorial) ->
      addBlock()
      disableButtons()
      
      for id in tutorial.contours[0]
        el = d3.select("#svg-contours g[id='#{id}']")
        el.attr("class", "contour-group pulsate")
    onExit: (tutorial) ->
      removeBlock()
      enableButtons()
      
      for id in tutorial.contours[0]
        el = d3.select("#svg-contours g[id='#{id}']")
        el.attr("class", "contour-group")
    next: "infrared"
  
  infrared: new Step
    number: 4
    header: "Infrared Galaxy"
    details: "Switching to the corresponding infrared image, taken by the Spitzer Space Telescope, we can see the host galaxy lying between the two radio components."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      addBlock()
      disableButtons()
      
      infraredEl = document.querySelector("p.band[data-band='infrared']")
      contoursEl = document.querySelector(".toggle-contours")
      infraredEl.click()
      contoursEl.click()
      
      # Highlight the host galaxy
      svg = d3.select(".svg-contours")
      svg.append("circle")
        .attr("class", "tutorial pulsate")
        .attr("r", 10)
        .attr("cx", 213)
        .attr("cy", 211)
      
    onExit: ->
      removeBlock()
      enableButtons()
      
      d3.select("circle.tutorial").remove()
    next: "matching1"
  
  matching1: new Step
    number: 5
    header: "Matching Radio and Infrared Sources"
    details: "<p>We need your help to match radio components with their host galaxy. Let's match the radio components in the center of the image.</p><b>Click</b> the two large components in the center of the image, then <b>click</b> 'Continue'."
    attachment: "center top .viewport center -0.12"
    className: "arrow-bottom"
    onEnter: (tutorial) ->
      disableButtons()
      
      radioEl = document.querySelector("p.band[data-band='radio']")
      contoursEl = document.querySelector(".toggle-contours")
      buttonEl = angular.element( document.querySelector("button.continue") )
      
      radioEl.click()
      contoursEl.click()
      
      contours = tutorial.contours[0]
      $("#svg-contours").on("click", ->
        
        ids = d3.selectAll("g.contour-group.selected")[0].map( (el) -> return d3.select(el).attr("id") )
        if contours[0] in ids and contours[1] in ids and ids.length is 2
          buttonEl.removeAttr("disabled")
        else
          buttonEl.attr("disabled", "disabled")
      )
    onExit: ->
      enableButtons()
      $("#svg-contours").off("click")
    next:
      "click button.continue": "matching2"
  
  matching2: new Step
    number: 6
    header: "Matching Radio and Infrared Sources"
    details: "Draw a circle around the corresponding infrared source by <b>clicking and dragging</b> from its center."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      disableButtons()
      
      svg = d3.select(".svg-contours")
      svg.append("circle")
        .attr("class", "tutorial pulsate-and-hide")
        .attr("r", 10)
        .attr("cx", 213)
        .attr("cy", 211)
    onExit: ->
      enableButtons()
      d3.select("circle.tutorial").remove()
    next:
      "mouseup #svg-contours": (e, tutorial, step) ->
        g = d3.select("g.infrared g")
        transform = g.attr("transform")
        translateRegEx = /translate\((-?\d+), (-?\d+)\)/
        match = transform.match(translateRegEx)
        x = parseInt match[1]
        y = parseInt match[2]
        
        if x > 203 and x < 223 and y > 201 and y < 221
          return "matched1"
        return false
  
  matched1: new Step
    number: 7
    header: "Well done!"
    details: "<p>You helped match a galaxy to the two radio jets emanating from an invisible supermassive black hole at its center!</p> Let's make another match. <b>Click</b> 'Select Another Radio Complex'."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      disableButtons()
      
      el = angular.element( document.querySelector("button.next-radio") )
      el.removeAttr("disabled")
    onExit: ->
      enableButtons()
    next:
      "click button.next-radio": "matching3"
  
  matching3: new Step
    number: 8
    header: "Matching Radio and Infrared Sources"
    details: "Returning to the radio image, there are two strong components of emission remaining, each with its own host galaxy."
    attachment: "center top .viewport center -0.12"
    onEnter: (tutorial) ->
      addBlock()
      disableButtons()
      
      for id in tutorial.contours[1..2]
        el = d3.select("#svg-contours g[id='#{id}']")
        el.attr("class", "contour-group pulsate")
    onExit: (tutorial) ->
      removeBlock()
      enableButtons()
      
      for id in tutorial.contours[1..2]
        el = d3.select("#svg-contours g[id='#{id}']")
        el.attr("class", "contour-group")
    next: "matching4"
  
  matching4: new Step
    number: 8
    header: "Matching Radio and Infrared Sources"
    details: "To see each host galaxy, use the slider to transition between radio and infrared images."
    attachment: "right center input.image-opacity -0.5 center"
    className: "arrow-right"
    onEnter: (tutorial) =>
      addBlock()
      disableButtons()
      
      for id in tutorial.contours[1..2]
        el = d3.select("#svg-contours g[id='#{id}']")
        el.attr("class", "contour-group selected")
    onExit: (tutorial) =>
      removeBlock()
      enableButtons()
      
      for id in tutorial.contours[1..2]
        el = d3.select("#svg-contours g[id='#{id}']")
        el.attr("class", "contour-group")
      
    next:
      "change input.image-opacity": (e, tutorial, step) ->
        if parseFloat(e.target.value) > 0.9
          return "matching5"
        return false
        
  matching5: new Step
    number: 8
    header: "Matching Radio and Infrared Sources"
    details: "Notice that each emission has a host galaxy. Let's match each radio emission to its host."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      addBlock()
      disableButtons()
      
      contoursEl = document.querySelector(".toggle-contours")
      contoursEl.click()
      
      svg = d3.select(".svg-contours")
      svg.append("circle")
        .attr("class", "tutorial pulsate")
        .attr("r", 10)
        .attr("cx", 314)
        .attr("cy", 144)
      svg.append("circle")
        .attr("class", "tutorial pulsate")
        .attr("r", 10)
        .attr("cx", 394)
        .attr("cy", 230)
    onExit: ->
      removeBlock()
      enableButtons()
      
      d3.selectAll("circle.tutorial").remove()
      
      contoursEl = document.querySelector(".toggle-contours")
      contoursEl.click()
      
    next: "matching6"
  
  matching6: new Step
    number: 9
    header: "Matching Radio and Infrared Sources"
    details: "Select the radio component for this emission, then <b>click</b> 'Continue'."
    attachment: "center top .viewport center -0.12"
    onEnter: (tutorial) ->
      disableButtons()
      
      buttonEl = angular.element( document.querySelector("button.continue") )
      radioEl = document.querySelector("p.band[data-band='radio']")
      radioEl.click()
      
      id = tutorial.contours[1]
      el = d3.select("#svg-contours g[id='#{id}']")
      el.attr("class", "contour-group pulsate-to-white")
      
      $("#svg-contours").on("click", ->
        
        ids = d3.selectAll("g.contour-group.selected")[0].map( (el) -> return d3.select(el).attr("id") )
        if tutorial.contours[1] in ids and ids.length is 1
          buttonEl.removeAttr("disabled")
        else
          buttonEl.attr("disabled", "disabled")
      )
    onExit: (tutorial) ->
      enableButtons()
      
      id = tutorial.contours[1]
      el = d3.select("#svg-contours g[id='#{id}']")
      el.attr("class", "contour-group")
    next:
      "click button.continue": "matching7"
  
  matching7: new Step
    number: 10
    header: "Matching Radio and Infrared Sources"
    details: "Draw a circle around the corresponding infrared source by <b>clicking and dragging</b> from its center."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      disableButtons()
      
      svg = d3.select(".svg-contours")
      svg.append("circle")
        .attr("class", "tutorial pulsate-and-hide")
        .attr("r", 10)
        .attr("cx", 314)
        .attr("cy", 144)
    onExit: ->
      enableButtons()
      d3.select("circle.tutorial").remove()
    next:
      "mouseup #svg-contours": (e, tutorial, step) ->
        g = d3.select("g.infrared g:not(.matched)")
        transform = g.attr("transform")
        translateRegEx = /translate\((-?\d+), (-?\d+)\)/
        match = transform.match(translateRegEx)
        x = parseInt match[1]
        y = parseInt match[2]
        console.log x, y
        if x > 304 and x < 324 and y > 134 and y < 154
          return "matching8"
        return false
  
  matching8: new Step
    number: 11
    header: "Matching Radio and Infrared Sources"
    details: "Now let's match the final emission! <b>Click</b> 'Select Another Radio Complex'."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      disableButtons()
      buttonEl = angular.element( document.querySelector("button.next-radio") )
      buttonEl.removeAttr("disabled")
    onExit: ->
      enableButtons()
    next:
      "click button.next-radio": "matching9"
  
  matching9: new Step
    number: 12
    header: "Matching Radio and Infrared"
    details: "Select the remaining strong emission, and <b>click</b> 'Continue'."
    attachment: "center top .viewport center -0.12"
    onEnter: (tutorial) ->
      disableButtons()
      
      id = tutorial.contours[2]
      el = d3.select("#svg-contours g[id='#{id}']")
      el.attr("class", "contour-group pulsate-to-white")
      
      buttonEl = angular.element( document.querySelector("button.continue") )
      $("#svg-contours").on("click", ->
        
        ids = d3.selectAll("g.contour-group.selected")[0].map( (el) -> return d3.select(el).attr("id") )
        if tutorial.contours[2] in ids and ids.length is 1
          buttonEl.removeAttr("disabled")
        else
          buttonEl.attr("disabled", "disabled")
      )
    onExit: (tutorial) ->
      enableButtons()
      
      id = tutorial.contours[2]
      el = d3.select("#svg-contours g[id='#{id}']")
      el.attr("class", "contour-group")
    next:
      "click button.continue": "matching10"
  
  matching10: new Step
    number: 13
    header: "Matching Radio and Infrared Sources"
    details: "Draw a circle around the corresponding infrared source by <b>clicking and dragging</b> from its center."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      disableButtons()
      
      svg = d3.select(".svg-contours")
      svg.append("circle")
        .attr("class", "tutorial pulsate-and-hide")
        .attr("r", 10)
        .attr("cx", 394)
        .attr("cy", 230)
    onExit: ->
      enableButtons()
      d3.select("circle.tutorial").remove()
    next:
      "mouseup #svg-contours": (e, tutorial, step) ->
        g = d3.select("g.infrared g:not(.matched)")
        transform = g.attr("transform")
        translateRegEx = /translate\((-?\d+), (-?\d+)\)/
        match = transform.match(translateRegEx)
        x = parseInt match[1]
        y = parseInt match[2]
        
        if x > 384 and x < 404 and y > 220 and y < 240
          return "matchComplete"
        return false
  
  matchComplete: new Step
    number: 14
    header: "Great job!"
    details: "You've matched 3 radio emissions to their host galaxies! <b>Click</b> 'Done' to see your matches!"
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      addBlock()
      disableButtons()
      el = angular.element( document.querySelector("button.done") )
      el.removeAttr("disabled")
    onExit: ->
      removeBlock()
      enableButtons()
    next:
      "click button.done": "finish"
  
  finish: new Step
    number: 15
    header: "Great job!"
    details: "Thanks for helping! Don't worry about matching all radio components, we're looking for only the largest sources."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      addBlock()
      disableButtons()
    onExit: ->
      removeBlock()
      enableButtons()
    next: "strays"

  strays: new Step
    number: 16
    header: "Weak Sources and Noise"
    details: "<p>Many of the small contours represent very weak radio emissions with no corresponding host, or they're just noise flucuations from the telescope. Don't worry about these stray sources. Help us find the largest emissions! Thanks for helping!</p><b>Click</b> 'Next' to begin!"
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      disableButtons()
      el = angular.element( document.querySelector("button.next") )
      el.removeAttr("disabled")
      d3.select("#svg-contours")
        .attr("class", "contours marking step-3 strays")
    onExit: ->
      enableButtons()
    next:
      "click button.next": true
