
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
    
    @startTutorial()
  
  # TODO: Preserve tutorial state when ng-view changes
  startTutorial: =>
    @hasTutorial = true
    console.log 'startTutorial'
    
    # Clear subjects before fetch
    Subject.instances?.length = 0
    
    # Create tutorial subject and fetch
    subject = require "../content/tutorial_subject"
    @classification = new Classification {subject}
    
    Subject.fetch()
    
    @tutorial = new Tutorial
      id: 'tutorial'
      firstStep: 'welcome'
      steps: TutorialSteps
      parent: document.querySelector(".classifier")
    
    @tutorial.contours = @tutorialContours
    @tutorial.el.bind('end-tutorial', @onTutorialEnd)
  
  onTutorialEnd: =>
    console.log "onTutorialEnd"
    @hasTutorial = false
  
  onInitialFetch: =>
    console.log "onInitialFetch"
    
    @subject = Subject.instances.shift()
    @nextSubject = Subject.instances.shift()
    
    @classification = new Classification {@subject}
    
    # Request FITS for first subject
    new astro.FITS(@subject.location.raw, @onFITS)
    
    @$rootScope.$apply( =>
      @infraredSource = @subject.location.standard
      @radioSource = @subject.location.radio
    )
  
  # Ensure unique subjects are served
  # TODO: There might be a better place for this.
  onSubjectFetch: (e, subjects) ->
    console.log "onSubjectFetch"
    Subject.instances = _.unique(Subject.instances, false, (d) -> return d.id)
  
  # This function is triggered one step before the next subject
  # is rendered (i.e. during step 3 of classification). This is done so that
  # the async process of requesting FITS and computing contours is perceived 
  # to be faster.
  onSubjectSelect: (e, subject) =>
    console.log "onSubjectSelect"
    @nextSubject = subject
    
    # Create deferred object to be resolved after contours for next subject are computed.
    dfd = @$q.defer()
    @contourPromise = dfd.promise
    new astro.FITS(subject.location.raw, @onFITS, {dfd: dfd, subject: subject})
    
    # Set variable to prefetch images for next subject
    @nextInfraredSource = @nextSubject.location.standard
    @nextRadioSource = @nextSubject.location.radio
  
  getSubject: ->
    console.log "getSubject"
    
    @subject = @nextSubject
    @infraredSource = @subject.location.standard
    @radioSource = @subject.location.radio
    
    # Clear the user action arrays
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
      
      # TESTING: Workers versus main thread computation
      @getContoursAsync(image.width, image.height, arr, opts)
      # @getContours(image.width, image.height, arr)
      # @onGetContours(opts)
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
      new astro.FITS(@nextSubject.location.raw, @onFITS, {dfd: dfd, subject: @nextSubject})
      
      # Set variable to prefetch images for next subject
      @$rootScope.$apply( =>
        @nextInfraredSource = @nextSubject.location.standard
        @nextRadioSource = @nextSubject.location.radio
      )
  
  # NOTE: These levels are pre-computed.  They will need to be updated according the science team need.
  getLevels: (arr) ->
    return [
      3.0, 5.196152422706632, 8.999999999999998, 15.588457268119893, 26.999999999999993,
      46.765371804359674, 80.99999999999997, 140.296115413079, 242.9999999999999,
      420.88834623923697, 728.9999999999995, 1262.6650387177108, 2186.9999999999986,
      3787.9951161531317, 6560.9999999999945
    ]
  
  getContoursAsync: (width, height, arr, opts) ->
    console.log 'getContoursAsync'
    
    # Define function to be executed on worker thread
    onmessage = (e) ->
      
      # TODO: Update URL for beta site
      # importScripts("http://0.0.0.0:9296/workers/conrec.js")
      importScripts("http://radio.galaxyzoo.org/beta/workers/conrec.js")
      
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
      
      postMessage( conrec.contourList().reverse() )
    
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
  
  getContours: (width, height, arr) ->
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
    # NOTE: Number needs updating if image resolution changes.
    factor = @imageDimension / 301
    
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
    
    # TODO: Find better place for this
    # NOTE: Tutorial animation lags due to SVG drawing. Placing tutorial start here
    #       allows drawing to complete before rendering tutorial. Also needed because
    #       tutorial depends on contours already having been drawn.
    setTimeout ( =>
      @tutorial.start() if @hasTutorial
    ), 0
    
  
  # TODO: Remove need to store selected.  Can use DOM to extract the selected.
  addContour: (value) ->
    @selectedContours.push(value)
    
  removeContour: (value) ->
    index = @selectedContours.indexOf(value)
    @selectedContours.splice(index, 1)
  
  # This function is called from the marking directive whenever an annotation
  # changes (e.g. create, move, scale, remove).
  updateAnnotation: ->
    console.log "updateAnnotation"
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
    # Create array for matches
    # TODO: Currently multiple matches is not supported in interface.
    matches = []
    
    radio = []
    contours = d3.selectAll("path.selected")[0]
    for contour in contours
      radio.push contour.getBBox()
    
    match =
      radio: radio
      infrared: @annotations
    matches.push match
    console.log matches
    
    @classification.annotate(matches)
    @classification.send()
  
  # drawCatalogSources: ->
  #   catalog = @subject.metadata.catalog
  #   return unless catalog?
  #   
  #   bandLookup =
  #     B: 445
  #     R: 658
  #     J: 1220
  #     H: 1630
  #     K: 2190
  #   
  #   # Setup svg plot
  #   margin =
  #     top: 10
  #     right: 10
  #     bottom: 40
  #     left: 40
  #   
  #   width = 400 - margin.left - margin.right
  #   height = 131 - margin.top - margin.bottom
  #   
  #   x = d3.scale.linear().range([0, width]).domain([200, 2400])
  #   y = d3.scale.linear().range([height, 0]).domain([0, 30])
  #   
  #   xAxis = d3.svg.axis()
  #     .scale(x)
  #     .orient("bottom")
  #     .ticks(4)
  #   yAxis = d3.svg.axis()
  #     .scale(y)
  #     .orient("left")
  #     .ticks(4)
  #   
  #   sed = d3.select("div.sed").append("svg")
  #           .attr("width", width + margin.left + margin.right)
  #           .attr("height", height + margin.top + margin.bottom)
  #         .append("g")
  #           .attr("transform", "translate(#{margin.left}, #{margin.top})")
  #   
  #   sed.append("g")
  #       .attr("class", "x axis")
  #       .attr("transform", "translate(0, #{height})")
  #       .call(xAxis)
  #     .append("text")
  #       .attr("class", "label")
  #       .attr("x", width)
  #       .attr("y", -6)
  #       .style("text-anchor", "end")
  #       .text("wavelength (nanometer)")
  #       
  #   sed.append("g")
  #       .attr("class", "y axis")
  #       .call(yAxis)
  #     .append("text")
  #       .attr("class", "label")
  #       .attr("transform", "rotate(-90)")
  #       .attr("y", 6)
  #       .attr("dy", ".71em")
  #       .style("text-anchor", "end")
  #       .text("magnitude")
  #       
  #   # Format the data
  #   data = []
  #   for band, wavelength of bandLookup
  #     datum = {}
  #     datum['wavelength'] = wavelength
  #     datum['mag'] = 0
  #     data.push datum
  #   
  #   sed.selectAll(".dot")
  #       .data(data)
  #     .enter().append("circle")
  #       .attr("class", "dot")
  #       .attr("r", 3.5)
  #       .attr("cx", (d) -> return x(d.wavelength))
  #       .attr("cy", (d) -> return y(d.mag))
  #   
  #   svg = d3.select("svg")
  #   factor = @imageDimension / 300
  #   for object in catalog
  #     cx = factor * parseFloat(object.x)
  #     cy = @imageDimension - factor * parseFloat(object.y)
  #     
  #     do (object) =>
  #       svg.append("circle")
  #           .attr("cx", cx)
  #           .attr("cy", cy)
  #           .attr("r", 10)
  #           .attr("class", "source")
  #           .on("click", =>
  #             
  #             # TODO: Figure out how to update $rootScope.sed
  #             @$rootScope.$apply( =>
  #               @showSED = true
  #             )
  #             
  #             # Format the data
  #             data = []
  #             for band, wavelength of bandLookup
  #               datum = {}
  #               datum['wavelength'] = wavelength
  #               datum['mag'] = if isNaN(parseFloat(object["#{band}mag"])) then 0 else object["#{band}mag"]
  #               data.push datum
  #             
  #             dots = d3.selectAll(".dot")
  #                     .data(data, (d) -> return d.wavelength)
  #                     .transition()
  #                     .attr("cy", (d) -> return y(d.mag))
  #           )


module.exports = ClassifierModel