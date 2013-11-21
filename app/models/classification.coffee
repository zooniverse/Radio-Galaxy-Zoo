ZooClassification = zooniverse.models.Classification
Subject = zooniverse.models.Subject
User = zooniverse.models.User

class Classification extends Backbone.Model
  defaults: {
    selected_id: 0
    step: 0
  }

  initialize: ->

module.exports = Classification
