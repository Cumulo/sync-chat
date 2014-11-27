
server = require 'ws-json-server'
shortid = require 'shortid'

store = require './controller/store'
state = require './model/state'
account = require './controller/account'

client = require './view/'

server.listen 3000, (ws) ->

  socketId = shortid.generate()

  # login before one can access
  ws.on 'account', (msg) ->
    account.handle socketId, msg

  # operations on store
  ws.on 'store', (msg) ->
    store.handle msg

  # syncs user state to server
  ws.on 'state', (msg) ->
    # states are special, clients update them directly
    state.handle socketId, msg

  # report thing of
  ws.on 'report', (msg) ->
    report.handle msg

  # send whole user state