
Subject = zooniverse.models.Subject


class ClassifierModel
  COMPLETE: true
  
  constructor: ($rootScope, $http, $q) ->
    
    # Store injected services on object
    @$http = $http
    @$rootScope = $rootScope
    @$q = $q
    
    # Boolean to check if on initial subject
    # TODO: Would be nice to use `one` event binding instead
    @initialSelect = false
    
    # Attributes describing the current subject
    @infraredSource = null
    @radioSource = null
    @contours = null
    
    # Store current and next subject objects
    @currentSubject = null
    @nextSubject = null
    
    # Storage for contours to be used for current and next subject
    @subjectContours = []
    @selectedContours = []
    
    # Reading of FITS is async causing contour computation to be async
    @contourPromise = null
    
    # Call function when new subject is presented
    Subject.on("fetch", @onSubjectFetch)
    Subject.on("select", @onSubjectSelect)
    
    # Fetch initial subjects and explicitly request next triggering onSubjectSelect
    Subject.fetch( -> Subject.next())
  
  # Clear variables after classification
  reset: ->
    @selectedContours = []
    @circles = []
  
  # Ensure unique subjects are served
  # TODO: Might be a better place for this.
  onSubjectFetch: (e, subjects) ->
    Subject.instances = _.unique(Subject.instances, false, (d) -> return d.id)
  
  # This function is triggered one step before the next subject
  # is rendered (i.e. during step 3 of classification). This is done so that
  # the async process of requesting FITS and computing contours is perceived 
  # to be faster.
  onSubjectSelect: (e, subject) =>
    @nextSubject = subject
    
    # Create deferred object to be resolved after contours are computed.
    dfd1 = @$q.defer()
    @contourPromise = dfd1.promise
    
    new astro.FITS(subject.location.raw, @onFITS, {dfd: dfd1, subject: subject})
  
  getSubject: ->
    
    @currentSubject = @nextSubject
    @infraredSource = @nextSubject.location.standard
    @radioSource = @nextSubject.location.radio
    
    @contourPromise.then( (subject) =>
      console.log 'IN THEN FUNCTION', subject
      @subjectContours.shift()
      @contourPromise = null
      @drawContours( @subjectContours[0] )
    )
  
  # Callback for when a FITS file has been received
  onFITS: (f, opts) =>
    image = f.getDataUnit(0)
    
    image.getFrame(0, (arr) =>
      extent = image.getExtent(arr)
      @getContours(image.width, image.height, extent[0], extent[1], arr)
      
      if @initialSelect is @COMPLETE
        @$rootScope.$apply( ->
          opts.dfd.resolve(opts.subject)
        )
      else
        @initialSelect = true
        subject = opts.subject
        
        @$rootScope.$apply( =>
          @currentSubject = subject
          @infraredSource = subject.location.standard
          @radioSource = subject.location.radio
        )
        @drawContours( @subjectContours[0] )
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
    
  drawContours: (contours) ->
    svg = d3.select("svg.svg-contours")
    
    # Factor is needed because JPGs have been upscaled from
    # FITS resolution.
    factor = 500 / 301
    
    pathFn = d3.svg.line()
                    .x( (d) -> return factor * d.y)
                    .y( (d) -> return factor * d.x)
                    .interpolate("linear")
    
    for contour, index in contours
      svg.append("path")
          .attr("d", pathFn(contour))
          .attr("class", "svg-contour")
          .attr("contourid", index)
          .on("click", =>
            # TODO: Disable event when past step 1
            
            el = d3.select(d3.event.target)
            classes = el.attr("class")
            contourid = el.attr("contourid")
            
            if classes.indexOf('selected') > -1
              el.attr("class", "svg-contour")
              @removeContour(contourid)
            else
              el.attr("class", "svg-contour selected")
              @addContour(contourid)
          )
  
  addContour: (value) ->
    @selectedContours.push(value)
    
  removeContour: (value) ->
    index = @selectedContours.indexOf(value)
    @selectedContours.splice(index, 1)


module.exports = ClassifierModel