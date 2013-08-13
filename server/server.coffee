express = require('express')
http = require('http')

PORT = 9000

app = express()
server = http.createServer(app)
server.listen(PORT)

subjects = require './test-subjects.json'
keys = Object.keys(subjects)

app.all('/', (req, res, next) ->
  res.header("Access-Control-Allow-Origin", "*")
  res.header('Access-Control-Allow-Methods', "GET,PUT,POST,DELETE")
  res.header("Access-Control-Allow-Headers", "X-Requested-With")
  next()
)

app.get "/", (req, res, next) ->
  
  randomIndex = Math.floor(Math.random() * keys.length)
  key = keys[randomIndex]
  
  console.log "Serving subject #{key}"
  subject = subjects[key]
  res.json(subject)