ZooClassification = zooniverse.models.Classification
Subject = zooniverse.models.Subject
User = zooniverse.models.User

class Classification extends Backbone.Model
  defaults: {
    selected_contours: []
    step: 0
    ir_opacity: 0
  }

  initialize: ->
    @loadContours()
    @listenTo(@, 'change:step', @stateDispatch)

  irImage: ->
    @get('subject').location.standard

  radioImage: ->
    @get('subject').location.radio

  loadContours: ->
    $.get(@get('subject').location.contours).then((response) =>
      @set('contours', response))

  selectContour: (id) ->
    selected = @get('selected_contours')
    if id in selected
      @set('selected_contours', _.without(selected, id))
    else
      @set('selected_contours', selected.concat(id))

  next: ->
    step = @get('step') + 1
    console.log(step)
    @set('step', step)

  prev: ->
    step = @get('step') - 1
    @set('step', step)

  stateDispatch: (m, step) ->
    @["step#{step}"]()

  step0: ->
    console.log('here')

  step1: ->
    console.log('here')

  step2: ->
    console.log('here')

  step3: ->
    console.log('here')


module.exports = Classification
