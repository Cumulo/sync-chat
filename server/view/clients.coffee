
jsondiffpatch = require 'jsondiffpatch'
prelude = require 'prelude-ls'
# util
time = require '../util/time'
# model
states = require '../model/states'
# browser interface
sender = require '../sender'
# world provides data that is pre-rendered
world = require('../scene/world')

diffpatch = jsondiffpatch.create
  objectHash: (obj) -> obj.id

render = (sid) ->
  state = states[sid]
  if state.userId?
    matchId = (obj) -> obj.id is state.userId
    user = prelude.find matchId, world.get().users
    allThreads = world.get().threads or []
    allMessages = world.get().messages[user.thread] or []
    threadLen = state.threadPage * state.pageStep
    messageLen = state.messagePage * state.pageStep
    # generates store
    user: user
    threads: allThreads[...threadLen]
    messages: allMessages[...messageLen]
  else
    # empty
    user: null
    threads: []
    messages: []

exports.patch = (sid) ->
  state = states[sid]
  data = render sid
  diff = diffpatch.diff state.cacheStore, data
  if diff?
    state.cacheStore = data
    sender.patchStore sid, diff

exports.sync = (sid) ->
  state = states[sid]
  sender.syncStore sid, state.cacheStore
