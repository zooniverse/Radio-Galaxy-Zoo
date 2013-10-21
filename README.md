
# Radio Galaxy Zoo
  
    # Run to get development dependencies
    npm install
    
    # Run to get javascript dependencies
    ./setup.sh
    
    # Run application on a local web server
    npm start


## Steps Before Launching New Data

#### Contour Threshold

A threshold is applied to filter out contours that may represent noise. This is a tunable parameter that depends on the radio survey, and should be updated when the project uses a new survey. Update this value in `index.coffee`, and it will propagate through the rest of the application.

    RadioGalaxyZoo.constant("contourThreshold", 8)

The value, with units of pixels, represents the diagonal of the bounding box surrounding the lowest level contour. This value should be derived from the field of view of the radio image.

#### FITS Image Dimension

FITS images are used to compute contours on the fly. This allows direct interaction with contours, as opposed to annotating over a rasterized representation. As a result, the dimension of the FITS image must be recorded in the app so that contours are scaled according to the image size. This dimension should be updated if a new radio survey uses FITS images of a different dimension. Update the value in `index.coffee`:

    RadioGalaxyZoo.constant("fitsImageDimension", 301)

## TODO
  
  * Bolder contours on example images
  * Add "Tutorial" button to trigger tutorial whenever
  * Back button?
  * Position tutorial box in less obtrusive place
  
## BUGS
  
  * Home page formatting hides image if screen width is too small
  * Classification page needs better formatting for smaller devices
  
  
# Data Preparation

    python make_png.py ../data-import/rgz_fits/

