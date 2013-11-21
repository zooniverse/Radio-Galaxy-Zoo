Subject = zooniverse.models.Subject
User = zooniverse.models.User

Section = require('./section_view')
Steps = require('./steps')
Classifier = require('./classifier')

Model = require('models/classification')

tutorialSubject = require('lib/tutorial_subject')

class Classify extends Section
  el: "#classify"

  initialize: ->
    User.on('change', @userChange)
    Subject.on('select', @loadSubject)

  loadSubject: =>
    console.log('here')
    @model = new Model({subject: Subject.current})
    
    if @steps? and @classifier?
      @steps.undelegateEvents()
      @classifier.undelegateEvents() 

      delete @steps
      delete @classifier

    @steps = new Steps({model: @model})
    @classifier = new Classifier({model: @model})

  userChange: =>
    if User.current
      Subject.next()
    else
      Subject.current = new Subject(tutorialSubject)
      @loadSubject()
      @startTutorial() if @isVisible() and not @tut?

  startTutorial: ->
    @tut = true

  show: ->
    super
    _.defer(@userChange)

module.exports = Classify
