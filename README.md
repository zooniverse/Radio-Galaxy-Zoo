
# Radio Galaxy Zoo
  
    # Run to get development dependencies
    npm install
    
    # Run to get javascript dependencies
    ./setup.sh
    
    # Run application on a local web server
    npm start


## Steps Before Launching App with New Data

#### Contour Levels

Contours are computed against an array defining various binning levels. This array should be changed when another radio survey is ingested into the project. Consult the science team to determine the values needed for a particular radio survey. This array may be updated in `index.coffee`.

    RadioGalaxyZoo.contours("levels", [3.0, ..., 6561])

#### Contour Threshold

A threshold is applied to filter out contours that may represent noise. This is a tunable parameter that depends on the radio survey, and should be updated when the project uses a new survey. Update this value in `index.coffee`, and it will propagate through the rest of the application.

    RadioGalaxyZoo.constant("contourThreshold", 8)

The value, with units of pixels, represents the diagonal of the bounding box surrounding the lowest level contour. This value should be derived from the field of view of the radio image.

#### FITS Image Dimension

FITS images are used to compute contours on the fly. This allows direct interaction with contours, as opposed to annotating over a rasterized representation. As a result, the dimension of the FITS image must be recorded in the app so that contours are scaled according to the image size. This dimension should be updated if a new radio survey uses FITS images of a different dimension. Update the value in `index.coffee`:

    RadioGalaxyZoo.constant("fitsImageDimension", 301)

#### FITS Compression

The FITS images sent to the client are roughly 1 MB in size. To reduce the data transfer, it's best to gzip all FITS files, and upload to S3 with the correct encoding, and a spoofed MIME type. The `Makefile` described below gzips all FITS during processing.
    
    gzip -9 some-binary-file.fits > some-binary-file.fits.gz
    s3cmd put some-binary-file.gz s3://some-s3-bucket/ --mime-type "application/json" --add-header "Content-Encoding: gzip" --acl-public

## Data Preparation

There is a `Makefile` in the `scripts` directory for preparing Radio Galaxy Zoo subjects. This `Makefile` provides functions that operate on `rgz.tar.gz` and `rgz_fits.tar.gz`, which are to be delivered by the Science Team.

The `Makefile` runs the following operations over the data:
  
  * Decompresses the tarballs
  * Process FITS infrared to PNGs without contours using `make_infrared_pngs.py`
  * Resizes radio PNGs using Imagemagick
  * Clean all radio FITS headers by removing unnecessary HISTORY keywords
  * GZIP all radio FITS that are to be served to volunteers
  * Converts PNGs to JPGs (an Automator Workflow is used to utilized Preview's export for a better compression compared to Imagemagick)

To process infrared subjects:

    make infrared

To process radio subjects:

    make radio

To process radio FITS subjects:

    make raw

To process the entire subject set:

    make

