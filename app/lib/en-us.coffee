module.exports = 
  title: "Radio Galaxy Zoo"
  radio: "Radio"
  ir: 'IR'
  nav:
    classify: 'Classify'
    science: 'Science'
    team: 'Team'
    profile: 'Profile'
    discuss: 'Discuss'
    blog: 'Blog'

  index:
    header: """ 
        <h1>In Search of Erupting Black Holes</h1>
        <p class="call-to-action">Help astronomers discover supermassive black holes observed by the KG Jansky Very Large Array (NRAO) and the Australia Telescope Compact Array (CSIRO)</p>""" 
    image_credit: "NASA, ESA, S. Baum and C. O'Dea (RIT), R. Perley and W. Cotton (NRAO/AUI/NSF), and the Hubble Heritage Team (STScI/AURA)"
    call: """ 
            <p class="header-title">Search for Black Holes</p>
            <p class="description">Black holes are found at the center of most, if not all, galaxies. The bigger the galaxy, the bigger the black hole and the more sensational the effect it can have on the host galaxy. These supermassive black holes drag in nearby material, growing to billions of times the mass of our sun and occasionally producing spectacular jets of material traveling nearly as fast as the speed of light. These jets often can't be detected in visible light, but are seen using radio telescopes. Astronomers need your help to find these jets and match them to the galaxy that hosts them.</p>
            <a class="blue-button" href="#/classify">Begin Hunting</a>"""
    left: """
          <h2>Why do astronomers need your help?</h2>
          <p class="description">Black holes cannot be directly observed, since light cannot escape from them; but we can detect them by observing the effect they have on their surroundings. There are a number of methods for probing those surroundings, but for the supermassive black holes found at the center of galaxies, any optical or infrared light is obscured by large amounts of gas and dust. Fortunately, the jets of material spewed out by these supermassive black holes can be observed in the radio wavelengths.</p>

          <p class="description">There is a great deal of valuable information that can be obtained from the radio images of these jets, but we need to understand the host galaxy too. For instance, observing the host galaxy allows us to determine its distance, which is critical to understanding how big and how luminous the black hole actually is.</p>
          <p class="description">There is a great deal of valuable information that can be obtained from the radio images of these jets, but we need to understand the host galaxy too. For instance, observing the host galaxy allows us to determine its distance, which is critical to understanding how big and how luminous the black hole actually is.</p>"""
    right: """
          <h2>What do astronomers hope to learn?</h2>
          <p class="description"> Astronomers have a good understanding of how small black holes (those that are several to tens of times more massive than our Sun) are formed. The picture is less clear for the supermassive black holes found in the center of galaxies. In order to better understand how these black holes form and evolve over time, astronomers need to observe many of them at different stages of their lifecycles. To do this, they need to find them first!</p>
          <p class="description">In order to better understand how supermassive black holes form, astronomers need more data to input into their models. Ideally, they need information about black holes at all stages of their lifecycle. To accomplish this, we want to identify as many black hole/jet pairs as possible and associate them with their host galaxies; with a large enough sample (from your classifications), we can pick out black holes at different stages and build a better picture of their origins.<a href="#/science">More ...</a></p>"""
  guide:
    title: "Spotter's Guide"
    compact_title: 'Compact'
    extended_title: 'Extended'
    multiple_title: 'Multiple'
    compact: "A compact object is where there is a single radio galaxy that looks like a circle or oval and usually lies directly on top of an infrared source."
    extended: "An extended object is where a single radio galaxy stretches away from the central infrared source."
    multiple: "A multiple object is where there are more then one radio galaxy overlapping with one or more infrared sources."
    keyboard_title: "Keyboard Shortcuts"
    keyboard: """
        <li>Space: Next Step</li>
        <li>Shift+Space: Prev Step</li>
        <li>c: Toggle Contours</li>
        <li>t: Start Tutorial</li>
        <li>r: Toggle Wavelength</li>
        <li>n: Mark No Contours/No Infrared</li>"""
  classify:
    action_buttons:
      toggle_contours: "Show/Hide Contours"
      start_tutorial: "Tutorial"
      show_shortcuts: "Keyboard Shortcuts"
    step0: "Click on any radio contour or pair of jets"
    step1: "Click the associated infrared source(s)"
    step2: "Are there any more sources?"
    step3: "Great work!"
    cancel: "Cancel"
    reset_all: "Reset All"
    done: "Done"
    no_contours: "No Contours"
    no_infrared: "No Infrared"
    finish: "Finish"
    mark_another: "Mark Another"
    next: "Next"
    fav: "Favorite"
    discuss: "Discuss"
  team:
    dev: "Development Team"
    edu: "Education Team"
    sci: "Science Team"
  science:
    radio:
      head: "Radio Images"
      p1: """Most of the radio data in Radio Galaxy Zoo comes from the Faint Images of the Radio Sky at Twenty-Centimeters (<a href="http://sundog.stsci.edu/">FIRST</a>), a deep survey which covers more than 10,000 square degrees. This is about one quarter of the entire sky! The data were taken with the Very Large Array (<a href="https://public.nrao.edu/telescopes/vla">VLA</a>), a 27-dish telescope in New Mexico, USA (and made famous in the film <i>Contact</i>). The images were taken between 1993 and 2011. About 175,000 total images in Radio Galaxy Zoo come from FIRST; you're helping us match these jets to their host galaxies by using images from the infrared WISE satellite. &rarr;</p>"""
      p2: """ Additional radio data comes from the Australia Telescope Large Area Survey (<a href="http://www.atnf.csiro.au/research/deep/">ATLAS</a>), a deep radio survey of six square degrees of the sky (about 30 times the size of the full Moon). This field contains about 6000 sources. The data were taken with the Australia Telescope Compact Array (<a href="http://www.narrabri.atnf.csiro.au/">ATCA</a>) in rural New South Wales. The images were taken between 2006 and 2011. With only 6000 sources, we can simultaneously have experts examine these sources by eye AND compare them to results from Radio Galaxy Zoo volunteers. We'll combine these to develop and refine our techniques for the upcoming, larger Evolutionary Map of the Universe (<a href="http://www.atnf.csiro.au/people/rnorris/emu/">EMU</a>) and MeerKAT-MIGHTEE surveys."""
      p3: """EMU and MIGHTEE will be performed with the newly constructed Australian SKA Pathfinder (<a href="http://www.atnf.csiro.au/projects/askap/">ASKAP</a>) telescope in Western Australia and the <a href="http://www.ska.ac.za/meerkat/">MeerKAT</a> telescope in South Africa. They will discover about 100 million radio sources, increasing our knowledge of the radio sky by almost a factor of 50! Even more importantly, they will probe far more deeply than other telescopes, giving us millions of examples of types of galaxies of which only a few hundred are currently known.</p>"""
      p4: """<p data-t7e-key="science.radio.p4" class="description">The VLA is operated by <a href="http://www.nrao.edu">NRAO</a> in the United States. Both ATCA and ASKAP are operated by <a href="http://www.csiro.au/">CSIRO</a> in Australia. MeerKAT is operated by <a href="http://www.ska.ac.za">SKA South Africa</a>.</p>"""
    ir:
      head: "Infrared Images"
      p1: """ Most of infrared images that you're using to identify the host galaxies of black holes come from the Wide-Field Infrared Survey Explorer (<a href="http://wise.ssl.berkeley.edu/">WISE</a>), an orbiting telescope which was operated by NASA from 2009&ndash;2011. WISE took images of the entire sky at four infrared wavelengths: 3.4, 4,6, 12, and 22 micrometers. The images in Radio Galaxy Zoo come from the 3.4 micrometer band; these means that the galaxies we're looking at emit their light as a combination of cool stars, warm dust that's been heated by starlight, and emission from a supermassive black hole. The 175,000 WISE images have been matched to FIRST data from the VLA, and cover most of the Northern and Southern Galactic Cap regions."""
      p2: """Some additional infrared images come from the <a href="http://www.jpl.nasa.gov/missions/spitzer-space-telescope/">Spitzer Space Telescope</a>, an infrared observatory launched by NASA in 2003. It studies objects ranging from our own Solar System to the distant reaches of the Universe. In the early days of the <i>Spitzer</i> mission, the telescope was cryogenically cooled so that its three instruments (two cameras and a spectrograph) could observe the Universe at wavelengths from 3 to 180 micrometers. After its helium supply was exhausted in 2009, the telescope has continued to operate its IRAC camera in "Warm Mode", which it can do without the need for cryogenics."""
      p3: """The Spitzer infrared images you see in Radio Galaxy Zoo were taken as part of a program in this warm mode, called the Spitzer Wide-Area Infrared Extragalactic Survey (<a href="http://swire.ipac.caltech.edu//swire/swire.html">SWIRE</a>). These were taken with the IRAC camera at a wavelength of 3.6 micrometers. The observed wavelength is similar to the WISE images, but have a higher resolution and sensitivity (in part because Spitzer's mirror is bigger than WISE's). There are about 6,000 images from this survey in Radio Galaxy Zoo, each of which are matched to radio data from ATLAS"""
      p4: """<i>Spitzer</i> and WISE are both operated by <a href="http://www.nasa.gov/">NASA</a>."""
    comp:
      head: "Why can't computers do this task?"
      p1: """The jets visible in the radio wavelengths and the host galaxy visible in the optical wavelengths sometimes overlap. In this case, computer programs can tell automatically that they are associated with each other. This simple case is known to astronomers as a ‘compact source’. However, the matching becomes much more complex when we start to consider sitations where there is a great deal of mixed up radio emission or very complex arrangement sof multiple sources &mdash; as in the example above. """
      p2: """If we see three blobs of radio emission, that could either be three separate galaxies or a black hole and its two jets. It's possible for a human to tell by comparing the radio and infrared images – if the infrared shows three galaxies in a row, lining up with the respective radio spots, then it’s probably three separate galaxies. If the only infrared source is in the centre, then it’s probably a black hole and two jets. Computer programs cannot currently compete with the human brain for pattern recognition, especially if the radio emission is uneven or distorted."""
    ser:
      head: "Serendipitous Discoveries"
      p1: """A great bonus of having humans match these radio and infrared images of galaxies is the possibility of unexpected results. Computer programs only detect or measure what a human requires them too. Humans, on the other hand, are curious by nature and will question and explore unusual features that they see. Other citizen science projects built by the Zooniverse have lead to unexpected and amazing discoveries: this includes objects like <a href="http://en.wikipedia.org/wiki/Hanny%27s_Voorwerp">Hanny's Voorwerp</a> and the <a href="http://en.wikipedia.org/wiki/Pea_galaxy">Green Peas</a> in Galaxy Zoo, or the potentially new seaworm species discovered in Seafloor Explorer."""
      p2: """While examining the radio and infrared images, you will be often be asked if you want to ‘TALK’. This is our online discussion tool, where volunteers and the Radio Galaxy Zoo scientists can chat about things that interest them or they are unsure about. Feel free to ask about any image that piques your curiosity. It may be easy to explain, or it might just be something completely unexpected!"""
    sup:
      head: "How do supermassive black holes form?"
      p1: """Astronomers have plenty of evidence that small black holes (roughly a few times the mass of our Sun) form when a large star reaches the end of its life. We're less certain about how supermassive black holes (billions of times the size of our Sun) form and grow. We think that small black holes might merge together to form larger black holes. These larger black holes then swallow surrounding material, merge again with other black holes, and so on until they become the supermassive black holes we observe at the center of massive galaxies."""
      p2: """The problem is that this process of repeated black hole merging takes many billions of years, yet we’ve found evidence for supermassive black holes less than a billion years after the Big Bang! That's not enough time for them to have grown to the sizes we observe."""
      p3: """In order to better understand how supermassive black holes form, astronomers need more data. Ideally, they need information about black holes at all stages of their lives. So we want to identify as many black hole/jet pairs as possible and associate them with their host galaxies. With a large enough sample &mdash; from your classifications &mdash; we can pick out black holes at different stages and build a better picture of their origins."""
    gal:
      head: "Supermassive black holes and their host galaxies"
      p1: """There is strong circumstantial evidence that the supermassive black holes can change the rate at which stars form in their host galaxies. It is possible that the jets from the supermassive black hole heat up and disrupt the gas within the galaxy. This might either regulate the star formation rate by expelling and heating the gas; alternatively, it might compress the gas in some parts of the galaxy and actually increase the star formation rate. Our best understanding of which of these processes dominate galaxies will be helped with bigger samples of galaxies to observe, which we hope to get from your classifications."""
      p2: """The radio/infrared data on this site, combined with your clicks, will help us to better understand these objects and how they affect their host galaxies"""

  team:
    bios:
      ivy_wong: "Ivy wants to know what causes galaxies to start and stop forming stars.  She suspects that radio jets might have some role in this. Ivy is particularly interested in galaxies that have suddenly stopped forming stars (aka ‘post-starburst’ galaxies) and blue spheroidal galaxies."
      melanie_gendre: "Melanie worked on radio galaxy morphologies for her Ph.D. thesis, spending many hours doing exactly what you are doing.  By comparing them, Melanie tried to understand where the different types of shapes come from and what the effects are on the galaxies that host the radio jets.  But most of all, she enjoyed explaining to anyone who would hear why this is so very cool and is excited to share this with you. She is now working in education."
      julie_banfield: "Julie is interested in the evolution of radio galaxies and how they impact their surrounding environment as they grow. She is excited about Radio Galaxy Zoo as it will provide the necessary link between the radio emission and the host galaxy required to solve the puzzle of radio galaxy evolution."
      lucy_fortson: "Interested in galaxy evolution, black holes and the jets of material beaming from the centers of active galactic nuclei. Started the Zooniverse effort at the Adler Planetarium, now bringing the light to the University of Minnesota. On the odd weekend, when she's not preparing lectures or writing grants, Lucy can be found hanging out with her husband and son at one of Minneapolis' fine dining establishments."
      samuel_george: "Astronomer turned science educator"
      robert_hollow: "Robert is interested in how the public and schools students interact with and interpret radio astronomy data using citizen science &mdash; especially data sets from ASKAP and the SKA. He coordinates the PULSE@Parkes project where students use the Parkes radio telescope to observe pulsars."
      chris_lintott: "Runs the Zooniverse collaboration and works on how galaxies form and evolve; particularly interested in the effects of active galactic nuclei and mergers. In his 'spare' time, he hunts for planets, presents the BBC's long-running Sky at Night program and cooks."
      karen_masters: "Karen’s research uses data from large surveys to search for clues as to how galaxies form and evolve &mdash; she’s particularly worked on red spirals, and galactic bars in recent years using classifications from Galaxy Zoo. Karen has a background in radio astronomy (her first telescope was Arecibo) and is really excited to see Galaxy Zoo expand into radio frequencies."
      enno_middelberg: "Enno’s main interest is galaxy evolution and the role that Active Galactic Nuclei play. He has helped develop new observational methods to connect radio telescopes from all over the world (Very Long Baseline Interferometry, or VLBI) and to simultaneously observe hundreds of RGZ objects with these telescopes."
      ray_norris: "Ray researches how galaxies formed and evolved after the Big Bang, using radio, infrared, and optical telescopes. As a sideline, he also researches the astronomy of Australian Aboriginal people, frequently appears on radio and TV, and has recently published a novel, Graven Images."
      larry_rudnick: "Larry has been classifying radio galaxies since the mid-70s. He's saturated, and is thrilled with this effort to bring lots of fresh eyes to the massive new samples coming from modern radio telescopes."
      kevin_schawinski: "Kevin works on understanding the role of black holes in the Universe. He came to ETH via Yale University and Oxford, where he did his Ph.D. and was involved in the set-up of the original Galaxy Zoo. Kevin’s work focuses on trying to combine what we know about black holes and galaxies and trying to piece together a coherent story of whether and how the two co-evolve."
      nick_seymour: "Radio astronomer enjoying life down under and working on the largest radio survey with the Australian SKA Pathfinder, CSIRO." 
      stas_shabala: "Stas wants to know why radio galaxies come in so many different shapes, sizes and luminosities, and how they impact their surroundings. He also likes using the radio galaxies for super-accurate positioning on Earth, to help him track earthquakes and changing sea levels."
      kyle_willett: "Kyle has had a lot of experience with radio astronomy, but hasn’t done much of it since starting work with Galaxy Zoo &mdash; that's one reason he is excited about this project. Kyle’s particular scientific interest is in measuring the properties of the interstellar gas in the galaxies that you're helping to identify. In his spare time, he runs probably more than is healthy."
      laura_whyte: "As a former high school teacher and adult educator, with a Ph.D. in galaxy classification (seriously), joining the Zooniverse as an educator was a natural fit for Laura. Based at the Adler Planetarium in Chicago, she's working to encourage and support teachers to use Zooniverse citizen science projects in the classroom."
      kelly_borden: "Zooniverse and Adler Planetarium educator, museum nerd, accidental science enthusiast, lover of cats"
      heinz_andernach: "Heinz has been studying radio galaxies since the late 1970's, mainly those in clusters of galaxies. He compiled the largest collection of radio source lists to create a public database. He is interested in how diverse radio galaxies can be and how large they can grow."
      rob_simpson: "Rob is a researcher and web developer as well as Communications Lead for the Zooniverse. His background is in submillimetre astronomy so he's quite used to seeing the kind of 'fried eggs' that Radio Galaxy Zoo has to offer. Rob is also interested in the Zooniverse itself and the motivations of the hundreds of thousands of amazing people who come and classify on sites like Radio Galaxy Zoo. You can follow Rob online at orbitingfrog.com."
      amit_kapadia: "Amit develops astronomical web applications. He spends his days dreaming of conducting in-browser analyses on astronomical data sets. On occasion he flexes his modest sway to advocate for more modern solutions to data access in astronomy. He believes the scientific world needs to speak more closely with the tech world, and constantly strives to learn more from the latter."
      ed_paget: "Ed Paget joined Adler's Zooniverse team as a software developer in August 2012. He previously worked as a freelance programmer and photographer. Ed graduated from Northwestern University with a major in Radio/TV/Film."
      chris_snyder: "Chris is the technical project manager for the Zooniverse at the Adler Planetarium in Chicago. He works with developers and science teams to turn project ideas into a reality."
      brooke_simmons: "Brooke spends most of her time studying the growth of supermassive black holes and their role in galaxy evolution. She also suspects there is a parallel universe out there where she decided to become a potter and do astronomy on the side."
      anna_kapinska: "Anna is interested in radio galaxies and quasars at various stages of their life, from small young radio sources to large old radio galaxies. She works on radio jets and studies how they affect the galaxies which host them at various stages of the Universe’s evolution."
      sugata_kaviraj: "Works on the formation and evolution of galaxies, and the role black holes play in these processes."
    institutions:
      csiro: "CSIRO Astronomy and Space Science, Australia"
      jodrell: "Jodrell Bank Center for Astrophysics, UK"
      u_of_minnesota: "University of Minnesota, USA"
      u_of_birmingham: "University of Birmingham, UK"
      u_of_hertfordshire: "University of Hertfordshire, UK"
      max_planck: "Max-Planck-Institut für Radioastronomie, Germany"
      oxford: "Oxford University, UK"
      u_of_portsmouth: "Institute of Cosmology and Gravitation, University of Portsmouth, UK"
      ruhr: "Ruhr-University Bochum, Germany"
      eth: "ETH Institute for Astronomy, Switzerland"
      adler: "Adler Planetarium, USA"
      u_of_guanajuato: "University of Guanajuato, Mexico"
      u_of_w_aus: "University of Western Australia"
      u_of_tasmania: "University of Tasmania, Australia"
    titles:
      project_scientist: "Project Scientist"
      project_advisor: "Project Advisor"
      project_manager: "Project Manager"
      lead_developer: "Lead Developer"

  tutorial:
    nextButton: "Continue"
    welcome:
      header: "Welcome to Radio Galaxy Zoo!"
      details: "We’re going to show you two images of the same part of the sky, one from a radio telescope and one from an infrared telescope. \n \n In most images there are many infrared galaxies, but only some of these appear in the radio."
    wavelengths: 
      header: "Different Wavelengths"
      details: "Here are two galaxies seen at radio wavelengths - one small one lower down and one large, double-lobed object in the centre. We use contours to show their radio brightness. \n \n To see how the galaxies appear in the infrared, move the slider over to the IR position. The goal is to match up the radio contours to their galaxy images in the IR."
    classify1:
      header: "Pairing the Data"
      details: "Let’s do the easy galaxy first: pick the smaller object by clicking on its contours then click 'Done'."
    classify2:
      header: "Pairing the Data"
      details: "Select it in the infrared too. Use the slider to compare the two. In this case the galaxy is at exactly the same position in both wavelengths."
    classify3:
      header: "Pairing the Data"
      details: "Now click 'Done'"
    classify4:
      header: "Pairing a Second Source."
      details: "Now let's mark the other Galaxy. First select 'Mark Another'."
    classify5:
      header: "Pairing a Second Source."
      details: "Then click on the first group of contours of the brighter Galaxy." 
    classify525:
      header: "Pairing a Second Source."
      details: "Next click on the second group of contours of the Galaxy. Then click on 'Done'."
    classify55:
      header: "Pairing a Second Source."
      details: "Next click on the second contour of the Galaxy. Then click on 'Done'."
    classify6:
      header: "Pairing Second Source."
      details: "When you check the infrared you’ll see a galaxy between the two bright radio ‘lobes’. Click that galaxy and select 'Done'."
    classify8:
      header: "Finish Marking."
      details: "That's all the pairs in this image. Click 'Finish' to advance."
    que:
      header: "What's Going on?"
      details: "The large, bright radio object shows us where two jets were emitted by a supermassive black hole at center of that galaxy. The fainter radio object shows emission from newly-formed stars in the galaxy." 
    guide:
      header: "More Objects"
      details: "You can see many more examples in the ‘Guide’, showing how the science team marked more complex objects."
    next: 
      header: "Next"
      details: "You can favourite images to see again later, or discuss images with the community on our forum, Talk. \n \n Click ‘Next’ to move on to the next image. "
