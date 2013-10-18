
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
checkState = null

module.exports =
  stage1:
    length: 12
    
    welcome: new Step
      number: 1
      header: "Welcome to Radio Galaxy Zoo!"
      details: "You're on the hunt for supermassive black holes at the center of galaxies! These black holes emit enormous jets of plasma -- We need your help identifying these jets and also locating the host galaxy (of the black hole) where the jets are coming from. The tricky part is that the jets are seen at radio wavelengths, whereas the galaxy shines brightly in the infrared, so you'll have to look at both radio and infrared images to do the job."
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
      details: "Each classification you make will take place in two parts - <b>Observing</b> the radio and infrared images and then <b>Marking</b> any system you think represents jets and their host galaxy. Let's try one out."
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
      details: "This is a radio image. The number of contour lines represent the brightness of the radio source, notice the two bright areas of radio emission. We're interested in relatively bright radio features like this one because they're possibly from jets."
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
      details: "By panning back and forth between the radio and infrared images with the <b>slider</b>, you'll check whether there is an infrared host galaxy where the jets appear to originate. Keep in mind that while jets can be large and extended, the infrared sources will appear relatively small."
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
      details: "This is an infrared image. The bright points are mostly galaxies. The host galaxy you're looking for is usually off to one side. In this case between the 2 radio components. The radio emission you just viewed combined with the bright infrared source in the middle looks consistent with a picture of twin jets skyrocketing out of a central galaxy.<br><br>Now that we've looked at both images, it's time to record our observations by marking the radio emission and the IR source galaxy. Use the slider to switch back to the radio image."
      attachment: "center top .viewport center -0.24"
      onEnter: ->
        addBlock()
        disableButtons()
        
        document.querySelector("p[data-band='infrared']").click()
      onExit: ->
        removeBlock()
        enableButtons()
        
        document.querySelector("p[data-band='radio']").click()
      next: "markradio1"
      
    markradio1: new Step
      number: 6
      header: "Marking: Radio Image"
      details: "You should mark all the radio emission originating from a single galaxy before marking the corresponding IR galaxy. Click on the radio contours to select the two strong areas of radio emission."
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
      details: "Usually we're interested in the brighter galaxies that align with the radio emission. There may be lots of faint ones that could coincidentally be lined up with the radio emission so focus on the bright ones as much as possible."
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
      details: "You identified the galaxy whose supermassive black hole is responsible for these radio jets!"
      attachment: "center top .viewport center -0.24"
      onEnter: ->
        addBlock()
        disableButtons()
      onExit: ->
        removeBlock()
        enableButtons()
      next: "moreexamples"
    
    moreexamples: new Step
      number: 12
      header: "More Examples"
      details: "Sources won't all look like the case you have just classified. You may see disconnected radio jet components, single compact radio or massive extended / lop-sided radio jets.<br><br>With disconnected radio jet components, remember to click on all the radio components that match up to a single galaxy before marking the IR galaxy.<br><br>Sometimes you may even see an image with multiple galaxies emitting radio jets! Check out examples of these different types of sources in the tabs on the right.<br><br>We'll show you a couple of detailed examples, but first try one classification on your own.<br><br>Click <b>Done</b> to start!"
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
  
  stage2:
    length: 7
    
    goodjob: new Step
      number: 1
      details: "Good job! Now let's take a look at another source type."
      attachment: "center center .viewport center center"
      onEnter: ->
        addBlock()
        disableButtons()
      onExit: ->
        removeBlock()
        enableButtons()
      next: "observeradio"
    
    observeradio: new Step
      number: 2
      header: "Observing: Radio Image"
      details: "Sometimes you'll see radio sources that look like this. This is an example of a <b>single compact source</b>. We've visually confirmed a potential radio emission, time to observe the infrared image. Use the slider to pan to the IR image."
      attachment: "center top .viewport center -0.24"
      onEnter: ->
        addBlock()
        disableButtons()
      onExit: ->
        removeBlock()
        enableButtons()
      next:
        "change input.image-opacity": (e, el) ->
          if parseFloat(el.value) > 0.85
            return "observeir"
          return false
    
    observeir: new Step
      number: 3
      header: "Observing: Infrared (IR) Image"
      details: "It looks like there is an infrared source (a galaxy) at the center of the radio emission. Both the infrared and radio emission are likely to come from the same object!<br><br><b>Move</b> the slider back to the radio source and <b>click</b> on it to mark it.<br><br>Click <b>Continue</b> to find the infrared source."
      attachment: "center top .viewport center -0.24"
      onEnter: ->
        disableButtons()
        
        # Determine the center contour group
        groups = d3.selectAll("g.contour-group")[0]
        for group in groups
          bbox = group.getBBox()
          x = bbox.x + 0.5 * bbox.width
          break if x < 218 and x > 213
          
        group = d3.select(group)
        groupid = group.attr("id")
        
        imgOpacityEl = $("input.image-opacity")
        el = $("#svg-contours")
        buttonEl = document.querySelector("button.continue")
        buttonEl = angular.element(buttonEl)
        
        checkState = ->
          console.log 'checkState'
          if group.attr("class").indexOf("selected") > -1 and parseFloat( imgOpacityEl.val() ) < 0.25
            buttonEl.removeAttr("disabled")
          else
            disableButtons()
        
        el.on("click", checkState)
        imgOpacityEl.on("change", checkState)
        
      onExit: ->
        enableButtons()
        
        $("#svg-contours").off("click", checkState)
        $("input.image-opacity").off("change", checkState)
      next:
        "click button.continue": "markir"
    
    markir: new Step
      number: 5
      header: "Marking Infrared (IR)"
      details: "Click on the bright source galaxy that you already spotted."
      attachment: "center top .viewport center -0.24"
      onEnter: ->
        addBlock()
        disableButtons()
        
        svg = d3.select(".svg-contours")
        circle = svg.append("circle")
          .attr("class", "tutorial pulsate-and-hide")
          .attr("r", 10)
          .attr("cx", 212)
          .attr("cy", 210)
        
        setTimeout ( ->
          circle.remove()
          removeBlock()
        ), 2000
      onExit: ->
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
          if cx < 222 and cx > 202 and cy < 220 and cy > 200
            return "done"
          return false
      
    done: new Step
      number: 6
      details: "Great, now <b>click</b> Done to try another one."
      attachment: "center top .viewport center -0.24"
      onEnter: ->
        addBlock()
      onExit: ->
        removeBlock()
      next:
        "click button.done": true
  
  stage3:
    length: 8
    
    multiplesources: new Step
      number: 1
      header: "Multiple Sources"
      details: "You're doing great! Occasionally you might run into tricky images like this. There are two radio signals you might think come from twin jets like our first classification, but just to be sure we better pan to the IR."
      attachment: "center center .viewport center center"
      onEnter: ->
        addBlock()
        disableButtons()
      onExit: ->
        removeBlock()
        enableButtons()
      next: "observemultiples"
    
    observemultiples: new Step
      number: 2
      header: "Observing Multiple Sources"
      details: "In the IR it appears that both of those radio signals has an infrared galaxy counterpart near the peak the radio contours. So in this case instead of seeing twin jet emission you are really just seeing two compact sources."
      attachment: "center center .viewport center center"
      onEnter: ->
        addBlock()
        disableButtons()
      onExit: ->
        removeBlock()
        enableButtons()
      next: "firstsource1"
    
    firstsource1: new Step
      number: 3
      header: "Marking the First Source"
      details: "If you see multiple sources always mark the first in radio and IR and then go back and do the other. Select one of the radio sources."
      attachment: "center center .viewport center center"
      onEnter: ->
        addBlock()
        disableButtons()
      onExit: ->
        removeBlock()
        enableButtons()
      next: "firstsource2"
    
    firstsource2: new Step
      number: 4
      header: "Marking the First Source"
      details: "Now slide to the IR image and select the host galaxy of this radio emission."
      attachment: "center center .viewport center center"
      onEnter: ->
        addBlock()
        disableButtons()
      onExit: ->
        removeBlock()
        enableButtons()
      next: "secondsource1"
    
    secondsource1: new Step
      number: 5
      header: "Marking the Second Source"
      details: "Click on Select Another Radio Complex button to indicate that there is a separate and distinct source."
      attachment: "center center .viewport center center"
      onEnter: ->
        addBlock()
        disableButtons()
      onExit: ->
        removeBlock()
        enableButtons()
      next: "secondsource2"
    
    secondsource2: new Step
      number: 6
      header: "Marking the Second Source"
      details: "Mark the second radio source."
      attachment: "center center .viewport center center"
      onEnter: ->
        addBlock()
        disableButtons()
      onExit: ->
        removeBlock()
        enableButtons()
      next: "secondsource3"
    
    secondsource3: new Step
      number: 7
      header: "Marking the Second Source"
      details: "And now mark the host galaxy in the infrared image."
      attachment: "center center .viewport center center"
      onEnter: ->
        addBlock()
        disableButtons()
      onExit: ->
        removeBlock()
        enableButtons()
      next: "done"
    
    done: new Step
      number: 8
      header: "Congratulations!"
      details: "You're fully trained to search for black holes!  Remember you can check out example images on the right and find even more in Talk!"
      attachment: "center center .viewport center center"
      onEnter: ->
        addBlock()
        disableButtons()
      onExit: ->
        removeBlock()
        enableButtons()
      next: true