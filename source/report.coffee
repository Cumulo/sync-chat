
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
  raw = JSON.stringify data, null, 2
  local.ws.send raw

exports.syncStore = ->
  data =
    scope: 'clients'
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

exports.submitPreview = (text) ->
  data =
    scope: 'whisper'
    action: 'preview'
    text: text
  @emit data

exports.submitText = (text) ->
  data =
    scope: 'message'
    action: 'create'
    text: text
  @emit data
