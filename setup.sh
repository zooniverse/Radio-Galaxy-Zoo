# Run script to get versioned dependencies

mkdir -vp app/lib

curl -k "https://ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular.js" -o "app/lib/angular.js"
curl -k "https://raw.github.com/astrojs/fitsjs/8721bba7f018f8163fbd2b07364c496a8ee77bda/lib/fits.js" -o "app/lib/fits.js"
curl -k "https://raw.github.com/jasondavies/conrec.js/361f86be3b1a2c46a228233d6e902926ca530213/conrec.js" -o "app/lib/conrec.js"
curl -k "https://raw.github.com/fryn/html5slider/09d19a1067ada41eb3e74cb011f9fd237117dc74/html5slider.js" -o "app/lib/html5slider.js"
curl -k "https://raw.github.com/mbostock/d3/v3.2.8/d3.js" -o "app/lib/d3.js"
curl -k "http://cdn.popcornjs.org/code/dist/popcorn-complete.js" -o "app/lib/popcorn-complete.js"

curl -k "https://raw.github.com/twbs/bootstrap/v3.0.0/dist/css/bootstrap.css" -o "css/bootstrap.css"