ZooClassification = zooniverse.models.Classification
Subject = zooniverse.models.Subject
User = zooniverse.models.User

class Classification extends Backbone.Model
  defaults: {
    selected_id: 0
    step: 0
    ir_opacity: 0
  }

  initialize: ->
    @contours = @loadContours()

  irImage: ->
    @get('subject').location.standard

  radioImage: ->
    @get('subject').location.radio

  loadContours: ->
    $.get(@get('subject').location.contours)

module.exports = Classification
