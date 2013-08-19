
class ClassifierModel
    
  constructor: ($rootScope, $http) ->
    
    # TODO: Is this weird?
    @$http = $http
    @$rootScope = $rootScope
    
    $http.defaults.useXDomain = true
    delete $http.defaults.headers.common['X-Requested-With']
    
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
    
    @contours = null
    @src = null
    
    # Classification parameters
    @selectedContours = []
    @circles = []
    @getSubject()
  
  addContour: (value) ->
    @selectedContours.push(value)
  
  removeContour: (value) ->
    index = @selectedContours.indexOf(value)
    @selectedContours.splice(index, 1)
    
  addCircle: (x, y) ->
    circle =
      x: x
      y: y
      radius: 20
    @circles.push(circle)
  
  getSubject: (id) ->
    
    # Clear the classification parameters
    @selectedContours = []
    @circles = []
    
    @$http.get('https://dev.zooniverse.org/projects/radio/subjects')
      .success( (data) =>
        @subject = data[0]
        
        @src = @subject.metadata.src
        @infraredSource = @subject.location.standard
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
  
  logspace: (start, stop, num) ->
    start = Math.log(start)
    end = Math.log(end)
    
    range = stop - start
    step = range / (num - 1)
    
    steps = new Float32Array(num)
    while num--
      steps[num] = Math.exp(start + num * step)
    
    return steps
  
  # NOTE: These levels are pre-computed.  They will need to be updated according the science team need.
  getLevels: (arr) ->
    return [
      3.0, 5.196152422706632, 8.999999999999998, 15.588457268119893, 26.999999999999993,
      46.765371804359674, 80.99999999999997, 140.296115413079, 242.9999999999999,
      420.88834623923697, 728.9999999999995, 1262.6650387177108, 2186.9999999999986,
      3787.9951161531317, 6560.9999999999945
    ]
  
  updateContourParam: (min, max, level) ->
    return if level is @level
    
    @level = level
    @contourMin = 0.001 * (@dataMax - @dataMin) * parseInt(min) + @dataMin
    @contourMax = 0.001 * (@dataMax - @dataMin) * parseInt(max) + @dataMin
    
    @getContours()
  
  getContours: () ->
    console.log 'getContours'
    arr = @arr
    
    z = @getLevels()
    # z = @linspace(@contourMin, @contourMax, @level)
    # z = @logspace(@contourMin, @contourMax, @level)
    
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
    @contours = conrec.contourList().reverse()
    
    # console.log @contours
    # console.log JSON.stringify( @contours.map( (d) -> return {k: d.k, level: d.level} ) )
    @$rootScope.$broadcast('ready')


module.exports = ClassifierModel