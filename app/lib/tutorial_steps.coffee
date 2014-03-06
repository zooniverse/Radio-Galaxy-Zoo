Step = zootorial.Step

module.exports =
  id: "rgz-tut"
  firstStep: "welcome"
  length: 13
  steps:    
    welcome: new Step
      number: 1
      header: t7e 'span', 'tutorial.welcome.header'
      details: t7e 'span', 'tutorial.welcome.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "center center .viewport center center"
      next: "wavelengths"

    wavelengths: new Step
      number: 2
      header: t7e 'span', 'tutorial.wavelengths.header'
      details: t7e 'span', 'tutorial.wavelengths.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "center -0.05 .image-opacity center bottom"
      className: "arrow-top"
      next: "classify1"

    classify1: new Step
      number: 3
      header: t7e 'span', 'tutorial.classify1.header'
      details: t7e 'span', 'tutorial.classify1.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "-0.15 0.35 #0.contour-group right center"
      className: "arrow-left"
      next: {'click .done' : 'classify2'}

    classify2: new Step
      number: 4
      header: t7e 'span', 'tutorial.classify2.header'
      details: t7e 'span', 'tutorial.classify2.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "-0.15 0.35 #0.contour-group right center"
      next: {'click svg' : "classify3"}
      className: "arrow-left"

    classify3: new Step
      number: 5
      header: t7e 'span', 'tutorial.classify3.header'
      details: t7e 'span', 'tutorial.classify3.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "right 0.55 .done left center"
      className: "arrow-right"
      next: {'click .done' : "classify4"}

    classify4: new Step
      number: 6
      header: t7e 'span', 'tutorial.classify4.header'
      details: t7e 'span', 'tutorial.classify4.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "left 0.55 .next-radio right center"
      className: "arrow-left"
      next: {
        'click .next-radio' : "classify5"
        'click #1.contour-group' : "classify55"
        'click #3.contour-group' : "classify525"
      }

    classify5: new Step
      number: 7
      header: t7e 'span', 'tutorial.classify5.header'
      details: t7e 'span', 'tutorial.classify5.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "-0.2 0.1 #1.contour-group right center"
      className: "arrow-left"
      next: {'click #1.contour-group' : "classify55"}

    classify525: new Step
      number: 8 
      header: t7e 'span', 'tutorial.classify525.header'
      details: t7e 'span', 'tutorial.classify525.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "-0.2 0.1 #1.contour-group right center"
      className: "arrow-left"
      next: {"click .done" : "classify6"}

    classify55: new Step
      number: 8
      header: t7e 'span', 'tutorial.classify55.header'
      details: t7e 'span', 'tutorial.classify55.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "-0.2 0.1 #3.contour-group right center"
      className: "arrow-left"
      next: {"click .done" : "classify6"}

    classify6: new Step
      number: 9
      header: t7e 'span', 'tutorial.classify6.header'
      details: t7e 'span', 'tutorial.classify6.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "-0.15 0.5 #1.contour-group right center"
      className: "arrow-left"
      next: {'click .done' : "classify8"}

    classify8: new Step
      number: 10
      header: t7e 'span', 'tutorial.classify8.header'
      details: t7e 'span', 'tutorial.classify8.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "right 0.55 .done left center"
      className: "arrow-right"
      next: {'click .done' : 'que'}

    que: new Step
      number: 11
      header: t7e 'span', 'tutorial.que.header'
      details: t7e 'span', 'tutorial.que.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "center top .viewport center bottom"
      next: 'guide'

    guide: new Step
      number: 12
      header: t7e 'span', 'tutorial.guide.header'
      details: t7e 'span', 'tutorial.guide.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "0.35 0.20 .example-selection right center"
      className: "arrow-left"
      next: 'next'

    next: new Step
      number: 13
      header: t7e 'span', 'tutorial.next.header'
      details: t7e 'span', 'tutorial.next.details'
      nextButton: t7e 'span', 'tutorial.nextButton'
      attachment: "right 0.55 .next left center"
      className: "arrow-right"
      next: {"click .next" : null}
