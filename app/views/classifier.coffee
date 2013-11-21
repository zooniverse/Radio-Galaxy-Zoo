class Classifier extends Backbone.View
  el: "#classify .viewport"
  imageDimension: 425
  fitsImageDimension: 301

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
  
  drawContours: (contourGroups) =>
    svg = d3.select("svg.svg-contours g.contours")
    factor = @imageDimension / @fitsImageDimension
    path = d3.svg.line()
      .x( (d) -> factor * d.x)
      .y( (d) -> factor * d.y)
      .interpolate("linear")

    cGroups = svg.selectAll("g.contour-group")
      .data(contourGroups)

    cGroups.enter().append('g')
      .attr('class', 'contour-group')
      .attr("id", (d, i) -> i)

    paths = cGroups.selectAll('path').data((d) -> d)

    paths.enter().append('path')
      .attr('d', (d) -> path(d['arr']) )
      .attr('class', 'svg-contour')

  setOpacity: (m, opacity) ->
    opacity or= m.get('ir_opacity')
    @$('img.infrared').css('opacity', opacity)

module.exports = Classifier
