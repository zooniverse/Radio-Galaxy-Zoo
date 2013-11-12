
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
  #  els.attr("disabled", "disabled")

# Higher scope variables to communicate between onEnter and next functions
groupid = null
checkState = null

module.exports =
  stage1:
    length: 13
    
    welcome: new Step
      number: 1
      header: "Welcome to Radio Galaxy Zoo!"
      details: "We’re going to show you two images of the same part of the sky, one from a radio telescope and one from an infrared telescope. Most contain galaxies that will show in the infrared (IR), but only some galaxies appear in the radio." 
      attachment: "center center .viewport center center"
      next: "wavelengths"

    wavelengths: new Step
      number: 2
      header: "Different Wavelengths"
      details: "Here are two galaxies seen at radio wavelengths - we use contours to show their radio brightness. To see how the galaxies appear in the infrared, move the slider over to the IR position. The goal is to match up the radio contours to their galaxy images in the IR."
      attachment: "center -0.05 .image-opacity center bottom"
      className: "arrow-top"
      next: "classify1"

    classify1: new Step
      number: 3
      header: "Paring the Data"
      details: "Let’s do the easy galaxy first: pick the smaller object by clicking on its contours."
      attachment: "-0.15 0.35 #2.contour-group right center"
      className: "arrow-left"
      next: {'click #2.contour-group' : 'classify2'}

    classify2: new Step
      number: 4
      header: "Pairing the Data"
      details: "Now select it in the infrared too. Use the slider to compare the two. In this case the galaxy is at exactly the same position in both wavelengths."
      attachment: "-0.15 0.35 #2.contour-group right center"
      next: {'click svg' : "classify3"}
      className: "arrow-left"

    classify3: new Step
      number: 5
      header: "Pairing the Data"
      details: "Now click 'Done'"
      attachment: "right 0.55 .done left center"
      className: "arrow-right"
      next: {'click .done' : "classify4"}

    classify4: new Step
      number: 6
      header: "Pairing the Data"
      details: "Now let's mark the other Galaxy. First select 'Mark Another Source'"
      attachment: "left 0.65 .next-radio right center"
      className: "arrow-left"
      next: {'click .next-radio' : "classify5"}

    classify5: new Step
      number: 7
      header: "Pairing the Data"
      details: "Now let’s click the contours of the brighter galaxy" 
      attachment: "-0.4 -0.5 #1.contour-group right center"
      className: "arrow-left"
      next: {'click #1.contour-group' : "classify6"}

    classify6: new Step
      number: 8
      header: "Pairing the Data"
      details: "When you check the infrared you’ll see a galaxy between the two bright radio ‘lobes’."
      attachment: "-0.4 -0.5 #1.contour-group right center"
      className: "arrow-left"
      next: {'click svg' : "classify7"}

    classify7: new Step
      number: 9
      header: "Pairing the Data"
      details: "Click the object and select 'Done'"
      attachment: "right 0.55 .done left center"
      className: "arrow-right"
      next: {'click .done' : "classify8"}

    classify8: new Step
      number: 10
      header: "Pairing the Data"
      details: "That's all the pairs in this image. Click 'Finish' to advance."
      attachment: "right 0.55 .done left center"
      className: "arrow-right"
      next: {'click .done' : 'que'}

    que: new Step
      number: 11
      header: "What's Going on?"
      details: "The fainter radio object shows emission from newly-formed stars in the galaxy. The bright radio object shows us two jets emitted by a supermassive black hole at center of that galaxy -- but we can only see the central galaxy in the infrared. \n \n This is why we need your help to match these objects."
      attachment: "center center .viewport center center"
      next: 'guide'

    guide: new Step
      number: 12
      header: "More Objects"
      details: "This single contour is an object you don’t need to identify as it’s too faint. \n \n You can see many more examples in the ‘Guide’, showing how the science team marked more complex objects."
      attachment: "0.35 0.20 .example-selection right center"
      className: "arrow-left"
      next: 'next'

    next: new Step
      number: 13
      header: "Next"
      details: "You can favourite images to see again later, or discuss images with the community on our forum, Talk. \n \n Click ‘Next’ to move on to the next image. "
      attachment: "right 0.55 .next left center"
      className: "arrow-right"
      next: {"click .next" : null}