Subject = zooniverse.models.Subject
Api = zooniverse.Api

AppView = require 'views/app_view'

class Router extends Backbone.Router
  routes: {
    "" : "index"
    "classify(/)" : "classify"
    "classify/:subject_ids": "loadSpecificSubject"
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

  loadSpecificSubject: (rawSubjectIds) =>
    subjectIds = rawSubjectIds.split ','
    
    if subjectIds.length > 1
      app.subjectSelector.loadSubjects subjectIds
    else
      app.subjectSelector.loadSubject subjectIds[0]

    @classify()

  science: ->
    @appView.setActive('science')

  team: ->
    @appView.setActive('team')

  profile: ->
    @appView.setActive('profile')

module.exports = Router
