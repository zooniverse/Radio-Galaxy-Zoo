
linspace = (start, stop, num) ->
  range = stop - start
  step = range / (num - 1)
  
  steps = new Float32Array(num)
  while num--
    steps[num] = start + num * step
  
  return steps


getContours = (scope, elem) ->
  return unless scope.arr?
  
  # Reset selected because it's no longer selected
  scope.selected = null
  
  arr = scope.arr
  width = scope.width
  j = scope.height
  min = scope.min
  max = scope.max
  
  z = linspace(min, max, scope.level)
  
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
  contours = conrec.contourList()
  
  drawContours(scope, elem, contours)

# drawContour = (canvas, color, lineWidth) ->
#   
#   # Get dimensions from canvas
#   width = canvas.width
#   height = canvas.height
#   
#   # Clear canvas
#   canvas.width = width
#   
#   context = canvas.getContext('2d')
#   context.beginPath()
#   
#   context.strokeStyle = color
#   
#   # NOTE: Alpha value yields 1 when checking image data from canvas
#   context.fillStyle = "rgba(0, 0, 0, 0.00625)"
#   context.lineWidth = lineWidth
#   context.translate(0.5 * width, 0.5 * height)
#   context.rotate(-Math.PI / 2)
#   context.translate(-0.5 * width, -0.5 * height)
#   
#   contour = canvas.contour
#   
#   # Move to the start of this contour
#   context.moveTo(contour[0].x, contour[0].y)
#   
#   # Join the dots
#   i = 1
#   while i < contour.length
#     context.lineTo contour[i].x, contour[i].y
#     i += 1
#   context.closePath()
#   context.fill()
#   context.stroke()
# 
# 
# drawContours = (scope, elem, contours) ->
#   width = scope.width
#   height = scope.height
#   canvases = scope.canvases
#   
#   # Clean up old canvas
#   while canvases.length
#     elem[0].removeChild( canvases.shift() )
#   
#   l = 0
#   while l < contours.length
#     
#     # Create new canvas for each contour
#     canvas = document.createElement('canvas')
#     canvas.className = 'contour'
#     canvas.width = width
#     canvas.height = height
#     canvases.push(canvas)
#     elem[0].insertBefore(canvas, elem.firstChild)
#     
#     # Store contours on canvas
#     canvas.contour = contours[l]
#     drawContour(canvas, "#FAFAFA", 1.5)
#     l += 1

drawContours = (scope, elem, contours) ->
  
  # TESTING: KineticJS
  stage = new Kinetic.Stage
    container: 'contours'
    width: 421
    height: 421
    
  layer = new Kinetic.Layer()
  
  # Do quick statistics on contours
  lengths = []
  for contour in contours
    lengths.push contour.length
  avg = lengths.reduce( (a, b) -> return a + b ) / contours.length
  std = lengths.map( (d) ->
    val = (d - avg)
    return val * val
  )
  std = std.reduce( (a, b) -> return a + b)
  std = Math.sqrt(std / contour.length)
  
  limit = avg + 0.25 * std
  
  for contour in contours
    points = []
    
    continue if contour.length < limit
    # contour = contour.map( (d) ->
    #   x = d.x
    #   y = d.y
    #   
    #   d.y = scope.width - x
    #   d.x = y
    #   return d
    # )
    for point in contour by 4
      points.push point.y
      points.push scope.width - point.x
      
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
  
selectContour = (scope) ->
  # TODO: Offset not available in Firefox
  x = scope.x
  y = scope.y
  canvases = scope.canvases
  
  # Deselect canvas
  if scope.selected?
    canvas = canvases[scope.selected]
    drawContour(canvas, "#FAFAFA", 1.5)
    canvas.className = "contour"
    
    for deselect in document.querySelectorAll('canvas.contour')
      deselect.className = "contour"
    
  # Check alpha channel in each canvas for selection using
  # while loop to preference deeper contours
  index = canvases.length
  while index--
    canvas = canvases[index]
    
    # TODO: Might need to cache this for performance (not sure)
    context = canvas.getContext('2d')
    imgData = context.getImageData(x, y, 1, 1)
    
    if imgData.data[3] is 1
      # Store index of selected contour
      scope.selected = index
      
      # Specify selected canvas
      canvas.className = "contour selected"
      
      # Deselect other canvases
      for deselect in document.querySelectorAll('canvas.contour:not(.selected)')
        deselect.className = "contour deselect"
      
      # Redraw contour on canvas with selected color
      drawContour(canvas, "#00FF00", 2)
      break

toggleContours = (scope, elem) ->
  console.log 'toggleContours', elem
  
  className = "contours"
  unless scope.contours
    className += " hide"
  elem[0].className = className
  
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      # NOTE: Eh, this is called once each time the page is
      #       active.  Need to figure out how to prevent this because
      #       each time a new WebFITS instance is created and that's a waste!
      #       Directives might have an initialize function that maintains scope ...
      
      scope.$watch('level', ->
        getContours(scope, elem)
      )
      
      scope.$watch('contours', ->
        toggleContours(scope, elem)
      )
      
      scope.$watch('x', ->
        selectContour(scope)
      )
      
      scope.$watch('subjectId', ->
        return unless scope.subject
        
        # Load the radio image
        new astro.FITS(scope.subject.location.raw, (f) ->
          image = f.getDataUnit()
          
          scope.width = image.width
          scope.height = image.height
          
          image.getFrame(0, (arr) ->
            [scope.min, scope.max] = image.getExtent(arr)
            scope.arr = arr
            
            getContours(scope, elem)
          )
        )
      )
  }
