
# in-memory
database =
  # in pairs of socketId->previewData
  store: {}
  sockets: {}
  changed: no

exports.handle = (socketId, data) ->
  {store} = database
  unless store[socketId]?
    state = store[socketId] = {}
  for key, value of data
    state[key] = value
  database.changed = yes

exports.markChanged = ->
  database.changed = yes

exports.newTick = ->
  database.changed = no

exports.getStore = ->
  database