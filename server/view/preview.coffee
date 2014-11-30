
lodash = require 'lodash'
prelude = require 'prelude-ls'
jiff = require 'jiff'
# model
states = require '../model/states'
# util
time = require '../util/time'
# browser interface
sender = require '../sender'
# scene
whispers = require('../scene/whispers').get()

render = (sid) ->
  whispers[sid]

exports.patch = (sid) ->
  state = states[sid]
  diff = jiff state.cachePreview, data
  if diff?
    data = render sid
    state.cachePreview = data
    sender.patchPreview sid, diff

exports.sync = (sid) ->
  sender.syncPreview sid, states[sid].cachePreview