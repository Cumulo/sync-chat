
collections = {}

exports.register = (sid, ws) ->
  collections[sid] = ws

exports.unregister = (sid) ->
  collections[sid] = null
  delete collections[sid]

exports.emit = (sid, data) ->
  ws = collections[sid]
  if ws?
  then ws.send (JSON.stringify data)
  else console.warn 'no ws for sid:', sid

# actions

exports.info = (sid, data) ->
  @emit sid, data

exports.error = (sid, data) ->
  data.type = 'error'
  @info sid, data

exports.ok = (sid, data) ->
  data.type = 'ok'
  @info sid, data

exports.patchStore = (sid, data) ->

exports.patchPreview = (sid, data) ->

exports.syncStore = (sid, msg) ->

exports.syncPreview = (sid, data) ->