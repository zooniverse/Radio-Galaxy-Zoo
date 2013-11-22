ZooClassification = zooniverse.models.Classification
Subject = zooniverse.models.Subject
User = zooniverse.models.User

class Classification extends Backbone.Model
  defaults: {
    selected_contours: []
    step: 0
    ir_opacity: 0
    ir_markings: []
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

  addMarking: ([x, y]) -> 
    @set('ir_markings', @get('ir_markings').concat({x: x, y: y}))

  removeMarking: ({x, y}) ->
    @set('ir_markings', _.filter(@get('ir_markings'), (m) -> not (m.x == x and m.y == y)))

  next: ->
    step = @get('step') + 1
    @set('step', step)

  prev: ->
    step = @get('step') - 1
    @set('step', step)

  stateDispatch: (m, step) ->
    @["step#{step}"]()

  step0: ->
    console.log('here')

  step1: ->
    @set('ir_opacity', 1)

  step2: ->
    console.log('here')

  step3: ->
    console.log('here')


module.exports = Classification
