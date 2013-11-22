ZooClassification = zooniverse.models.Classification
Subject = zooniverse.models.Subject
User = zooniverse.models.User

class Classification extends Backbone.Model
  defaults: {
    selected_contours: []
    matched_contours: []
    step: 0
    ir_opacity: 0
    ir_markings: []
    ir_matched: []
  }

  initialize: ->
    @classification = new ZooClassification({subject: @get('subject')})
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

  matchContours: ->
    contour_ids = _.clone(@get('selected_contours'))
    sources = _.clone(@get('ir_markings'))
    @set({
      ir_matched: sources.concat(@get("ir_matched"))
      matched_contours: contour_ids.concat(@get('matched_contours'))
      selected_contours: []
      ir_markings: []
    })
    bboxes = _.chain(contour_ids)
        .map((cid) => @get('contours')[cid][0].bbox)
        .map((bb) -> _.object(['xmax', 'ymax', 'xmin', 'ymin'], bb))
        .value()
    @classification.annotate({
      radio: if _.isEmpty(bboxes) then "No Contours" else bboxes
      ir: if _.isEmpty(sources) then "No Sources" else sources
    })

  next: ->
    step = @get('step') + 1
    @set('step', step)

  prev: ->
    step = @get('step') - 1
    @set('step', step)

  stateDispatch: (m, step) ->
    @["step#{step}"]()

  step0: ->
    @set('selected_contours', [])
    @set('ir_opacity', 0)

  step1: ->
    @set('ir_markings', [])
    @set('ir_opacity', 1)

  step2: ->
    @matchContours()

  step3: ->
    @classification.send()

module.exports = Classification
