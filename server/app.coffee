
Server = require('ws').Server
shortid = require 'shortid'

# model
states = require './model/states'
whispers = require './model/whispers'
# interface
router = require './router'
sender = require './sender'
# view
clients = require './view/clients'
preview = require './view/preview'

wss = new Server port: 3000

wss.on 'connection', (ws) ->
  # initialize profile
  # sid refers to socket-id used all over the app
  sid = shortid.generate()
  states[sid] =
    threadPage: 1
    messagePage: 1
    pageStep: 10
    cacheStore: {}
    cachePreview: {}
  whispers.typing[sid] = {}

  # so sender can send messages directly
  sender.register sid, ws
  ws.on 'close', ->
    console.log 'socket close', sid
    sender.unregister sid
    # force remove socket
    states[sid] = null

  # decode data from messages
  ws.on 'message', (raw) ->
    data = JSON.parse raw
    router.handle sid, data

  # initialize data
  clients.sync sid
  preview.sync sid
