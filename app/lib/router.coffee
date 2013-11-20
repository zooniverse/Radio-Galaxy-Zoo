class Router extends Backbone.Router
  routes: {
    "" : "index"
    "classify(/)" : "classify"
    "science(/)" : "science"
    "science/:category(/)" : "science"
    "team(/)" : "team"
    "profile(/)" : "profile"
  }

module.exports = Router
