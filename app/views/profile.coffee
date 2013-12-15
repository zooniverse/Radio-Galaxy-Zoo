Section = require('./section_view')

class Profile extends Section
  el: "#profile"

  content: new zooniverse.controllers.Profile().el

  show: ->
    super
    @$el.html(@content)

module.exports = Profile
