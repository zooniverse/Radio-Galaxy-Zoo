
template = """
  <div class='home'>
    <div class="headline">In Search of Erupting Black Holes
      <p class="call-to-action">Help astronomers discover supermassive black holes observed by the Australia Telescope Large Area Survey.</p>
    </div>
    
    <div class="slider">
      <div class="slide-element radio-galaxy-zoo">
        <div class="left">
          <p class="header-title">Search for Black Holes</p>
          <p class="description">Black holes are found at the center of most, if not all, galaxies. The bigger the galaxy, the bigger the black hole and the more sensational the effect it has on the host galaxy. These supermassive black holes drag in nearby materials, growing to be billions of times the size of our sun and occasionally producing spectacular jets of materials travelling nearly as fast as the speed of light. Often invisible in visible light, but detectable in radio wavelengths, astronomers need help to find these jets and match them to the galaxy that hosts them.</p>
          <a class="blue-button" href="#/classify">Begin Hunting</a>
        </div>
      </div>
    </div>
    
    <div class="content-block">
      <div class="left">
        <h1 class="heading">Why do astronomers need you help?</h1>
        <p class="description">Black holes cannot be observed, light cannot escape from them, but we can detect them by observing the effect they have on their surroundings.  There are a number of methods for detecting these effects, but the supermassive black holes found at the center of galaxies cannot be observed in the optical or infrared due to the large amounts of dust obscuring absorbing the light in those wavelengths. Fortunately the jets of materials spewed out by these supermassive black holes can be observed in the radio wavelengths.</p>
        <p class="description">There is a great deal of valuable information that can be obtained from the radio images of these jets, but we need to understand the host galaxy too. For instance observing the host galaxy in the optical allows us to determine its distance, which is critical to understanding how big and how luminous the black hole actually is.</p>
      </div>
      <div class="right">
        <h1 class="heading">Why can’t computers match the sources?</h1>
        <p class="description">The jets visible in the radio wavelengths and the host galaxy visible in the optical wavelengths sometimes overlap. In this case, computer programs can tell automatically that they are associated with each other.  This simple case is known to astronomers as a ‘compact source’ (Figure 1: make sure there is a sample image).</p>
        <p class="description">The matching becomes much more complex when you start to consider ‘multiple sources’  (Figure 2: make sure there is a sample image) or ‘extended sources’  (Figure 3: make sure there is a sample image).</p>
        
        <p class="description">If we see three blobs of radio emission, that could be three separate galaxies or a black hole and its two jets. It is possible for a human to tell by comparing the radio and infrared images – if the infrared shows three galaxies in a row, lining up with the respective radio spots, then it’s probably three separate galaxies. If the only infrared source is in the centre, then it’s probably a black hole and two jets. Computer programs cannot compete with the human brain for pattern recognition, especially if the radio emission is uneven or distorted.</p>
      </div>
    </div>
    
  </div>
"""

module.exports = template