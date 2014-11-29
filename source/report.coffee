
local =
  ws: null

exports.register = (ws) ->
  local.ws = ws

exports.emit = (data) ->
  raw = JSON.stringify data
  ws.send raw

exports.syncStore = ->
  data =
    scope: 'store'
    action: 'sync'
  @emit data

exports.syncPreview = ->
  data =
    scope: 'preview'
    action: 'sync'
  @emit data