
class ClassifierModel
    
  constructor: ($http) ->
    
    # TODO: Is this weird?
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
    
    @getSubject()
  
  getSubject: ->
    
    @$http.get('test-subjects.json')
      .success( (data) =>
        
        # Choose a random subject for now
        @subject = data[ Math.floor( Math.random() * data.length ) ]
        @infraredSource = @subject.location.ir
        @radioSource = @subject.location.radio
        
        # Request raw data
        new astro.FITS(@subject.location.raw, (f) =>
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
    stage = new Kinetic.Stage
      container: 'contours'
      width: 500
      height: 500
      
    layer = new Kinetic.Layer()
    factor = 500 / @width
    
    for contour in contours
      points = []
      
      for point in contour by 4
        points.push factor * point.y
        points.push factor * point.x
        
      poly = new Kinetic.Polygon
        points: points
        stroke: "#00FF00"
        fillEnabled: true
        strokeWidth: 1.5
        
      poly.on("click", (e) ->
        @setStroke("#FAFAFA")
        layer.draw()
      )
      
      layer.add(poly)
      
    stage.add(layer)


module.exports = ClassifierModel