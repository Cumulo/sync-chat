
local =
  ws: null

exports.register = (ws) ->
  local.ws = ws

exports.emit = (data) ->
  raw = JSON.stringify data
  local.ws.send raw

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

exports.login = (name, password) ->
  data =
    scope: 'account'
    action: 'login'
    name: name
    password: password
  @emit data

exports.signup = (name, password) ->
  data =
    scope: 'account'
    action: 'signup'
    name: name
    password: password
  @emit data
