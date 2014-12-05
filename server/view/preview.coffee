
lodash = require 'lodash'
prelude = require 'prelude-ls'
jsondiffpatch = require 'jsondiffpatch'
# model
states = require '../model/states'
# util
time = require '../util/time'
filters = require '../util/filters'
# browser interface
sender = require '../sender'
# scene
whispers = require('../scene/whispers')
world = require '../scene/world'

diffpatch = jsondiffpatch.create
  objectHash: (obj) -> obj.id

render = (thread) ->
  text: whispers.get()[thread]

exports.patch = (sid) ->
  state = states[sid]
  users = world.get().users
  user = prelude.find (filters.matchId state.userId), users
  data = render user.thread
  diff = diffpatch.diff state.cachePreview, data
  console.log JSON.stringify(diff, null, 2)
  if diff?
    state.cachePreview = data
    sender.patchPreview sid, diff

exports.sync = (sid) ->
  sender.syncPreview sid, states[sid].cachePreview