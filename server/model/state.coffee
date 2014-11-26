
# in-memory
database =
  # in pairs of socketId->previewData
  store: {}
  changed: no

exports.create = (socketId, data) ->
  {store} = database
  if store[socketId]?
    @update socketId, data
  else
    store[socketId] = data

exports.clearWithSocketId = (socketId) ->
  store[threadId] = null
  database.changed = yes

exports.update = (socketId, data) ->
  {store} = database
  unless store[socketId]?
    state = store[socketId] = {}
  for key, value of data
    state[key] = value
  database.changed = yes

exports.withThreadId = (threadId) ->
  states = []
  for userId, state of database.store
    if state.threadId is threadId
      states.push state
  states

exports.withSocketId = (socketId) ->
  database.store[socketId]

exports.newTick = ->
  database.changed = no
