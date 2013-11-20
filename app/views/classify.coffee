Section = require('./section_view')
Steps = require('./steps')

Model = require('models/classification')

class Classify extends Section
  el: "#classify"

  initialize: ->
    @steps = new Steps()

module.exports = Classify
