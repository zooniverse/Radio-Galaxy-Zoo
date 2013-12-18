Section = require('./section_view')
bios = require('lib/biographies')
template = require('templates/team')

class Team extends Section
  el: "#team"

  render: ->
    _.chain(bios).filter((b) -> b.type=="lead").filter((b) -> b.bio?)
      .reduce(((m, b, i) ->
        if i isnt 0 and i % 3 is 0
          m = m.concat([[b]])
        else
          _.last(m).push(b)
        m), [[]])
      .each(((b) -> @$('.lead-bios').append(template(b))), @)

    _.chain(bios).filter((b) -> b.type=="edu").filter((b) -> b.bio?)
      .reduce(((m, b, i) ->
        if i isnt 0 and i % 3 is 0
          m = m.concat([[b]])
        else
          _.last(m).push(b)
        m), [[]])
      .each(((b) -> @$('.edu-bios').append(template(b))), @)

    _.chain(bios).filter((b) -> b.type=="science").filter((b) -> b.bio?)
      .reduce(((m, b, i) ->
        if i isnt 0 and i % 3 is 0
          m = m.concat([[b]])
        else
          _.last(m).push(b)
        m), [[]])
      .each(((b) -> @$('.science-bios').append(template(b))), @)

    _.chain(bios).filter((b) -> b.type=="developer").filter((b) -> b.bio?)
      .reduce(((m, b, i) ->
        if i isnt 0 and i % 3 is 0
          m = m.concat([[b]])
        else
          _.last(m).push(b)
        m), [[]])
      .each(((b) -> @$('.developer-bios').append(template(b))), @)
    @

  show: ->
    super
    @render()

  hide: ->
    super
    @$('.bios').empty()

module.exports = Team
