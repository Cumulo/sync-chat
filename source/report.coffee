
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
  @emit
    scope: 'clients'
    action: 'sync'

exports.syncPreview = ->
  @emit
    scope: 'preview'
    action: 'sync'

exports.login = (name, password) ->
  @emit
    scope: 'account'
    action: 'login'
    name: name
    password: password
  session.set {name, password}

exports.signup = (name, password) ->
  @emit
    scope: 'account'
    action: 'signup'
    name: name
    password: password

exports.submitPreview = (text) ->
  @emit
    scope: 'whisper'
    action: 'preview'
    text: text

exports.submitText = (text) ->
  @emit
    scope: 'message'
    action: 'create'
    text: text

exports.updateProfile = (data) ->
  @emit
    scope: 'profile'
    action: 'update'
    nickname: data.nickname
    avatar: data.avatar