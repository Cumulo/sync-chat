
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

exports.patchClient = (sid) ->
  state = states[sid]
  diff = jiff state.cachePreview, data
  if diff?
    data = render sid
    state.cachePreview = data
    sender.patchPreview diff

exports.syncClient = (sid) ->
  sender.syncPreview states[sid].cachePreview