# Run script to get versioned dependencies

mkdir -vp app/lib
mkdir -vp css/zooniverse

curl -k "http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.js" -o "app/lib/jquery.js"
curl -k "https://raw.github.com/jashkenas/underscore/1.5.1/underscore.js" -o "app/lib/underscore.js"
curl -k "https://ajax.googleapis.com/ajax/libs/angularjs/1.2.0-rc.3/angular.js" -o "app/lib/angular.js"
curl -k "http://code.angularjs.org/1.2.0-rc.3/angular-route.js" -o "app/lib/angular-route.js"
curl -k "https://github.com/astrojs/fitsjs/blob/af64b69b5eae3b2599d39f33e984d13128b3384d/lib/fits.js" -o "app/lib/fits.js"
curl -k "https://raw.github.com/jasondavies/conrec.js/361f86be3b1a2c46a228233d6e902926ca530213/conrec.js" -o "app/lib/conrec.js"
curl -k "https://raw.github.com/fryn/html5slider/09d19a1067ada41eb3e74cb011f9fd237117dc74/html5slider.js" -o "app/lib/html5slider.js"

curl -k "https://raw.github.com/twbs/bootstrap/v3.0.0/dist/css/bootstrap.css" -o "css/bootstrap.css"
curl -k "https://github.com/zooniverse/Zooniverse/blob/959f413dd2493a9a3cdb6bcdc4e9e184aad123a2/css/dialog.css" -o "css/zooniverse/dialog.css"
curl -k "https://raw.github.com/zooniverse/Zooniverse/959f413dd2493a9a3cdb6bcdc4e9e184aad123a2/css/footer.css" -o "css/zooniverse/footer.css"
curl -k "https://raw.github.com/zooniverse/Zooniverse/959f413dd2493a9a3cdb6bcdc4e9e184aad123a2/css/profile.css" -o "css/zooniverse/profile.css"
curl -k "https://raw.github.com/zooniverse/Zooniverse/959f413dd2493a9a3cdb6bcdc4e9e184aad123a2/css/top-bar.css" -o "css/zooniverse/top-bar.css"
curl -k "https://raw.github.com/zooniverse/Zooniverse/959f413dd2493a9a3cdb6bcdc4e9e184aad123a2/css/zooniverse.css" -o "css/zooniverse/zooniverse.css"

curl -k "https://raw.github.com/brian-c/zootorial/c07c536a20145c10ec2801712276f84c6fea17f3/zootorial.js" -o "app/lib/zootorial.js"
curl -k "https://raw.github.com/brian-c/zootorial/c07c536a20145c10ec2801712276f84c6fea17f3/zootorial.css" -o "css/zooniverse/zootorial.css"