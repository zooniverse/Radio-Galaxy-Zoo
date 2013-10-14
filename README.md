
# Radio Galaxy Zoo
  
    # Run to get development dependencies
    npm install
    
    # Run to get javascript dependencies
    ./setup.sh
    
    # Run application on a local web server
    npm start
    

# TODO
  
  * Bolder contours on example images
  * Add "Tutorial" button to trigger tutorial whenever
  * Back button?
  * Position tutorial box in less obtrusive place
  * Set up Google Analytics
  * Permit multiple IR identifications (limit to 3, 4, 5?)
  
# BUGS
  
  * Home page formatting hides image if screen width is too small
  * Classification page needs better formatting for smaller devices
  
  
# Data Preparation

    python make_png.py ../data-import/rgz_fits/

