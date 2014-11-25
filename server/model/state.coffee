
# in-memory
database =
  # in pairs of userId->previewData
  store: {}
  changed: no

exports.update = (userId, data) ->
  {store} = database
  unless store[userId]?
    state = store[userId] = {}
  for key, value of data
    state[key] = value
  database.changed = yes

exports.withThreadId = (userId, threadId) ->
  states = []
  for userId, state of data.store
    if state.threadId is threadId
      states.push state
  states

exports.newTick = ->
  database.changed = no