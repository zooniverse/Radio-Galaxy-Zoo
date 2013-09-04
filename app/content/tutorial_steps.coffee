
Step = zootorial.Step


module.exports =
  length: 2
  
  welcome: new Step
    number: 1
    header: "Welcome to Radio Galaxy Zoo!"
    details: "what what"
    attachment: "center center .viewport center center"
    # block: '.annotation, .controls:first'
    next: "complete"
    
  complete: new Step
    number: 2
    header: "Awesome Job!"
    details: "whta what"
    attachment: "center center .viewport center center"