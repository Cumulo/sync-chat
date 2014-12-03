
lodash = require 'lodash'
prelude = require 'prelude-ls'
jsondiffpatch = require 'jsondiffpatch'
# model
states = require '../model/states'
# util
time = require '../util/time'
# browser interface
sender = require '../sender'
# scene
whispers = require('../scene/whispers')

render = (thread) ->
  text: whispers.get()[thread]

exports.patch = (sid) ->
  state = states[sid]
  data = render state.user.thread
  diff = jsondiffpatch.diff state.cachePreview, data
  if diff?
    state.cachePreview = data
    sender.patchPreview sid, diff

exports.sync = (sid) ->
  sender.syncPreview sid, states[sid].cachePreview