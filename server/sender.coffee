
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
  @emit
    scope: 'store'
    action: 'patch'
    data: data

exports.patchPreview = (sid, data) ->
  @emit
    scope: 'preview'
    action: 'patch'
    data: data

exports.syncStore = (sid, msg) ->
  @emit
    scope: 'store'
    action: 'sync'
    data: data

exports.syncPreview = (sid, data) ->
  @emit
    scope: 'preview'
    action: 'sync'
    data: data
