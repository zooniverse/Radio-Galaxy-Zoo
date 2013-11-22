Section = require('./section_view')
bios = require('lib/biographies')
template = require('templates/team')

class Team extends Section
  el: "#team"

  render: ->
    _.chain(bios).filter((b) -> b.bio?)
      .reduce(((m, b, i) ->
        if i isnt 0 and i % 3 is 0
          m = m.concat([[b]])
          console.log('here', m)
        else
          _.last(m).push(b)
          console.log(_.last(m))
        m), [[]])
      .each(((b) -> @$('.bios').append(template(b))), @)
    @

  show: ->
    super
    @render()

  hide: ->
    super
    @$('.bios').empty()

    

module.exports = Team
