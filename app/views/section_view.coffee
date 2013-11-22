class SectionView extends Backbone.View
  constructor: ->
    super
    @_visible = false

  hide: ->
    @$el.removeClass('active')
    @_visible = false

  show: ->
    @$el.addClass("active")
    @_visible = true

  toggle: ->
    if @isVisible() then @hide() else @show()

  isVisible: ->
    @_visible

module.exports = SectionView
