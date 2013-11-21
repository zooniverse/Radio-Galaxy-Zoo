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

module.exports = Classification
