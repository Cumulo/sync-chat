
jsondiffpatch = require 'jsondiffpatch'
# util
time = require '../util/time'
# model
states = require '../model/states'
# browser interface
sender = require '../sender'
# world provides data that is pre-rendered
world = require('../scene/world')

render = (sid) ->
  state = states[sid]
  allThreads = world.get().threads or []
  allMessages = world.get().messages[state.user.thread] or []
  threadLen = state.threadPage * state.pageStep
  messageLen = state.messagePage * state.pageStep
  # generates store
  user: state.user
  threads: allThreads[...threadLen]
  messages: allMessages[...messageLen]

exports.patch = (sid) ->
  state = states[sid]
  data = render sid
  diff = jsondiffpatch.diff state.cacheStore, data
  if diff?
    state.cacheStore = data
    sender.patchStore sid, diff

exports.sync = (sid) ->
  state = states[sid]
  sender.syncStore sid, state.cacheStore
