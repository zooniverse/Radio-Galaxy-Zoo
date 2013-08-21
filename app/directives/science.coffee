
module.exports = ->
  return {
    restrict: 'C'
    link: (scope, elem, attrs) ->
      
      pop = Popcorn("#blackhole")
      
      pop.footnote({
        start: 0,
        end: 2,
        text: "We be rawkin' science!",
        target: "popcorn"
      })
      
      pop.footnote({
        start: 2,
        end: 12,
        text: "Let's go visit the center of this spiral galaxy!",
        target: "popcorn"
      })
      
      pop.footnote({
        start: 12,
        end: 17,
        text: "Oooo, there's the black hole with two radio jets emanating!",
        target: "popcorn"
      })
      
      pop.footnote({
        start: 17,
        end: 26,
        text: "WOW! Look at that rotation.  If we were really this close, we would be inside the Schwarzschild radius, where not even light can escape the gravitational pull!",
        target: "popcorn"
      })
  }