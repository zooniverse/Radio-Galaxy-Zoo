
# TODO: Might need to split this into another service (or factory).  One would
#       be used to preserve state, the other for larger logical operations.

User            = zooniverse.models.User
Subject         = zooniverse.models.Subject
Classification  = zooniverse.models.Classification
Tutorial        =  zootorial.Tutorial

TutorialSteps   = require '../content/tutorial_steps'


class ClassifierModel
  COMPLETE: true
  
  
  constructor: ($rootScope, $q, imageDimension, tutorialContours) ->
    
    # Store injected services on object
    @$rootScope = $rootScope
    @$q = $q
    @imageDimension = imageDimension
    @tutorialContours = tutorialContours
    
    # Set state variables
    @showContours = true
    @step = 1
    @showSED = false
    @example = 'single-compact-source'
    @isDisabled = true
    
    @hasTutorial = false
    
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
    
    @classification = null
    
    # Storage for contours to be used for current and next subject
    @subjectContours = []
    
    @selectedContours = []
    @matches = []
    
    @annotations = []
    
    # Reading of FITS is async causing contour computation to be async
    @contourPromise = null
    
    # Callback functions when new subject is presented
    Subject.on("fetch", @onSubjectFetch)
    Subject.on("select", @onSubjectSelect)
    Subject.one("fetch", @onInitialFetch)
    
    # Callback for user change
    User.on "change", @onUserChange
  
  onUserChange: =>
    console.log 'onUserChange'
    
    # # SPOOF tutorial flag for testing
    # User.current?.project.tutorial_done = false
    
    # Close tutorial if open
    @tutorial?.end()
    
    if User.current
      if User.current.project.tutorial_done is true
        # Clear subjects before fetch
        Subject.instances?.length = 0
        Subject.fetch()
        return
    
    # Clear subjects before fetch
    Subject.instances?.length = 0
    
    # Create tutorial subject and fetch
    subject = require "../content/tutorial_subject"
    @classification = new Classification {subject}
    Subject.fetch()
    
    @startTutorial()
  
  # Testing AWS CloudFront
  getCloudFront: (location) ->
    return location.replace("radio.galaxyzoo.org.s3.amazonaws.com", "d3hpovx9a6vlyh.cloudfront.net")
  
  startTutorial: =>
    @hasTutorial = true
    
    @tutorial = new Tutorial
      id: 'tutorial'
      firstStep: 'welcome'
      steps: TutorialSteps
      parent: document.querySelector(".classifier")
    
    @tutorial.contours = @tutorialContours
    @tutorial.el.bind('end-tutorial', @onTutorialEnd)
  
  onTutorialEnd: =>
    @hasTutorial = false
  
  onInitialFetch: =>
    
    @subject = Subject.instances.shift()
    @nextSubject = Subject.instances.shift()
    
    @classification = new Classification {@subject}
    
    # Request FITS for first subject
    new astro.FITS( @getCloudFront( @subject.location.raw ), @onFITS)
    
    @$rootScope.$apply( =>
      @infraredSource = @getCloudFront( @subject.location.standard )
      @radioSource = @getCloudFront( @subject.location.radio )
    )
  
  # Ensure unique subjects are served
  # TODO: There might be a better place for this.
  onSubjectFetch: (e, subjects) ->
    Subject.instances = _.unique(Subject.instances, false, (d) -> return d.id)
  
  # This function is triggered one step before the next subject
  # is rendered (i.e. during step 3 of classification). This is done so that
  # the async process of requesting FITS and computing contours is perceived 
  # to be faster.
  onSubjectSelect: (e, subject) =>
    @nextSubject = subject
    
    # Create deferred object to be resolved after contours for next subject are computed.
    dfd = @$q.defer()
    @contourPromise = dfd.promise
    new astro.FITS( @getCloudFront( subject.location.raw ), @onFITS, {dfd: dfd, subject: subject})
    
    # Set variable to prefetch images for next subject
    @nextInfraredSource = @getCloudFront( @nextSubject.location.standard )
    @nextRadioSource = @getCloudFront( @nextSubject.location.radio )
  
  getSubject: ->
    
    @subject = @nextSubject
    @infraredSource = @getCloudFront( @subject.location.standard )
    @radioSource = @getCloudFront( @subject.location.radio )
    
    # Clear the user action arrays
    @matches.length = 0
    @selectedContours.length = 0
    @annotations.length = 0
    
    @classification = new Classification {@subject}
    
    @contourPromise.then( (subject) =>
      @contourPromise = null
      @subjectContours.shift()
      @drawContours( @subjectContours[0] )
      Subject.next()
    )
  
  # Callback for when a FITS file has been received
  onFITS: (f, opts) =>
    image = f.getDataUnit(0)
    image.getFrame(0, (arr) =>
      @getContoursAsync(image.width, image.height, arr, opts)
    )
  
  onGetContours: (opts) =>
    
    if @initialSelect is @COMPLETE
      @$rootScope.$apply( ->
        opts.dfd.resolve(opts.subject)
      )
    else
      @initialSelect = true
      @drawContours( @subjectContours[0] )
      
      # Request FITS and precompute contours for next subject
      dfd = @$q.defer()
      @contourPromise = dfd.promise
      new astro.FITS( @getCloudFront( @nextSubject.location.raw ), @onFITS, {dfd: dfd, subject: @nextSubject})
      
      # Set variable to prefetch images for next subject
      @$rootScope.$apply( =>
        @nextInfraredSource = @getCloudFront( @nextSubject.location.standard )
        @nextRadioSource = @getCloudFront( @nextSubject.location.radio )
      )
  
  getContoursAsync: (width, height, arr, opts) ->
    
    # Define function to be executed on worker thread
    onmessage = (e) ->
      
      # importScripts("http://0.0.0.0:9296/workers/conrec.js")
      importScripts("http://radio.galaxyzoo.org/beta2/workers/conrec.js")
      
      # Get variables sent from main thread
      width = e.data.width
      height = e.data.height
      arr = new Float32Array(e.data.buffer)
      
      levels = [
        3.0, 5.196152422706632, 8.999999999999998, 15.588457268119893, 26.999999999999993,
        46.765371804359674, 80.99999999999997, 140.296115413079, 242.9999999999999,
        420.88834623923697, 728.9999999999995, 1262.6650387177108, 2186.9999999999986,
        3787.9951161531317, 6560.9999999999945
      ]
      
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
      conrec.contour(data, ilb, iub, jlb, jub, idx, jdx, levels.length, levels)
      contours = conrec.contourList().reverse()
      
      # Get bounding box for a contour
      getBBox = (arr) ->
        i = arr.length - 1
        
        lastElement = arr[i--]
        xmin = xmax = lastElement.x
        ymin = ymax = lastElement.y
        
        while i--
          x = arr[i].x
          y = arr[i].y
          
          xmin = x if x < xmin
          xmax = x if x > xmax
          ymin = y if y < ymin
          ymax = y if y > ymax
        
        return [ [xmin, xmax], [ymin, ymax] ]
      
      # 
      # Cluster contours
      #
      
      k0contours = []
      subcontours = []
      
      while contours.length
        contour = contours.shift()
        
        if contour.k is "0"
          k0contours.push contour
        else
          subcontours.push contour
          
      for k0contour in k0contours
        group = []
        
        [ [xmin, xmax], [ymin, ymax] ] = getBBox(k0contour)
        
        for subcontour, index in subcontours
          
          # Check only the first point
          x = subcontour[0].x
          y = subcontour[0].y
          if x > xmin and x < xmax and y > ymin and y < ymax
            group.push subcontour
            
        group.push k0contour
        contours.push group
      
      postMessage( contours )
    
    # Trick to format function for worker
    fn = onmessage.toString().replace("return postMessage", "postMessage")
    fn = "onmessage = #{fn}"
    
    # Construct blob for an inline worker function
    mime = "application/javascript"
    blob = new Blob([fn], {type: mime})
    
    URL = window.URL or window.webkitURL
    urlOnMessage = URL.createObjectURL(blob)
    
    worker = new Worker(urlOnMessage)
    msg =
      width: width
      height: height
      buffer: arr.buffer
    
    worker.onmessage = (e) =>
      @subjectContours.push e.data
      @onGetContours(opts)
    
    worker.postMessage(msg, [arr.buffer])
  
  drawContours: (contours) ->
    svg = d3.select("svg.svg-contours")
    
    # Factor is needed because JPGs have been upscaled from FITS resolution.
    factor = @imageDimension / 301
    pathFn = d3.svg.line()
                .x( (d) -> return factor * d.y)
                .y( (d) -> return factor * d.x)
                .interpolate("linear")
    
    # Group for all contour groups
    group = svg.append("g")
      .attr("class", "contours")
    
    for contourGroup, index in contours
      
      # Append new contour group
      g = group.append("g")
        .attr("class", "contour-group")
        .attr("id", "#{index}")
      
      for contour in contourGroup
        path = g.append("path")
          .attr("d", pathFn(contour))
          .attr("class", "svg-contour")
      
      # Behavior for clicking on contours
      g.on("click", =>
        el = d3.select(d3.event.target.parentNode)
        classes = el.attr("class")
        contourGroupId = el.attr("id")
        
        if classes.indexOf("selected") > -1
          el.attr("class", "contour-group")
          @removeContourGroup(contourGroupId)
        else
          el.attr("class", "contour-group selected")
          @addContourGroup(contourGroupId)
      )
    
    @isDisabled = false
    
    # TODO: Find better place for this
    # NOTE: Tutorial animation lags due to SVG drawing. Placing tutorial start here
    #       allows drawing to complete before rendering tutorial. Also needed because
    #       tutorial depends on contours already having been drawn.
    # TODO: setImmediate?
    setTimeout ( =>
      @tutorial.start() if @hasTutorial
    ), 0
  
  toggleFavorite: ->
    @classification.favorite = if @classification.favorite then false else true
  
  getMatch: ->
    
    radio = []
    while @selectedContours.length
      id = @selectedContours.shift()
      
      group = d3.select("g[id='#{id}']")
      path = d3.select("g[id='#{id}'] path:last-child").node()
      radio.push path.getBBox() # Get bounding box before hiding element otherwise FF throws error
      
      group.attr("class", "contour-group matched")
    
    # Add matched class to infrared annotation
    d3.select("g.infrared g:not(.matched)")
      .attr("class", "matched")
    
    obj =
      radio: radio
      infrared: @annotations.shift()
    @matches.push obj
  
  addContourGroup: (value) ->
    @selectedContours.push(value)
    
  removeContourGroup: (value) ->
    index = @selectedContours.indexOf(value)
    @selectedContours.splice(index, 1)
  
  # This function is called from the marking directive whenever an annotation
  # changes (e.g. create, move, scale, remove).
  updateAnnotation: ->
    translateRegEx = /translate\((-?\d+), (-?\d+)\)/
    @annotations.length = 0
    
    for annotation in d3.selectAll("circle.annotation")[0]
      circle = d3.select(annotation)
      parent = d3.select(circle.node().parentNode)
      
      # TODO: Generalize function for getting transform coordinates
      #       it's now been written in three separate places in code
      transform = parent.attr("transform")
      match = transform.match(translateRegEx)
      
      obj =
        r: circle.attr("r")
        x: match[1]
        y: match[2]
      
      @annotations.push obj
  
  getClassification: ->
    @classification.annotate(@matches)
    @classification.send()


module.exports = ClassifierModel