
lodash = require 'lodash'
# model
states = require '../model/states'
# view
clients = require '../view/clients'
preview = require '../view/preview'

exports.update = (sid, data) ->
  state = states[sid]
  lodash.merge state, data
  clients.patch sid
  preview.patch sid

exports.morePage = (sid, data) ->
  state = states[sid]
  state.messagePage += 1
  clients.patch sid