window.app ?= {}

# First we'll set up the connection to the Zooniverse API.
Api = zooniverse.Api
api = new Api project: "radio"

# The top bar allows login and signup.
TopBar = zooniverse.controllers.TopBar
topBar = new TopBar
topBar.el.appendTo document.body

# Add the classification interface.
Classifier = app.controllers.Classifier
classifier = new Classifier
classifier.el.appendTo document.body

# Once we're all set up, check to see if the user is currently logged in.
User = zooniverse.models.User
User.fetch()

window.app.main = {api, topBar, classifier}

$(document).ready () ->
  ir_r_set = (fore_opacity) ->
    $(".radio--wizard--viewer--image__fore").css
      opacity: fore_opacity

  slide_lines = $(".radio--wizard--slide")

  slide_lines.on "mousedown", (e) ->
    $(this).data "mouse_is_down", true
    $this = $(this).children(".radio--wizard--slide--line")
    position = $this.offset()
    x_offset = e.pageX - position.left
    x_fraction = parseFloat(x_offset) / parseFloat($this.width())
    if x_fraction > 1
      x_fraction = 1
    else if x_fraction < 0
      x_fraction = 0
    x_offset = x_fraction * parseFloat($this.width())
    $this.children(".radio--wizard--slide--dot").css({left: x_offset})
    ir_r_set 1.0 - x_fraction

  $("body").on "mouseup", (e) ->
    slide_lines.data "mouse_is_down", false

  slide_lines.on "mousemove", (e) ->
    console.log ".radio--wizard--slide--line, mousemove"
    if $(this).data("mouse_is_down") != true
      return
    $this = $(this).children(".radio--wizard--slide--line")
    position = $this.offset()
    x_offset = e.pageX - position.left
    x_fraction = parseFloat(x_offset) / parseFloat($this.width())
    if x_fraction > 1
      x_fraction = 1
    else if x_fraction < 0
      x_fraction = 0
    x_offset = x_fraction * parseFloat($this.width())
    $this.children(".radio--wizard--slide--dot").css({left: x_offset})
    console.log "x_fraction = " + x_fraction
    ir_r_set 1.0 - x_fraction
