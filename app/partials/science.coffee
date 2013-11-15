template = """
  <div class='science' data-ng-controller="ScienceCtrl">
    
    <div class="content-block row">
      <div class="col-xs-6">
        <span class="content-image">
          <a href="http://www.atnf.csiro.au/people/Emil.Lenc/Gallery/"><span class="image-credit">Image Credit: Emil Lenc</span></a>
          <img src="/images/science/atlas.jpg" class="science-image"/>
          <h2>Radio Images</h2>
        </span>
        <p class="description"> The radio data you are viewing comes from the Australia Telescope Large Area Survey (ATLAS), a deep radio survey of six square degrees of the sky (about 30 times the size of the full Moon). This field contains about 6000 sources. The data were taken with the Australia Telescope Compact Array (ATCA) in rural New South Wales. The images were taken between 2006 and 2011. With only 6000 sources, we can simultaneously have experts examine the sources by eye AND compare these to results from Radio Galaxy Zoo volunteers. We'll combine these to develop and refine our techniques for the upcoming, larger EMU (Evolutionary Map of the Universe) survey.</p>
        <p class="description">EMU will be performed with the newly constructed Australian SKA Pathfinder (ASKAP) telescope in Western Australia. EMU will discover about 70 million radio sources, increasing our knowledge of the radio sky by almost a factor of 30! Even more importantly, EMU will probe far more deeply than other telescopes, giving us millions of examples of types of galaxies of which only a few hundred are currently known.</p>
      </div>
      <div class="col-xs-6">
        <span class="content-image">
          <a href="http://commons.wikimedia.org/wiki/File:Spitzer_space_telescope.jpg"><span class="image-credit">Image Credit: NASA/JPL-Caltech</span></a>
          <img src="/images/science/spitzer.jpg" class="science-image"/>
          <h2>Infrared Images</h2>
        </span>
        <p class="description">The Spitzer Space Telescope is a space-based infrared observatory launched by NASA in 2003. It studies objects ranging from our own Solar System to the distant reaches of the Universe. In the early days of the Spitzer mission, the telescope was cryogenically cooled so that its three instruments (two cameras and a spectrograph) could observe the Universe at wavelengths from 3 to 180 micrometers. Since Spitzer's helium supply was exhausted in 2009, the telescope currently operates one of its cameras in Warm Mode, continuing to image the universe at infrared wavelengths of 3.4 and 4.6 micrometers.</p>
        <p class="description">The infrared images you see in Radio Galaxy Zoo were taken as part of a program called the Spitzer Wide-Area Infrared Extragalactic Survey, or SWIRE. These images were taken with the IRAC camera at a wavelength 3.6 micrometers. The emission from the galaxies comes from a combination of stars and from dust in the galaxy which has been heated, either by the stars themselves or by emission from a central black hole.</p>
      </div>
    </div>

    <div class="content-block row">
      <div class="col-xs-6">
        <h2>Why can’t computers do this task?</h2>
        <p class="description">The jets visible in the radio wavelengths and the host galaxy visible in the optical wavelengths sometimes overlap. In this case, computer programs can tell automatically that they are associated with each other. This simple case is known to astronomers as a ‘compact source’ (Figure 1: make sure there is a sample image).</p>
        <p class="description">The matching becomes much more complex when we start to consider ‘multiple sources’  (Figure 2: make sure there is a sample image) or ‘extended sources’  (Figure 3: make sure there is a sample image).</p>   
        <p class="description">If we see three blobs of radio emission, that could either be three separate galaxies or a black hole and its two jets. It's possible for a human to tell by comparing the radio and infrared images – if the infrared shows three galaxies in a row, lining up with the respective radio spots, then it’s probably three separate galaxies. If the only infrared source is in the centre, then it’s probably a black hole and two jets. Computer programs cannot compete with the human brain for pattern recognition, especially if the radio emission is uneven or distorted.</p>
      </div>
      
      <div class="col-xs-6">
        <h2>Serendipitous Discoveries</h2>
        <p class="description">A great bonus of having humans match these radio and infrared images of galaxies is the possibility of unexpected results. Computer programs only detect or measure what a human requires them too. Humans, on the other hand, are curious by nature and will question and explore unusual features that they see. Other citizen science projects built by the Zooniverse have lead to unexpected and amazing discoveries: this includes objects like Hanny's Voorwerp and the Green Peas in Galaxy Zoo, or the potentially new seaworm species discovered in Seafloor Explorer.</p>
        <p class="description">While examining the radio and infrared images, you will be often be asked if you want to ‘TALK’. This is our online discussion tool, where volunteers and the Radio Galaxy Zoo scientists can chat about things that interest them or they are unsure about. Feel free to ask about any image that peaks your curiosity. It may be easy to explain, or it might just be something completely unexpected!</p>
      </div>
    </div>
  
    <div class="content-block row">
      <div class="col-xs-6">
        <h2>How do supermassive black holes form?</h2>
        <p class="description">Astronomers have plenty of evidence that small black holes (roughly a few times the mass of our Sun) form when a large star reaches the end of its life. We're less certain about how supermassive black holes (billions of times the size of our Sun) form and grow. Current models suggest that small black holes can merge together to form larger black holes. These larger black holes then swallow surrounding material, merge again with other black holes, swallow more material, and so on until they become the supermassive black holes we observe at the center of massive galaxies.</p>
        <p class="description">The problem with this model is that the process of repeated black hole merging takes many billions of years, yet we’ve found evidence for supermassive black holes less than a billion years after the Big Bang! That's not enough time for them to have grown to the sizes we observe, indicating that there's more work to be done on these objects.</p>
        <p class="description">In order to better understand how supermassive black holes form, astronomers need more data to input into their models. Ideally, they need information about black holes at all stages of their lifecycle. To accomplish this, we want to identify as many black hole/jet pairs as possible and associate them with their host galaxies; with a large enough sample (from your classifications), we can pick out black holes at different stages and build a better picture of their origins.</p>
      </div>
      <div class="col-xs-6">
        <h2>Supermassive black holes and their host galaxies</h2>
        <p class="description">There is strong circumstantial evidence that the supermassive black holes can change the rate at which stars form in their host galaxies. It is possible that the jets from the supermassive black hole heat up and disrupt the gas within the galaxy. This might either regulate the star formation rate by expelling and heating the gas; alternatively, it might compress the gas in some parts of the galaxy and actually increase the star formation rate. Our best understanding of which of these processes dominate galaxies will be helped with bigger samples of galaxies to observe, which we hope to get from your classifications.</p>
      </div>
    </div>
  
  </div>
"""

module.exports = template
