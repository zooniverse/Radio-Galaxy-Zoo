
# TODO: Might need to split this into another service (or factory).  One would
#       be used to preserve state, the other for larger logical operations.

User            = zooniverse.models.User
Subject         = zooniverse.models.Subject
Classification  = zooniverse.models.Classification
Tutorial        = zootorial.Tutorial

TutorialSteps   = require '../content/tutorial_steps'

# Disable Subject preloading
Subject.preload = false 
class ClassifierModel
  COMPLETE: true
  
  
  constructor: ($rootScope, $q, translateRegEx, imageDimension, fitsImageDimension, levels, contourThreshold) ->
    # Store injected services on object
    @$rootScope = $rootScope
    @$q = $q
    @translateRegEx = translateRegEx
    @imageDimension = imageDimension
    @fitsImageDimension = fitsImageDimension
    @levels = levels
    @contourThreshold = contourThreshold
    # Set state variables
    @showContours = true
    @step = 0
    @showSED = false
    @example = "compact" 
    @activeGuide = false
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
    
    # Callback for user change
    User.on "change", @onUserChange
  
  reset: ->
    @initialSelect = false
    @subjectContours.length = 0
    d3.select("g.contours").remove()
    d3.selectAll("g.infrared g").remove()

  resetMarking: ->
    @selectedContours.shift()
    d3.selectAll('svg .selected').attr('class', "contour-group")
    d3.selectAll('svg .infrared g:not(.matched)').remove()
  
  onUserChange: =>
    
    @reset()
    Subject.one("fetch", @onInitialFetch)
    
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
    
    # Create tutorial subjects and fetch
    subjects = require "../content/tutorial_subject"
    
    stage1 = new Subject(subjects.stage1)
    
    @classification = new Classification {stage1}
    
    Subject.fetch()
    @startFirstTutorial()
  
  startFirstTutorial: =>
    @hasTutorial = true
    
    @tutorial = new Tutorial
      id: 'first-tutorial'
      firstStep: 'welcome'
      steps: TutorialSteps.stage1
      parent: document.querySelector(".classifier")
    @tutorial.el.bind("end-tutorial", @onTutorialEnd)
  
  onTutorialEnd: =>
    @hasTutorial = false
    @tutorial.end()
  
  onInitialFetch: =>
    if @hasTutorial
      Subject.instances.splice(1, 0, Subject.instances.pop())
      Subject.instances.splice(3, 0, Subject.instances.pop())
    
    @subject = Subject.instances.shift()
    @nextSubject = Subject.instances.shift()
    
    @classification = new Classification {@subject}
    
    # Request FITS for first subject
    @$rootScope.$apply( =>
      @infraredSource = @subject.location.standard
      @radioSource = @subject.location.radio
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
    
    # Set variable to prefetch images for next subject
    @nextInfraredSource = @nextSubject.location.standard
    @nextRadioSource = @nextSubject.location.radio 
  
  getSubject: ->
    
    @subject = @nextSubject
    @infraredSource = @subject.location.standard
    @radioSource = @subject.location.radio
    
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
  
  onGetContours: (contours, opts) =>
    @subjectContours = contours
    if @initialSelect is @COMPLETE
      @$rootScope.$apply( ->
        opts.dfd.resolve(opts.subject)
      )
    else
      @initialSelect = true
      @drawContours( @subjectContours[0] )
      
      # Request FITS and precompute contours for next subject
  
  getContoursAsync: (width, height, arr, opts) ->
    
    # Define function to be executed on worker thread
    onmessage = (e) ->
      importScripts("http://radio.galaxyzoo.org/beta2/workers/conrec.js")
      
      # Get variables sent from main thread
      width = e.data.width
      height = e.data.height
      arr = new Float32Array(e.data.buffer)
      threshold = e.data.threshold
      levels = e.data.levels
      
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
        
        group.bbox = getBBox(k0contour)
        [ [xmin, xmax], [ymin, ymax] ] = group.bbox
        
        # Apply threshold to lowest level contours
        xd = xmax - xmin
        yd = ymax - ymin
        d = Math.sqrt(xd * xd + yd * yd)
        continue if d < threshold
        
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
      levels: @levels
      threshold: @contourThreshold
   
    worker.onmessage = (e) =>
      console.log(_.map(_.pluck(e.data, 'bbox'), ([[xmin, xmax], [ymin, ymax]]) -> 
        {xmax: xmax, ymax: ymax, xmin: xmin, ymin: ymin}
      ))
      @subjectContours.push e.data
      @onGetContours(opts)
    
    worker.postMessage(msg, [arr.buffer])
  
  drawContours: (contours) ->
    svg = d3.select("svg.svg-contours")
    
    # Factor is needed because JPGs have been upscaled from FITS resolution.
    factor = @imageDimension / @fitsImageDimension
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
        return unless @step is 0
        el = d3.select(d3.event.target.parentNode)
        classes = el.attr("class")
        contourGroupId = el.attr("id")
        el.attr("class", "contour-group selected")
        @$rootScope.$apply( =>
          @step = 1 
        )
        @addContourGroup(contourGroupId)
      )
    
    @isDisabled = false
    
    # TODO: Find better place for this
    # NOTE: Tutorial animation lags due to SVG drawing. Placing tutorial start here
    #       allows drawing to complete before rendering tutorial. Also needed because
    #       tutorial depends on contours already having been drawn.
    setTimeout ( =>
      @tutorial.start() if @hasTutorial
    ), 0
  
  toggleFavorite: ->
    @classification.favorite = if @classification.favorite then false else true
  
  # Store the associated radio emission with IR sources. This is called once for each association.
  getMatch: ->
    
    radio = []
    while @selectedContours.length
      id = @selectedContours.shift()
      
      group = d3.select("g[id='#{id}']")
      path = d3.select("g[id='#{id}'] path:last-child").node()
      radio.push path.getBBox() # Get bounding box before hiding element otherwise FF throws error
      
      group.attr("class", "contour-group matched")
    
    infrared = []
    translateRegEx = @translateRegEx
    d3.selectAll("g.infrared g:not(.matched)").each( ->
      
      circle = d3.select( this.children[0] )
      
      group = d3.select(this)
      group.classed("matched", true)
      transform = group.attr("transform")
      match = transform.match(translateRegEx)
      
      obj =
        r: circle.attr("r")
        x: match[1]
        y: match[2]
      infrared.push obj
    )
    
    obj =
      radio: radio
      infrared: infrared
    @matches.push obj
  
  addContourGroup: (value) ->
    @selectedContours.push(value)
    
  removeContourGroup: (value) ->
    index = @selectedContours.indexOf(value)
    @selectedContours.splice(index, 1)
  
  getClassification: ->
    @classification.annotate(@matches)
    @classification.send()

module.exports = ClassifierModel