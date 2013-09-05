
Step = zootorial.Step


module.exports =
  length: 2
  
  welcome: new Step
    number: 1
    header: "Welcome to Radio Galaxy Zoo!"
    details: "We need your help cross-matching radio sources with their infrared counterpart."
    attachment: "center center .viewport center center"
    # block: '.annotation, .controls:first'
    next: "radio"
  
  radio: new Step
    number: 2
    header: "Radio Emissions"
    details: "This image show multiple radio emissions. The two leftmost blobs are emissions from a single galaxy. The galaxy is emits powerful jets that are observed in the radio wavelength."
    attachment: "center center .viewport center left"
    onEnter: ->
      console.log 'WHAT WHAT WHAT ON ENTER'
      for id in ["26", "27"]
        el = d3.select("path[contourid='#{id}']")
        console.log el
        el.attr("class", "svg-contour radiate")
      
    next: "complete"
  
  complete: new Step
    number: 2
    header: "Awesome Job!"
    details: "whta what"
    attachment: "center center .viewport center center"