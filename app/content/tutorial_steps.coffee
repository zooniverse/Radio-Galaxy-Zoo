
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
    details: "You're on the hunt for supermassive black holes at the center of galaxies! These black holes emit enormous jets of plasma -- We need your help identifying these jets and also locating the host galaxy (of the black hole) where the jets are coming from.  The tricky part is that the jets are seen at radio wavelengths, whereas the galaxy shines brightly in the infrared, so you'll have to look at both radio and infrared images to do the job."
    attachment: "center center .viewport center center"
    next: "dubstep"
  
  dubstep: new Step
    number: 2
    header: "Welcome to Radio Galaxy Zoo!"
    details: "Each classification you make will take place in two parts -- <b>Observing</b> the radio and infrared images and then <b>Marking</b> the systems you think represent jets and their host galaxies.  Let's try one out."
    attachment: "center center .viewport center center"
    next: "observeradio"
  
  observeradio: new Step
    number: 3
    header: "Observing: Radio Image"
    details: "This is a radio image. The number of contour lines represent the brightness of the radio source, notice the two bright areas of radio emission. We're interested in relatively bright radio features like this one because they're possibly from a jet."
    attachment: "center center .viewport center center"
    next: "observeslider"
  
  observeslider: new Step
    number: 4
    header: "Observing: Slider"
    details: "By panning back and forth between the radio and infrared images with the <b>slider</b>, you'll check whether there is an infrared host galaxy that the jet appears to be originating from. It's good to keep in mind that while jets can be large and extended, the infrared sources will appear relatively small. Switch back and forth and see if you can see the host galaxy."
    attachment: "center center .viewport center center"
    next: "observeir"
  
  observeir: new Step
    number: 5
    header: "Observing: Infrared Image (IR)"
    details: "This is an infrared image. The bright points are mostly galaxies. It looks like there's a bright galaxy in the center of the radio contours. So the radio emission viewed together with this bright infrared source looks consistent  with a jet coming out from the top and bottom half of an edge-on galaxy.<br><br>Now that we've looked at both images, it's time record our observations by marking the radio emission and the IR source galaxy.  Use the slider to switch back to the radio image."
    attachment: "center center .viewport center center"
    next: "markradio1"
  
  markradio1: new Step
    number: 6
    header: "Marking: Radio Image"
    details: "Click on the radio contours to select the two strong areas of radio emission."
    attachment: "center center .viewport center center"
    next: "markradio2"
  
  markradio2: new Step
    number: 7
    header: "Marking: Radio Image"
    details: "Sometimes you'll see isolated faint blue features with one or two contour lines around them. These are mostly background noise and you can ignore them."
    attachment: "center center .viewport center center"
    next: "viewir"
  
  viewir: new Step
    number: 8
    details: "Click Continue to identify the host galaxy in the infrared."
    attachment: "center center .viewport center center"
    next: "markir1"
  
  markir1: new Step
    number: 9
    header: "Marking: Infrared (IR) Image"
    details: "Usually we're interested in the brighter galaxies that align with the radio emission.  There may be lots of faint one that could coincidentally be lined up with the radio emission so focus on the bright ones as much as possible."
    attachment: "center center .viewport center center"
    next: "markir2"
  
  markir2: new Step
    number: 10
    header: "Marking: Infrared (IR) Image"
    details: "Select the source galaxy that you previously observed by clicking on it."
    attachment: "center center .viewport center center"
    next: "goodjob1"
  
  goodjob1: new Step
    number: 11
    header: "Great job!"
    details: "You've selected radio jet emission and associated it with it's infrared galactic source ... possibly identifying a black hole!"
    attachment: "center center .viewport center center"
    next: "goodjob2"
    
  goodjob2: new Step
    number: 12
    header: "Great job!"
    details: "Sources won't all look like the case you just classified. Depending on whether you are viewing the a galaxy edge-on, face-on, or at some in-between angle, you may see a symmetric extended radio source (like the one you just classified), a compact source (where the radio and infrared emission sit on top of each other), or an extended asymmetric radio source. Sometimes you may even see an image with multiple sources! Check out examples of these different types of sources here. We'll also show you additional examples of these types in a bit."
    attachment: "center center .viewport center center"
    next: true
  