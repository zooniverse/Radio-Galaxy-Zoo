module.exports = ->
  host = if window.location.port is "9296" then "http://0.0.0.0:3000" else "https://dev.zooniverse.org"
  console.log(Analytics?)
  if Analytics?
    new Analytics
      account: "UA-1224199-49"
    
    api = new zooniverse.Api
      project: 'radio'
      host: "https://api.zooniverse.org"
      path: '/proxy'
  else
    api = new zooniverse.Api
      project: 'radio'
      host: host
      path: '/proxy'

  topBar = new zooniverse.controllers.TopBar
  zooniverse.models.User.fetch()
  topBar.el.appendTo 'body'

  footer = new zooniverse.controllers.Footer
  footer.el.appendTo '#footer'
