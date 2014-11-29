
lodash = require 'lodash'
# model
states = require '../model/states'
# view
clients = require '../view/clients'
preview = require '../view/preview'

exports.update = (sid, data) ->
  state = states[sid]
  lodash.merge state, data
  clients.syncClient sid
  preview.syncClient sid
