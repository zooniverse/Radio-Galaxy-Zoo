template = """
  <div class='science' data-ng-controller="ScienceCtrl">
    
    <div class="content-block">
      <div class="left">
        <h1 class="heading">Why can’t computers match the sources?</h1>
        <p class="description">The jets visible in the radio wavelengths and the host galaxy visible in the optical wavelengths sometimes overlap. In this case, computer programs can tell automatically that they are associated with each other.  This simple case is known to astronomers as a ‘compact source’ (Figure 1: make sure there is a sample image).</p>

        <p class="description">The matching becomes much more complex when you start to consider ‘multiple sources’  (Figure 2: make sure there is a sample image) or ‘extended sources’  (Figure 3: make sure there is a sample image).</p>
        
        <p class="description">If we see three blobs of radio emission, that could be three separate galaxies or a black hole and its two jets. It is possible for a human to tell by comparing the radio and infrared images – if the infrared shows three galaxies in a row, lining up with the respective radio spots, then it’s probably three separate galaxies. If the only infrared source is in the centre, then it’s probably a black hole and two jets. Computer programs cannot compete with the human brain for pattern recognition, especially if the radio emission is uneven or distorted.</p>
      </div>
      
      <div class="right">
        <h1 class="heading">How supermassive black holes form.</h1>
        <p class="description">Astronomers have plenty of evidence that small black holes, that are roughly a few times the mass of our Sun, form when a large star comes to the end of it’s life cycle. The picture is less certain with supermassive black holes that are billions of times the size of our Sun. The current models suggest that small black holes merge together and form larger black holes, swallow surrounding materials, merge again with other black holes, swallow more materials, and so on until they become the supermassive black holes we find at the center of massive galaxies.</p>

        <p class="description">The problem with this model is that the process of repeated merging takes many billions of years, yet we’ve found evidence for supermassive black holes less than a billion years after the Big Bang!</p>

        <p class="description">In order to better understand how these supermassive black holes form, astronomers need more data to input into their models. Ideally they need to have information about black holes at all stages of their lifecycle, which means finding large numbers of them to observe.</p>
      </div>
    </div>
  
    <div class="content-block">
      <div class="left">
        <h1 class="heading">What effect the black holes have on the host galaxy.</h1>
        <p class="description">There is strong circumstantial evidence that the supermassive black holes can effect the star formation rate of their host galaxies. It is possible that the jets from the supermassive black hole somehow heat up and disrupt the gas within the galaxy, regulating the star formation rate, or even increasing it. Once again astronomers can only begin to understand the relationship between a host galaxy’s star formation rate and their supermassive black holes if they can observe many of them.</p>
      </div>
      <div class="right">
        <h1 class="heading">Serendipitous Discoveries</h1>
        <p class="description">The great bonus of having humans match the radio jet images to the infrared galaxy images is that there is the possibility of unexpected results. Computer programs can only ever be programmed to detect or measure what a human requires them too. Humans on the other hand are curious by nature and will often question what they see. Other citizen science projects built by the Zooniverse have lead to unexpected and amazing discoveries, Galaxy Zoo volunteers found an entirely new type of galaxies, Sea Floor Explorers found a new species of sea worm.</p>

        <p class="description">While examining the radio and infrared images, you will be often be asked if you want to ‘TALK’. This is our online discussion tool, where volunteers and the Radio Galaxy Zoo scientists can chat about things that interest them or they unsure about. Feel free to ask about any image that peaks your curiosity, it may be easy to explain, or it might just be something completely unexpected!</p>
        </p>
      </div>
    </div>
    
    <div class="content-block">
      <div class="left">
        <h1 class="heading">Radio Images</h1>
        <p class="description">  The radio data you are using at the moment comes from the Australia Telescope Large Area Survey (ATLAS), which is a deep radio survey of about six square degrees of the sky, and containing about 6000 sources. The data were taken with the Australia Telescope Compact Array (ATCA) from 2006-2011, and are now being analysed. With only 6000 sources, it’s the exact right size that we can simultaneously have experts examine the sources by eye, AND simultaneously use the results from our Radio Galaxy Zoo volunteers to develop and refine the right techniques to be applied to the much larger upcoming EMU survey.</p>

        <p class="description">The Evolutionary Map of the Universe (EMU) is a survey that will be performed with the newly constructed Australian SKA Pathfinder (ASKAP) telescope.  EMU will discover about 70 million radio sources, increasing our knowledge of the radio sky by almost a factor of 30. Even more importantly, EMU will probe far more deeply, giving us millions of examples of types of galaxies of which only a few hundred are currently known. For example, only a few tens of thousands of star-forming galaxies have so far been detected at radio wavelengths, but EMU will detect about 30 million of them, enabling us to study the properties of different types of star forming galaxies.</p>
      </div>
      <div class="right">
        <h1 class="heading">Infrared Images</h1>
        <p class="description">The Spitzer Space Telescope is a space-borne, cryogenically-cooled infrared observatory capable of studying objects ranging from our Solar System to the distant reaches of the Universe.</p>
      </div>
    </div>
  
  </div>
"""

module.exports = template