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
    'click .favorite' : 'favoriteSubject'
  }

  keyboardEvents: {
    'space' : 'nextStep'
    'shift+space' : 'prevStep'
    'c' : 'toggleContours'
    't' : 'startTutorial'
    'r' : 'setBand'
    'n' : 'nextStep'
  }

  initialize: ->
    @unseen = true 
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
    Subject.instances.pop()
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
    if User.current? and User.current.preferences?.radio?.tutorial_done
      if @tut
        @tut.end()
      Subject.next()
    else
      @startTutorial() if @isVisible() and not @tut?

  startTutorial: ->
    unless Subject.current?.tutorial
      @loadSubject(new Subject(tutorialSubject))
    unless @tut?
      @tut = new zootorial.Tutorial(tutorialSteps)
      @tut.el.bind('end-tutorial', @endTutorial)
      @tut.start()

  endTutorial: =>
    delete @tut
    @unseen = false
    if User.current
      User.current.setPreference('tutorial_done', true)

  show: ->
    super
    _.defer(@userChange) if @unseen and not User.current?

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

  nextStep: (ev, key) ->
    return if _.isEmpty(@model.get('selected_contours')) and not key?

    console.log(key, @model.get('step'))
    if key is 'space' and @model.get('step') is 3
      @nextSubject()
    else if key is 'n' and @model.get('step') is 0
      @end()
    else
      @model.next()

  prevStep: ->
    return if _.isEmpty(@model.get('selected_contours'))
    @model.prev()

  end: -> 
    @model.set('step', 3)

  begin: ->
    @model.set('step', 0)

  nextSubject: ->
    @$('.favorite').removeClass('active')
    @model.classification.send()
    Subject.next()

  toggleKeyboardGuide: ->
    @keyboardButton or= @$('.keyboard')
    @keyboardButton.toggleClass('active')

    @keyboardModal or= @$('.keyboard-modal')
    @keyboardModal.toggleClass('active')

  favoriteSubject: ->
    @model.toggleFavorite()
    @$('.favorite').toggleClass('active')

module.exports = Classify
