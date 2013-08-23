
Subject = zooniverse.models.Subject


class ClassifierModel
    
  constructor: ($rootScope, $http) ->
    
    # TODO: Is this weird?
    @$http = $http
    @$rootScope = $rootScope
    
    $http.defaults.useXDomain = true
    delete $http.defaults.headers.common['X-Requested-With']
    
    @src = null
    @infraredSource = null
    @radioSource = null
    
    # Storage for contours to be used for current and subsequent subjects
    @subjectContours = []
    
    @contours = null
    
    # Call function when new subject is presented
    Subject.on("fetch", @onSubjectFetch)
    Subject.on("select", @onSubjectSelect)
    
    # Execute initial fetch
    Subject.fetch( -> Subject.next())
  
  addContour: (value) ->
    @selectedContours.push(value)
  
  removeContour: (value) ->
    index = @selectedContours.indexOf(value)
    @selectedContours.splice(index, 1)
  
  # Clear variables after classification
  reset: ->
    @selectedContours = []
    @circles = []
  
  onSubjectFetch: (e, subjects) ->
    # Ensure unique subjects are served
    Subject.instances = _.unique(Subject.instances, false, (d) -> return d.id)    
  
  onSubjectSelect: (e, subject) =>
    @reset()
    
    @currentSubject = subject
    @src = subject.metadata.src
    @infraredSource = subject.location.standard
    @radioSource = subject.location.radio
    
    new astro.FITS(subject.location.raw, @onFITS)
  
  # Callback for when a FITS file has been received
  onFITS: (f) =>
    image = f.getDataUnit(0)
    image.getFrame(0, (arr) =>
      extent = image.getExtent(arr)
      @getContours(image.width, image.height, extent[0], extent[1], arr)
    )
  
  # NOTE: These levels are pre-computed.  They will need to be updated according the science team need.
  getLevels: (arr) ->
    return [
      3.0, 5.196152422706632, 8.999999999999998, 15.588457268119893, 26.999999999999993,
      46.765371804359674, 80.99999999999997, 140.296115413079, 242.9999999999999,
      420.88834623923697, 728.9999999999995, 1262.6650387177108, 2186.9999999999986,
      3787.9951161531317, 6560.9999999999945
    ]
  
  getContours: (width, height, min, max, arr) ->
    z = @getLevels()
    j = height
    
    data = []
    while j--
      start = j * width
      data.push arr.subarray(start, start + width)
      
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
    
    # Reverse the list so that contours are drawn in correct order (largest first)
    @subjectContours.push conrec.contourList().reverse()
    
    @$rootScope.contours = @subjectContours[0]
    @$rootScope.src = @src
    @$rootScope.$apply()


module.exports = ClassifierModel