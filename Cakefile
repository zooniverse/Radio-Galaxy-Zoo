{print} = require 'util'
{spawn} = require 'child_process'


task 'server', 'Watch src/ for changes', ->
  coffee = spawn 'node_modules/.bin/coffee', ['-w', '-c', '-o', 'server/', 'server/']
  nodemon = spawn 'node_modules/.bin/nodemon', ['server/server.js']
  
  for p in [coffee, nodemon]
    p.stderr.on 'data', (data) ->
      process.stderr.write data.toString()
    p.stdout.on 'data', (data) ->
      print data.toString()