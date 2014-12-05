
jsondiffpatch = require 'jsondiffpatch'
prelude = require 'prelude-ls'
# util
time = require '../util/time'
filters = require '../util/filters'
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
  userId = state.userId
  unless userId?
    # nothing to render when not logined
    return {}
  users = world.get().users
  user = prelude.find (filters.matchId userId), users
  allThreads = world.get().threads or []
  allMessages = world.get().messages[user.thread] or []
  threadLen = state.threadPage * state.pageStep
  messageLen = state.messagePage * state.pageStep
  console.log world.get().messages
  console.log allMessages.map (x) -> x.time
  # generates store
  user: user
  threads: allThreads[...threadLen]
  messages: allMessages[...messageLen]

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
