# Run script to get versioned dependencies

mkdir -vp app/lib

curl -k "https://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.js" -o "app/lib/angular.js"
curl -k "https://raw.github.com/astrojs/fitsjs/v0.5.0/lib/fits.js" -o "app/lib/fits.js"
curl -k "https://raw.github.com/jasondavies/conrec.js/361f86be3b1a2c46a228233d6e902926ca530213/conrec.js" -o "app/lib/conrec.js"
curl -k "https://raw.github.com/fryn/html5slider/09d19a1067ada41eb3e74cb011f9fd237117dc74/html5slider.js" -o "app/lib/html5slider.js"
curl -k "https://raw.github.com/kangax/fabric.js/v1.2.0/dist/all.js" -o "app/lib/fabric.js"