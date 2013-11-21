class Classifier extends Backbone.View
  el: "#classify .viewport"

  initialize: ->
    @loadImages()
    @model.contours.then(@drawContours)

    @listenTo(@model, "change:ir_opacity", @setOpacity)
    @setOpacity(@model)

  loadImages: ->
    @$('img').remove()
    radio = document.createElement('img')
    radio.setAttribute('src', @model.radioImage())
    radio.setAttribute('class', 'radio')

    ir = document.createElement('img')
    ir.setAttribute('src', @model.irImage())
    ir.setAttribute('class', 'infrared')
    
    @$el.prepend(ir)
    @$el.prepend(radio)
  
  drawContours: ->
    console.log(arguments)

  setOpacity: (m, opacity) ->
    opacity or= m.get('ir_opacity')
    @$('img.infrared').css('opacity', opacity)

module.exports = Classifier
