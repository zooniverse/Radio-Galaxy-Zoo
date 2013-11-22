class Classifier extends Backbone.View
  el: "#classify .viewport"
  imageDimension: 425
  fitsImageDimension: 301

  initialize: ->
    @loadImages()

    @listenTo(@model, "change:ir_opacity", @setOpacity)
    @listenTo(@model, "change:selected_contours", @drawContours)
    @listenTo(@model, "change:contours", @drawContours)
    @listenTo(@model, "change:step", @startMarking)
    @listenTo(@model, "change:ir_markings", @drawInfrared)
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
  
  drawContours: (m) =>
    contourGroups = m.get("contours")
    svg = d3.select("svg.svg-contours g.contours")
    factor = @imageDimension / @fitsImageDimension
    path = d3.svg.line()
      .x( (d) -> factor * d.x)
      .y( (d) -> factor * d.y)
      .interpolate("linear")

    cGroups = svg.selectAll("g.contour-group")
      .data(contourGroups)

    cGroups.enter().append('g')
      .attr("id", (d, i) -> i)
      .on('click', @selectContour)

    cGroups.attr('class', (d, i) => 
      if i in @model.get('selected_contours') 
        'contour-group selected'
      else
        'contour-group')
    paths = cGroups.selectAll('path').data((d) -> d)

    paths.enter().append('path')
      .attr('d', (d) -> path(d['arr']) )
      .attr('class', 'svg-contour')

    cGroups.exit().remove()

  drawInfrared: (m, markings) ->
    marking = (g) =>
      g.append('circle')
        .attr('class', 'annotation')
        .attr('cx', 0)
        .attr('cy', 0)
        .attr('r', 10)

      g.append('circle')
        .attr('class', 'remove')
        .attr('cx', 7)
        .attr('cy', -7)
        .attr('r', 5)
        .on('click', @removeMarking)

      g.append("text")
        .text('x')
        .attr('x', 5)
        .attr('y', -5)

    svg = d3.select("svg.svg-contours g.infrared")
    gMarkings = svg.selectAll('g.marking').data(markings)

    gMarkings.enter().append('g')
      .attr('class', 'marking')
      .attr('transform', (d) -> "translate(#{d.x}, #{d.y})")
      .call(marking)

    gMarkings.exit().remove()

  setOpacity: (m, opacity) ->
    opacity or= m.get('ir_opacity')
    @$('img.infrared').css('opacity', opacity)

  selectContour: (d, i) =>
    return if @model.get('step') isnt 0
    @model.selectContour(i)

  startMarking: (m, step) -> 
    return unless step is 1
    svg = d3.select('svg.svg-contours')
    svg.on('click', @markInfrared(@model))

  markInfrared: (model) ->
    return ->
      return true if d3.event.originalTarget.tagName is "circle"
      model.addMarking(d3.mouse(@))

  removeMarking: (d, i) =>
    @model.removeMarking(d)

module.exports = Classifier
