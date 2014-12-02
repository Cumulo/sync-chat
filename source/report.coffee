
# use session to recall last login
session = require './store/session'

local =
  ws: null

exports.register = (ws) ->
  local.ws = ws

  data = session.get()
  if data.name? and data.password?
    @login data.name, data.password

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
  session.set {name, password}

exports.signup = (name, password) ->
  data =
    scope: 'account'
    action: 'signup'
    name: name
    password: password
  @emit data
