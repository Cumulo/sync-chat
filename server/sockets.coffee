
collections = {}

exports.record = (socketId, ws) ->
  collections[socketId] = ws

exports.deprecate = (socketId) ->
  collections[socketId] = null
  delete collections[socketId]

exports.emit = (socketId, type, msg) ->
  ws = collections[socketId]
  if ws?
  then ws.emit type, msg
  else console.warn 'no ws for socketId:', socketId