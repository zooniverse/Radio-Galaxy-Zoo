
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
    details: "Supermassive black holes at the center of large galaxies emit enormous jets of plasma, which can be detected by radio telescopes. The galaxies where these black holes live are often not seen in radio wavelengths, but they appear bright at infrared wavelengths. We need your help to combine the two: first identify jet emission in radio wavelengths and then use the infrared (IR) image to identify the galaxy the jets were ejected from."
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
    header: "Selecting the Radio Emission"
    details: "This is a radio image. The contours show a line of emission that may be from a jet. Click on the radio contours to select them."
    attachment: "center top .viewport center -0.12"
    onEnter: (tutorial) ->
      disableButtons()
      
      setTimeout ( ->
        for id in tutorial.contours[0]
          el = d3.select("#svg-contours g[id='#{id}']")
          el.attr("class", "contour-group pulsate")
      ), 500
      
      setTimeout ( ->
        for id in tutorial.contours[0]
          el = d3.select("#svg-contours g[id='#{id}']")
          el.attr("class", "contour-group")
      ), 3000
    onExit: (tutorial) ->
      enableButtons()
    next: (e, tutorial, step) ->
      console.log "HERE", e, tutorial, step
      
      buttonEl = angular.element( document.querySelector("button.continue") )
      contours = tutorial.contours[0]
      
      $("#svg-contours").on("click", ->
        ids = d3.selectAll("g.contour-group.selected")[0].map( (el) -> return d3.select(el).attr("id") )
        if contours[0] in ids and contours[1] in ids and contours[2] in ids and ids.length is 3
          return "radio2"
        else
          return false
      )
  
  radio2: new Step
    number: 3
    header: "Slider Bar"
    details: "To be certain that the radio emission selected is from jet, let’s check the infrared image to identify if there is a source galaxy. Use the slider bar to view the same area of the sky in infrared (IR)."
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
    header: "Selecting the Infrared Source"
    details: "In the infrared (IR) you can see a bright galaxy aligned with the radio contours. It looks like radio emission you selected is consistent with having been ejected from the galaxy."
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
    header: "Selecting the Infrared Source"
    details: "Select the source galaxy by clicking on it."
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
    header: "Great job!"
    details: "You’ve selected radio jet emission and associated it with it’s infrared galactic source."
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
    header: "Single and Multiple Source Radio Emission Examples"
    details: "Radio emissions from jets can look different depending on the orientation of the plane of the galaxy in the sky and the number of radio sources.  Check out these examples (Dialogue box points to examples in classification interface)."
    attachment: "center top .viewport center -0.12"
    onEnter: ->
      disableButtons()
      
      el = angular.element( document.querySelector("button.next-radio") )
      el.removeAttr("disabled")
    onExit: ->
      enableButtons()
    next:
      "click button.next-radio": true
