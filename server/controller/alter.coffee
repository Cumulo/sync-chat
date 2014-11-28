
lodash = require 'lodash'
# model
states = require '../model/states'

exports.update = (sid, data) ->
  state = states[sid]
  lodash.merge state, data
  state.changed = yes

exports.moreMessage = (sid, data) ->

exports.moreThread = (sid, data) ->
