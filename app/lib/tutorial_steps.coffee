Step = zootorial.Step

module.exports =
  id: "rgz-tut"
  firstStep: "welcome"
  length: 13
  steps:    
    welcome: new Step
      number: 1
      header: "Welcome to Radio Galaxy Zoo!"
      details: "We’re going to show you two images of the same part of the sky, one from a radio telescope and one from an infrared telescope. \n \n In most images there are many infrared galaxies, but only some of these appear in the radio."
      attachment: "center center .viewport center center"
      next: "wavelengths"

    wavelengths: new Step
      number: 2
      header: "Different Wavelengths"
      details: "Here are two galaxies seen at radio wavelengths - one small one lower down and one large, double-lobed object in the centre. We use contours to show their radio brightness. \n \n To see how the galaxies appear in the infrared, move the slider over to the IR position. The goal is to match up the radio contours to their galaxy images in the IR."
      attachment: "center -0.05 .image-opacity center bottom"
      className: "arrow-top"
      next: "classify1"

    classify1: new Step
      number: 3
      header: "Pairing the Data"
      details: "Let’s do the easy galaxy first: pick the smaller object by clicking on its contours then click 'Done'."
      attachment: "-0.15 0.35 #0.contour-group right center"
      className: "arrow-left"
      next: {'click .done' : 'classify2'}

    classify2: new Step
      number: 4
      header: "Pairing the Data"
      details: "Select it in the infrared too. Use the slider to compare the two. In this case the galaxy is at exactly the same position in both wavelengths."
      attachment: "-0.15 0.35 #0.contour-group right center"
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
      header: "Pairing a Second Source."
      details: "Now let's mark the other Galaxy. First select 'Mark Another'."
      attachment: "left 0.55 .next-radio right center"
      className: "arrow-left"
      next: {
        'click .next-radio' : "classify5"
        'click #1.contour-group' : "classify5"
      }

    classify5: new Step
      number: 7
      header: "Pairing a Second Source."
      details: "Then click on the first contour of the brighter Galaxy." 
      attachment: "-0.2 0.1 #1.contour-group right center"
      className: "arrow-left"
      next: {'click #1.contour-group' : "classify55"}

    classify55: new Step
      number: 8
      header: "Pairing a Second Source."
      details: "Next click on the second contour of the Galaxy. Then click on 'Done'."
      attachment: "-0.2 0.1 #3.contour-group right center"
      className: "arrow-left"
      next: {"click .done" : "classify6"}

    classify6: new Step
      number: 9
      header: "Pairing Second Source."
      details: "When you check the infrared you’ll see a galaxy between the two bright radio ‘lobes’. Click that galaxy and select 'Done'."
      attachment: "-0.15 0.5 #1.contour-group right center"
      className: "arrow-left"
      next: {'click .done' : "classify8"}

    classify8: new Step
      number: 10
      header: "Finish Marking."
      details: "That's all the pairs in this image. Click 'Finish' to advance."
      attachment: "right 0.55 .done left center"
      className: "arrow-right"
      next: {'click .done' : 'que'}

    que: new Step
      number: 11
      header: "What's Going on?"
      details: "The large, bright radio object shows us where two jets were emitted by a supermassive black hole at center of that galaxy. The fainter radio object shows emission from newly-formed stars in the galaxy." 
      attachment: "center top .viewport center bottom"
      next: 'guide'

    guide: new Step
      number: 12
      header: "More Objects"
      details: "You can see many more examples in the ‘Guide’, showing how the science team marked more complex objects."
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