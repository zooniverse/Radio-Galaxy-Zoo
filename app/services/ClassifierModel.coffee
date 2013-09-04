
# TODO: Might need to split this into another service (or factory).  One would
#       be used to preserve state, the other for larger logical operations.

Subject   = zooniverse.models.Subject
User      = zooniverse.models.User
Tutorial  =  zootorial.Tutorial
TutorialSteps = require '../content/tutorial_steps'


class ClassifierModel
  COMPLETE: true
  
  
  constructor: ($rootScope, $http, $q) ->
    console.log "ClassifierModel"
    
    # Store injected services on object
    @$http = $http
    @$rootScope = $rootScope
    @$q = $q
    
    # Set state variables
    @showContours = true
    @step = 1
    @showSED = false
    
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
    
    # Callback functions when new subject is presented
    Subject.on("fetch", @onSubjectFetch)
    Subject.on("select", @onSubjectSelect)
    Subject.one("fetch", @onInitialFetch)
    
    # Callback for user change
    User.on "change", @onUserChange
  
  onUserChange: =>
    console.log 'onUserChange'
    
    # # SPOOF tutorial flag for testing
    # User.current?.project.tutorial_done = true
    
    if User.current?.project.tutorial_done is true
      # Clear out subjects before fetch
      Subject.instances?.length = 0
      Subject.fetch()
      return
    
    @startTutorial()
  
  startTutorial: =>
    console.log 'startTutorial'
    
    # Get tutorial subject
    # TODO: Instead of using an object attribute find way to pass parameter to fetch callback.
    @onTutorialSubject = true
    Subject.fetch()
    
    @tutorial = new Tutorial
      id: 'tutorial'
      firstStep: 'welcome'
      steps: TutorialSteps
    
    @tutorial.el.bind('end-tutorial', @onTutorialEnd)
    @tutorial.start()
  
  onTutorialEnd: =>
    console.log "onTutorialEnd"
  
  onInitialFetch: =>
    console.log "onInitialFetch"
    
    if @onTutorialSubject
      @onTutorialSubject = false
      Subject.instances[0] = require "../content/tutorial_subject"
    
    @subject = Subject.instances.shift()
    @nextSubject = Subject.instances.shift()
    
    # Request FITS for first subject
    new astro.FITS(@subject.location.raw, @onFITS)
    
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
    
    # Clear the array of selected contours
    @selectedContours.length = 0
    
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
      extent = image.getExtent(arr)
      @getContours(image.width, image.height, extent[0], extent[1], arr)
      
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
    # NOTE: Number needs updating if image resolution changes.
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
  
  # TODO: Remove need to store selected.  Can use DOM to extract the selected.
  addContour: (value) ->
    @selectedContours.push(value)
    
  removeContour: (value) ->
    index = @selectedContours.indexOf(value)
    @selectedContours.splice(index, 1)

  drawCatalogSources: ->
    catalog = @subject.metadata.catalog
    return unless catalog?
    
    bandLookup =
      B: 445
      R: 658
      J: 1220
      H: 1630
      K: 2190
    
    # Setup svg plot
    margin =
      top: 10
      right: 10
      bottom: 40
      left: 40
    
    width = 400 - margin.left - margin.right
    height = 131 - margin.top - margin.bottom
    
    x = d3.scale.linear().range([0, width]).domain([200, 2400])
    y = d3.scale.linear().range([height, 0]).domain([0, 30])
    
    xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom")
      .ticks(4)
    yAxis = d3.svg.axis()
      .scale(y)
      .orient("left")
      .ticks(4)
    
    sed = d3.select("div.sed").append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
          .append("g")
            .attr("transform", "translate(#{margin.left}, #{margin.top})")
    
    sed.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0, #{height})")
        .call(xAxis)
      .append("text")
        .attr("class", "label")
        .attr("x", width)
        .attr("y", -6)
        .style("text-anchor", "end")
        .text("wavelength (nanometer)")
        
    sed.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("class", "label")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("magnitude")
        
    # Format the data
    data = []
    for band, wavelength of bandLookup
      datum = {}
      datum['wavelength'] = wavelength
      datum['mag'] = 0
      data.push datum
    
    sed.selectAll(".dot")
        .data(data)
      .enter().append("circle")
        .attr("class", "dot")
        .attr("r", 3.5)
        .attr("cx", (d) -> return x(d.wavelength))
        .attr("cy", (d) -> return y(d.mag))
    
    svg = d3.select("svg")
    factor = 500 / 300
    for object in catalog
      cx = factor * parseFloat(object.x)
      cy = 500 - factor * parseFloat(object.y)
      
      do (object) =>
        svg.append("circle")
            .attr("cx", cx)
            .attr("cy", cy)
            .attr("r", 10)
            .attr("class", "source")
            .on("click", =>
              
              # TODO: Figure out how to update $rootScope.sed
              @$rootScope.$apply( =>
                @sed = true
              )
              
              # Format the data
              data = []
              for band, wavelength of bandLookup
                datum = {}
                datum['wavelength'] = wavelength
                datum['mag'] = if isNaN(parseFloat(object["#{band}mag"])) then 0 else object["#{band}mag"]
                data.push datum
              
              dots = d3.selectAll(".dot")
                      .data(data, (d) -> return d.wavelength)
                      .transition()
                      .attr("cy", (d) -> return y(d.mag))
            )


module.exports = ClassifierModel