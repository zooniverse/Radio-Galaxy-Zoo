

module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      # NOTE: Eh, this is called once each time the page is
      #       active.  Need to figure out how to prevent this because
      #       each time a new WebFITS instance is created and that's a waste!
      #       Directives might have an initialize function that maintains scope ...
      
      scope.webfits = new astro.WebFITS(elem[0], 420)
      
      scope.$watch('subjectId', ->
        return unless scope.subject
        
        # Load the radio image
        new astro.FITS(scope.subject.location.radio, (f) ->
          image = f.getDataUnit()
          image.getFrame(0, (arr) ->
            [min, max] = image.getExtent(arr)
            scope.extent['radio'] = [min, max]
            
            scope.webfits.loadImage('radio', arr, image.width, image.height)
            scope.webfits.setExtent(min, max)
            scope.webfits.setImage('radio')
            scope.webfits.setColorMap('gist_heat')
            
            scope.band = 'radio'
          )
        )
        
      )
      
      scope.$watch('band', ->
        return unless scope.band
        
        scope.webfits.setImage(scope.band)
        scope.webfits.draw()
      )
  }
  