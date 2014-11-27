
Server = require('ws').Server
shortid = require 'shortid'

states = require './store/states'
router = require './router'
sender = require './sender'

wss = new Server port: 3000

wss.on 'connection', (ws) ->
  # initialize profile
  # sid refers to socket-id used all over the app
  sid = shortid.generate()
  states[sid] = {}

  # so sender can send messages directly
  sender.register sid, ws
  ws.on 'close', ->
    sender.unregister sid

  # decode data from messages
  ws.on 'messages', (raw) ->
    data = JSON.parse raw
    router.handle sid, data
