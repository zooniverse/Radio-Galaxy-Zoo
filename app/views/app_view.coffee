Index = require('./index')
Classify = require('./classify')
Science = require('./science')
Team = require('./team')
Profile = require('./profile')

class AppView extends Backbone.View

  sections: {
    'index' : new Index()
    'classify' : new Classify()
    'science' : new Science()
    'team' : new Team()
    'profile': new Profile()
  }

  initialize: ->
    @setActive('index')

  setActive: (a) ->
    return if a is @active
    @sections[@active].hide() if @active
    @active = a
    @sections[@active].show()

module.exports = AppView