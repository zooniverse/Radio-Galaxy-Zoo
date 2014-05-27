Subject = zooniverse.models.Subject
Api = zooniverse.Api

AppView = require 'views/app_view'

class Router extends Backbone.Router
  routes: {
    "" : "index"
    "classify(/)" : "classify"
    "science(/)" : "science"
    "science/:category(/)" : "science"
    "team(/)" : "team"
    "profile(/)" : "profile"
  }

  initialize: ->
    @appView = new AppView()

  index: ->
    @appView.setActive('index')

  classify: ->
    @appView.setActive('classify')

  science: ->
    @appView.setActive('science')

  team: ->
    @appView.setActive('team')

  profile: ->
    @appView.setActive('profile')

module.exports = Router
