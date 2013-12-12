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
    'click .keyboard' : 'toggleKeyboardGuide'
  }

  keyboardEvents: {
    'space' : 'nextStep'
    'shift+space' : 'prevStep'
    'c' : 'toggleContours'
    't' : 'startTutorial'
    'r' : 'setBand'
  }

  initialize: ->
    User.on('change', @userChange)
    Subject.on('select', => @loadSubject())
    @slider = @$('input.image-opacity')
    @slider.val(0.5)
    @guide = new Guide()

  loadSubject: (sub) =>
    @stopListening(@model)
    if sub?
      @model = new Model({subject: sub})
    else
      @model = @next or new Model({subject: Subject.current})
    @next = new Model({subject: Subject.instances[1]}) if Subject.instances[1]?
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
    @slider.val(0.5)

  userChange: =>
    if User.current? and User.current.project?.tutorial_done
      Subject.next()
    else
      @startTutorial() if @isVisible() and not @tut?

  startTutorial: ->
    unless Subject.current?.tutorial
      @loadSubject(new Subject(tutorialSubject))
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

  hide: ->
    super
    @tut.end() if @tut?

  updateOpacity: (ev) ->
    @$('img.infrared').addClass("no-transition")
    @model.set('ir_opacity', parseFloat(@slider.val()))
    if ev.type is 'change'
      @$('img.infrared').removeClass("no-transition")

  setBand: (ev, key) ->
    if key?
      opacity = if @model.get('ir_opacity') is 1 then 0 else 1
    else
      opacity = if ev.target.dataset.band is 'radio' then 0 else 1
    @model.set('ir_opacity', opacity)

  setSlider: (m, opacity) ->
    @slider.val(opacity)

  toggleContours: ->
    @$('div.contours').toggleClass('fade-contour')
    @$('.toggle-contours').toggleClass('nocontours')

  nextStep: ->
    return if _.isEmpty(@model.get('selected_contours'))
    @model.next()

  prevStep: ->
    return if _.isEmpty(@model.get('selected_contours'))
    @model.prev()

  end: -> 
    @model.set('step', 3)

  begin: ->
    @model.set('step', 0)

  nextSubject: ->
    Subject.next()

  toggleKeyboardGuide: ->
    @keyboardButton or= @$('.keyboard')
    @keyboardButton.toggleClass('active')

    @keyboardModal or= @$('.keyboard-modal')
    @keyboardModal.toggleClass('active')


module.exports = Classify
