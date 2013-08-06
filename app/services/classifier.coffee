
class ClassifierModel
    
  constructor: ($http) ->
    
    # TODO: Is this weird?
    $http.defaults.useXDomain = true
    delete $http.defaults.headers.common['X-Requested-With']
    @$http = $http
    
    @infraredSource = null
    @radioSource = null
    @level = 3
    @arr = null
    @width = null
    @height = null
    @dataMin = null
    @dataMax = null
    @contourMin = null
    @contourMax = null
    
    # Classification parameters
    @selectedContours = {}
    
    # Initialize canvas with Kinetic
    @stage = new Kinetic.Stage
      container: 'contours'
      width: 500
      height: 500
    
    @getSubject()
  
  getSubject: (id) ->
    console.log 'getSubject'
    
    # Clear the stage
    @stage.removeChildren()
    
    # Clear the classification parameters
    @selectedContours = {}
    
    @$http.get('http://0.0.0.0:8000/')
      .success( (data) =>
        @subject = data
        
        @infraredSource = @subject.location.ir
        @radioSource = @subject.location.radio
        
        raw = "#{@subject.location.raw}"
        # Request raw data
        new astro.FITS(raw, (f) =>
          image = f.getDataUnit()
          
          @width = image.width
          @height = image.height
          
          image.getFrame(0, (arr) =>
            extent = image.getExtent(arr)
            @dataMin = @contourMin = extent[0]
            @dataMax = @contourMax = extent[1]
            
            @arr = arr
            
            @getContours()
          )
        )
      )
  
  linspace: (start, stop, num) ->
    range = stop - start
    step = range / (num - 1)
    
    steps = new Float32Array(num)
    while num--
      steps[num] = start + num * step
      
    return steps
  
  updateContourParam: (min, max, level) ->
    return if level is @level
    
    @level = level
    @contourMin = 0.001 * (@dataMax - @dataMin) * parseInt(min) + @dataMin
    @contourMax = 0.001 * (@dataMax - @dataMin) * parseInt(max) + @dataMin
    
    @getContours()
  
  getContours: () ->
    arr = @arr
    
    z = @linspace(@contourMin, @contourMax, @level)
    j = @height
    
    data = []
    while j--
      start = j * @width
      data.push arr.subarray(start, start + @width)
      
    # Set conrec arguments
    ilb = jlb = 0
    iub = data.length - 1
    jub = data[0].length - 1
    
    idx = new Uint16Array(data.length)
    jdx = new Uint16Array(data[0].length)
    
    i = j = 0
    while i < idx.length
      idx[i] = i + 1
      i += 1
    while j < jdx.length
      jdx[j] = j + 1
      j += 1
    
    conrec = new Conrec()
    conrec.contour(data, ilb, iub, jlb, jub, idx, jdx, z.length, z)
    contours = conrec.contourList()
    
    @drawContours(contours)
  
  drawContours: (contours) ->
    # Clear the stage
    @stage.removeChildren()
    
    factor = 500 / @width
    layer = new Kinetic.Layer()
    for contour, index in contours
      points = []
      
      # Choose every N to save on draw time
      for point in contour by 4
        points.push factor * point.y
        points.push factor * point.x
      
      poly = new Kinetic.Polygon
        id: index
        points: points
        stroke: "#FAFAFA"
        fillEnabled: true
        strokeWidth: 1.5
        
      poly.on("click", (e) =>
        poly = e.targetNode
        
        stroke = poly.getStroke()
        if stroke is "#00FF00"
          # Polygon deselected
          stroke = "#FAFAFA"
          delete @selectedContours[poly.getId()]
        else
          # Polygon selected
          stroke = "#00FF00"
          @selectedContours[poly.getId()] = poly
        
        poly.setStroke(stroke)
        layer.draw()
      )
      
      layer.add(poly)
      
    @stage.add(layer)
  
  drawSelectedContours: ->
    @stage.removeChildren()
    
    layer = new Kinetic.Layer()
    
    for id, poly of @selectedContours
      poly.setListening(false)
      layer.add(poly)
    layer.draw()
    @stage.add(layer)
  
  createCircleLayer: ->
    console.log 'createCircleLayer'
    
    el = @stage.getContainer()
    layer = @stage.getLayers()[0]
    
    el.onmousemove = (e) ->
      return unless @selectedCircle?
      
      x = e.layerX
      y = e.layerY
      
      # Get center point of selected circle
      
      position = @selectedCircle.getAbsolutePosition()
      xc = position.x
      yc = position.y
      
      deltaX = x - xc
      deltaY = y - yc
      radius = Math.sqrt(deltaX * deltaX + deltaY * deltaY)
      
      @selectedCircle.setRadius(radius)
      layer.draw()
    
    el.onmouseup = (e) -> @selectedCircle = null
    el.onmouseout = (e) -> @selectedCircle = null
    
    el.onmousedown = (e) ->
      
      # Create circle on mousedown
      circle = new Kinetic.Circle
        x: e.layerX
        y: e.layerY
        radius: 10
        fillEnabled: true
        stroke: "#00FF00"
        strokeWidth: 1
        dashArray: [6, 2]
        draggable: true
      
      circle.on("mousedown", (e) ->
        e.cancelBubble = true
      )
      
      layer.add(circle)
      layer.draw()
      
      @selectedCircle = circle


module.exports = ClassifierModel