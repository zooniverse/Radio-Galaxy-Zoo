class SectionView extends Backbone.View
  constructor: ->
    super
    @_visible = false

  _keydispatch: (events) -> 
    events = _.chain(events)
      .map(((v, k) -> [k, _.bind(@[v], @)]), @)
      .object()
      .value()
    (ev) -> 
      return if ev.originalTarget.tagName is 'INPUT'
      if ev.keyCode is 13
        key = "enter"
      else
        key = String.fromCharCode(ev.charCode)

      if ev.shiftKey
        key = "shift+" + key

      if events[key]?
        events[key](ev, key)

  delegateKeyEvents: ->
    $(document).on("keypress", @_keydispatch(@keyboardEvents))

  undelegateKeyEvents: ->
    $(document).off("keypress")

  hide: ->
    @undelegateKeyEvents() if @keyboardEvents?
    @$el.removeClass('active')
    @_visible = false

  show: ->
    @delegateKeyEvents() if @keyboardEvents?
    @$el.addClass("active")
    @_visible = true

  toggle: ->
    if @isVisible() then @hide() else @show()

  isVisible: ->
    @_visible

module.exports = SectionView
