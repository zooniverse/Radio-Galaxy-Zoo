Api = zooniverse.Api
Subject = zooniverse.models.Subject

AppView = require 'views/app_view'

class Router extends Backbone.Router
  routes: {
    "" : "index"
    "classify(/)" : "classify"
    "classify/:subject_id": "loadSubject"
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

  loadSubject: (subjectId) ->
    Api.current.get "projects/#{ Api.current.project }/subjects/#{ subjectId }", (rawSubject) ->
      return unless rawSubject
      subject = new Subject rawSubject
      subject.select()

    @appView.setActive 'classify'

  science: ->
    @appView.setActive('science')

  team: ->
    @appView.setActive('team')

  profile: ->
    @appView.setActive('profile')

module.exports = Router
