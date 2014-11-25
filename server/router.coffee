
server = require 'ws-json-server'

server.listen 3000, (ws) ->

  # login before one can access
  ws.on 'auth', (msg) ->
    auth.handle

  # operations on store
  ws.on 'store', (msg) ->
    store.handle msg

  # syncs user state to server
  ws.on 'state', ->

  # report thing of
  ws.on 'report', ->

  # send whole user state
  ws.emit 'sync', ->