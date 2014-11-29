
jiff = require 'jiff'
# util
time = require '../util/time'
# model
states = require '../model/states'
# browser interface
sender = require '../sender'
# world provides data that is pre-rendered
world = require('../scene/world').get()

render = (sid) ->
  state = states[sid]
  threadLen = state.threadPage * state.pageStep
  messageLen = state.messagePage * state.pageStep
  user: state.user
  threads: world.threads[...threadLen]
  messages: world.messages[sid][...messageLen]

exports.patchClient = (sid) ->
  state = states[sid]
  data = render sid
  diff = jiff state.cacheStore, data
  if diff
    @state.cacheStore = data
    sender.patchStore diff

exports.syncClient = (sid) ->
  state = states[sid]
  sender.syncStore state.cacheStore