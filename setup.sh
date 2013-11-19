# Run script to get versioned dependencies

mkdir -vp app/lib
mkdir -vp css/zooniverse

curl --fail -k "http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.js" -o "app/lib/jquery.js"
curl --fail -k "https://raw.github.com/jashkenas/underscore/1.5.1/underscore.js" -o "app/lib/underscore.js"
curl --fail -k "https://ajax.googleapis.com/ajax/libs/angularjs/1.2.0-rc.3/angular.js" -o "app/lib/angular.js"
curl --fail -k "http://code.angularjs.org/1.2.0-rc.3/angular-route.js" -o "app/lib/angular-route.js"
curl --fail -k "https://raw.github.com/astrojs/fitsjs/af64b69b5eae3b2599d39f33e984d13128b3384d/lib/fits.js" -o "app/lib/fits.js"
curl --fail -k "https://raw.github.com/fryn/html5slider/09d19a1067ada41eb3e74cb011f9fd237117dc74/html5slider.js" -o "app/lib/html5slider.js"

curl --fail -k "https://raw.github.com/twbs/bootstrap/v3.0.0/dist/css/bootstrap.css" -o "css/bootstrap.css"
curl --fail -k "https://raw.github.com/zooniverse/Zooniverse/959f413dd2493a9a3cdb6bcdc4e9e184aad123a2/css/dialog.css" -o "css/zooniverse/dialog.css"
curl --fail -k "https://raw.github.com/zooniverse/Zooniverse/959f413dd2493a9a3cdb6bcdc4e9e184aad123a2/css/footer.css" -o "css/zooniverse/footer.css"
curl --fail -k "https://raw.github.com/zooniverse/Zooniverse/959f413dd2493a9a3cdb6bcdc4e9e184aad123a2/css/profile.css" -o "css/zooniverse/profile.css"
curl --fail -k "https://raw.github.com/zooniverse/Zooniverse/959f413dd2493a9a3cdb6bcdc4e9e184aad123a2/css/top-bar.css" -o "css/zooniverse/top-bar.css"
curl --fail -k "https://raw.github.com/zooniverse/Zooniverse/959f413dd2493a9a3cdb6bcdc4e9e184aad123a2/css/zooniverse.css" -o "css/zooniverse/zooniverse.css"

curl --fail -k "https://raw.github.com/brian-c/zootorial/ce1120bc3d83247f3462abddbaf3430848f29ba4/zootorial.js" -o "app/lib/zootorial.js"
curl --fail -k "https://raw.github.com/brian-c/zootorial/ce1120bc3d83247f3462abddbaf3430848f29ba4/zootorial.css" -o "css/zooniverse/zootorial.css"