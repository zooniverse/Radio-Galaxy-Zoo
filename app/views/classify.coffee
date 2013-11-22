Subject = zooniverse.models.Subject
User = zooniverse.models.User

Section = require('./section_view')
Steps = require('./steps')
Classifier = require('./classifier')
Guide = require('./guide')

Model = require('models/classification')

tutorialSubject = require('lib/tutorial_subject')
tutorialSteps = require('lib/tutorial_steps')

class Classify extends Section
  el: "#classify"

  events: {
    'input input.image-opacity' : 'updateOpacity'
    'change input.image-opacity' : 'updateOpacity'
    'click .band' : 'setBand'
    'click .toggle-contours' : 'toggleContours'
    'click .done' : 'nextStep'
    'click .cancel' : 'prevStep'
    'click .no-contours' : 'end'
    'click .no-infrared' : 'nextStep'
    'click .next-radio' : 'begin'
    'click .next' : 'nextSubject'
    'click .tutorial' : 'startTutorial'
  }

  initialize: ->
    User.on('change', @userChange)
    Subject.on('select', @loadSubject)
    @slider = @$('input.image-opacity')
    @slider.val(0)
    @guide = new Guide()

  loadSubject: =>
    @stopListening(@model)
    @model = new Model({subject: Subject.current})
    @listenTo(@model, 'change:ir_opacity', @setSlider)
    
    if @steps? and @classifier?
      @steps.undelegateEvents()
      @steps.reset()
      @classifier.undelegateEvents() 
      @classifier.emptySVG()

      delete @steps
      delete @classifier

    @steps = new Steps({model: @model})
    @classifier = new Classifier({model: @model})

  userChange: =>
    if User.current
      Subject.next()
    else
      @startTutorial() if @isVisible() and not @tut?

  startTutorial: ->
    unless Subject.current?.tutorial
      Subject.current = new Subject(tutorialSubject)
      @loadSubject()
    @tut = new zootorial.Tutorial(tutorialSteps)
    @tut.el.bind('end-tutorial', @endTutorial)
    @tut.start()

  endTutorial: =>
    delete @tut
    if User.current
      User.current.setPreference('tutorial_done', true)

  show: ->
    super
    _.defer(@userChange)

  updateOpacity: (ev) ->
    @$('img.infrared').addClass("no-transition")
    @model.set('ir_opacity', parseFloat(@slider.val()))
    if ev.type is 'change'
      @$('img.infrared').removeClass("no-transition")

  setBand: (ev) ->
    opacity = if ev.target.dataset.band is 'radio' then 0 else 1
    @model.set('ir_opacity', opacity)

  setSlider: (m, opacity) ->
    @slider.val(opacity)

  toggleContours: ->
    @$('div.contours').toggleClass('fade-contour')
    @$('.toggle-contours').toggleClass('nocontours')

  nextStep: ->
    @model.next()

  prevStep: ->
    @model.prev()

  end: -> 
    @model.set('step', 3)

  begin: ->
    @model.set('step', 0)

  nextSubject: ->
    Subject.next()

module.exports = Classify
