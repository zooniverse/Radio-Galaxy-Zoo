exports.config =
  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^(bower_components|vendor)/

    stylesheets:
      joinTo:
        'css/app.css' : /^app\/styles/
        'css/vendor.css' : /^(bower_components|vendor)/

    templates:
      joinTo: 'js/app.js'
