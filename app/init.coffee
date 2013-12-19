Router = require('lib/router')
enUS = require('lib/en-us')

zooniverse.models.Subject.prototype.talkHref = ->
  "http://radiotalk.galaxyzoo.org/#/subjects/#{@zooniverse_id}"

module.exports = ->
  t7e.load(enUS)

  languageManager = new zooniverse.LanguageManager({
    translations: {
      en: { label: "English", strings: enUS }
    }
  })

  languageManager.on('change-language', (e, code, languageStrings) ->
    t7e.load(languageStrings)
    t7e.refresh()
  )

  host = if window.location.port is "9296" then "http://0.0.0.0:3000" else "https://dev.zooniverse.org"
  if window.location.port is "" and (window.location.pathname isnt "/beta2/")
    new zooniverse.GoogleAnalytics
      account: "UA-1224199-49"
    
    api = new zooniverse.Api({
      project: 'radio'
      host: "https://api.zooniverse.org"
      path: '/proxy'
    })
  else
    api = new zooniverse.Api({
      project: 'radio'
      host: host
      path: '/proxy'
    })

    #  zooniverse.models.Subject.next()
  topBar = new zooniverse.controllers.TopBar
  zooniverse.models.User.fetch()
  topBar.el.appendTo 'body'

  footer = new zooniverse.controllers.Footer
  footer.el.appendTo '#footer'

  router = new Router()
  Backbone.history.start()
