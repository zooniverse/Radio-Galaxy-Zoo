ZooClassification = zooniverse.models.Classification
Subject = zooniverse.models.Subject
User = zooniverse.models.User

class Classification extends Backbone.Model
  defaults: {
    selected_contours: []
    matched_contours: []
    step: 0
    ir_opacity: 0.5
    ir_markings: []
    ir_matched: []
  }

  initialize: ->
    @classification = new ZooClassification({subject: @get('subject')})

    @loadContours()
    @loadImages()

    @listenTo(@, 'change:step', @stateDispatch)

  irImage: ->
    @irImg or= new Image()
    @irImg.src or= @get('subject').location.standard
    return @irImg.src

  radioImage: ->
    @rImg or= new Image()
    @rImg.src or= @get('subject').location.radio
    return @rImg.src

  loadImages: ->
    @irImage()
    @radioImage()

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
    if step > 3
      throw new Error("Cannot step past 3")
    @set('step', step)

  prev: ->
    step = @get('step') - 1
    if step == -1
      @step0()
    else
      @set('step', step)

  stateDispatch: (m, step) ->
    @["step#{step}"]()

  step0: ->
    @set('selected_contours', [])
    @set('ir_markings', [])
    @set('ir_opacity', 0.5)

  step1: ->
    xsIR = _.pluck(@get('ir_markings'), 'x')
    ysIR = _.pluck(@get('ir_markings'), 'y')
    @set("matched_contours", _.difference(@get("matched_contours"), @get("selected_contours")))
    @set("ir_matched", _.filter(@get("ir_matched"), (m) -> not (m.x in xsIR and m.y in ysIR)))
    @set('ir_markings', [])
    @set('ir_opacity', 1)

  step2: ->
    @matchContours()

  step3: ->
    @set('selected_contours', [])
    @set('ir_markings', [])

  toggleFavorite: ->
    @classification.favorite = not @classification.favorite

module.exports = Classification
