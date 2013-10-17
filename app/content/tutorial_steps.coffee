
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

# Higher scope variables to communicate between onEnter and next functions
groupid = null

module.exports =
  length: 2
  
  welcome: new Step
    number: 1
    header: "Welcome to Radio Galaxy Zoo!"
    details: "You're on the hunt for supermassive black holes at the center of galaxies! These black holes emit enormous jets of plasma -- We need your help identifying these jets and also locating the host galaxy (of the black hole) where the jets are coming from.  The tricky part is that the jets are seen at radio wavelengths, whereas the galaxy shines brightly in the infrared, so you'll have to look at both radio and infrared images to do the job."
    attachment: "center center .viewport center center"
    onEnter: ->
      addBlock()
      disableButtons()
    onExit: ->
      removeBlock()
      enableButtons()
    next: "dubstep"
  
  dubstep: new Step
    number: 2
    header: "Welcome to Radio Galaxy Zoo!"
    details: "Each classification you make will take place in two parts -- <b>Observing</b> the radio and infrared images and then <b>Marking</b> the systems you think represent jets and their host galaxies.  Let's try one out."
    attachment: "center center .viewport center center"
    onEnter: ->
      addBlock()
      disableButtons()
    onExit: ->
      removeBlock()
      enableButtons()
    next: "observeradio"
  
  observeradio: new Step
    number: 3
    header: "Observing: Radio Image"
    details: "This is a radio image. The number of contour lines represent the brightness of the radio source, notice the two bright areas of radio emission. We're interested in relatively bright radio features like this one because they're possibly from a jet."
    attachment: "center top .viewport center -0.24"
    className: "arrow-bottom"
    onEnter: ->
      addBlock()
      disableButtons()
    onExit: ->
      removeBlock()
      enableButtons()
    next: "observeslider"
  
  observeslider: new Step
    number: 4
    header: "Observing: Slider"
    details: "By panning back and forth between the radio and infrared images with the <b>slider</b>, you'll check whether there is an infrared host galaxy that the jet appears to be originating from. It's good to keep in mind that while jets can be large and extended, the infrared sources will appear relatively small. Switch back and forth and see if you can see the host galaxy."
    attachment: "right center div.image-slider left center"
    className: "arrow-right"
    onEnter: ->
      addBlock()
      disableButtons()
    onExit: ->
      removeBlock()
      enableButtons()
    next: "observeir"
  
  observeir: new Step
    number: 5
    header: "Observing: Infrared Image (IR)"
    details: "This is an infrared image. The bright points are mostly galaxies. It looks like there's a bright galaxy in the center of the radio contours. So the radio emission viewed together with this bright infrared source looks consistent with a jet coming out from the top and bottom.<br><br>Now that we've looked at both images, it's time record our observations by marking the radio emission and the IR source galaxy.  Use the slider to switch back to the radio image."
    attachment: "center top .viewport center -0.24"
    onEnter: ->
      addBlock()
      disableButtons()
      
      document.querySelector("p[data-band='infrared']").click()
      document.querySelector("span.toggle-contours").click()
    onExit: ->
      removeBlock()
      enableButtons()
      
      document.querySelector("p[data-band='radio']").click()
      document.querySelector("span.toggle-contours").click()
    next: "markradio1"
  
  markradio1: new Step
    number: 6
    header: "Marking: Radio Image"
    details: "Click on the radio contours to select areas of radio emission."
    attachment: "center top .viewport center -0.24"
    className: "arrow-bottom"
    onEnter: ->
      addBlock()
      disableButtons()
      
      # Determine the center contour group
      groups = d3.selectAll("g.contour-group")[0]
      for group in groups
        bbox = group.getBBox()
        y = bbox.y + 0.5 * bbox.height
        break if y < 196 and y > 192
      
      group = d3.select(group)
      groupid = group.attr("id")
      group.classed("pulsate", true)
      setTimeout (->
        group.classed("pulsate", false)
        removeBlock()
      ), 2500
      
    onExit: ->
      removeBlock()
      enableButtons()
    next:
      "click #svg-contours": (e) ->
        if e.target.parentNode?.id is groupid
          return "markradio2"
        return false
  
  markradio2: new Step
    number: 7
    header: "Marking: Radio Image"
    details: "Sometimes you'll see isolated faint blue features with one or two contour lines around them. These are mostly background noise and you can ignore them.<br><br>Click <b>Continue</b> to identify the host galaxy in the infrared."
    attachment: "center top .viewport center -0.24"
    onEnter: ->
      addBlock()
    onExit: ->
      removeBlock()
    next:
      "click button.continue": "markir1"
  
  markir1: new Step
    number: 9
    header: "Marking: Infrared (IR) Image"
    details: "Usually we're interested in the brighter galaxies that align with the radio emission.  There may be lots of faint one that could coincidentally be lined up with the radio emission so focus on the bright ones as much as possible."
    attachment: "center top .viewport center -0.24"
    onEnter: ->
      addBlock()
      disableButtons()
    onExit: ->
      removeBlock()
      enableButtons()
    next: "markir2"
  
  markir2: new Step
    number: 10
    header: "Marking: Infrared (IR) Image"
    details: "Select the source galaxy that you previously observed by clicking on it."
    attachment: "center top .viewport center -0.24"
    onEnter: ->
      addBlock()
      disableButtons()
      
      svg = d3.select(".svg-contours")
      circle = svg.append("circle")
        .attr("class", "tutorial pulsate-and-hide")
        .attr("r", 10)
        .attr("cx", 213)
        .attr("cy", 211)
      
      setTimeout ( ->
        circle.remove()
        removeBlock()
      ), 2000
      
    onExit: ->
      removeBlock()
      enableButtons()
    next:
      "click #svg-contours": (e) ->
        
        # Select the annotation
        circle = d3.select("g.infrared circle")
        circleGroup = d3.select( circle.node().parentNode )
        
        transform = circleGroup.attr("transform")
        translateRegEx = /translate\((-?\d+), (-?\d+)\)/
        match = transform.match(translateRegEx)
        
        cx = parseInt match[1]
        cy = parseInt match[2]
        if cx < 223 and cx > 203 and cy < 221 and cy > 201
          return "goodjob1"
        return false
  
  goodjob1: new Step
    number: 11
    header: "Great job!"
    details: "You've selected a radio jet emission and associated it with it's infrared galactic source ... possibly identifying a black hole!"
    attachment: "center top .viewport center -0.24"
    onEnter: ->
      addBlock()
      disableButtons()
    onExit: ->
      removeBlock()
      enableButtons()
    next: "goodjob2"
    
  goodjob2: new Step
    number: 12
    header: "Great job!"
    details: "Sources won't all look like the case you just classified. Depending on whether you are viewing the a galaxy edge-on, face-on, or at some in-between angle, you may see a symmetric extended radio source (like the one you just classified), a compact source (where the radio and infrared emission sit on top of each other), or an extended asymmetric radio source. Sometimes you may even see an image with multiple sources! Check out examples of these different types of sources here. We'll also show you additional examples of these types in a bit.<br><br>Click <b>Done</b> to begin!"
    attachment: "center center .viewport center center"
    onEnter: ->
      addBlock()
      disableButtons()
      
      # Enable Done button
      el = angular.element( document.querySelector("button.done") )
      el.removeAttr("disabled")
      
    onExit: ->
      removeBlock()
      enableButtons()
    next:
      "click button.done": true
  