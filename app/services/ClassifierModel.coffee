
Subject = zooniverse.models.Subject


class ClassifierModel
    
  constructor: ($rootScope, $http, $q) ->
    
    # TODO: Is this weird?
    @$http = $http
    @$rootScope = $rootScope
    @$q = $q
    
    $http.defaults.useXDomain = true
    delete $http.defaults.headers.common['X-Requested-With']
    
    # Initial subject select
    initialSelectComplete = false
    
    @src = null
    @infraredSource = null
    @radioSource = null
    
    # Storage for contours to be used for current and subsequent subjects
    @subjectContours = []
    
    @contours = null
    
    @promises = {}
    
    # Call function when new subject is presented
    Subject.on("fetch", @onSubjectFetch)
    Subject.on("select", @onSubjectSelect)
    
    # Execute initial fetch
    Subject.fetch( -> Subject.next())
  
  # Clear variables after classification
  reset: ->
    @selectedContours = []
    @circles = []
  
  onSubjectFetch: (e, subjects) ->
    # Ensure unique subjects are served
    Subject.instances = _.unique(Subject.instances, false, (d) -> return d.id)
  
  # Triggered one step before new subject is rendered.
  # This is done to request FITS and compute contours ahead 
  # of time for perceived performance.
  onSubjectSelect: (e, subject) =>
    dfd = @$q.defer()
    @promises.contours = dfd.promise
    new astro.FITS(subject.location.raw, @onFITS, {dfd: dfd, subject: subject})
  
  getSubject: ->
    console.log 'getSubject'
    @$q.all(@promises).then( (obj) =>
      # NOTE: This is symantically weird!
      subject = obj.contours
      
      @subjectContours.shift()
      
      @currentSubject = subject
      @src = subject.metadata.src
      @infraredSource = subject.location.standard
      @radioSource = subject.location.radio
      
      @$rootScope.contours = @subjectContours[0]
      @$rootScope.src = @src
      
      @$rootScope.contours = @subjectContours[0]
    )
  
  # Callback for when a FITS file has been received
  onFITS: (f, opts) =>
    image = f.getDataUnit(0)
    image.getFrame(0, (arr) =>
      extent = image.getExtent(arr)
      @getContours(image.width, image.height, extent[0], extent[1], arr)
      opts.dfd.resolve(opts.subject)
      
      unless @initialSelectComplete
        @initialSelectComplete = true
        
        # TODO: This subject stuff is convoluted.
        subject = opts.subject
        
        @currentSubject = subject
        @src = subject.metadata.src
        @infraredSource = subject.location.standard
        @radioSource = subject.location.radio
        
        @$rootScope.contours = @subjectContours[0]
        @$rootScope.src = @src
        
        @$rootScope.$apply()
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
    
  addContour: (value) ->
    @selectedContours.push(value)
    
  removeContour: (value) ->
    index = @selectedContours.indexOf(value)
    @selectedContours.splice(index, 1)


module.exports = ClassifierModel