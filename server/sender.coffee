
shortid = require 'shortid'

collections = {}

exports.register = (sid, ws) ->
  collections[sid] = ws

exports.unregister = (sid) ->
  collections[sid] = null
  delete collections[sid]

exports.emit = (sid, data) ->
  ws = collections[sid]
  if ws?
  then ws.send (JSON.stringify (data or null))
  else console.warn 'no ws for sid:', sid

# actions

exports.info = (sid, data) ->
  data.scope = 'info'
  data.id = shortid.generate()
  @emit sid, data

exports.error = (sid, text) ->
  data =
    type: 'error'
    text: text
  @info sid, data

exports.ok = (sid, data) ->
  data.type = 'ok'
  @info sid, data

exports.patchStore = (sid, data) ->
  @emit sid,
    scope: 'store'
    action: 'patch'
    data: data

exports.patchPreview = (sid, data) ->
  @emit sid,
    scope: 'preview'
    action: 'patch'
    data: data

exports.syncStore = (sid, data) ->
  @emit sid,
    scope: 'store'
    action: 'sync'
    data: data or null

exports.syncPreview = (sid, data) ->
  @emit sid,
    scope: 'preview'
    action: 'sync'
    data: data or null
