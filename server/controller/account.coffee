
shortid = require 'shortid'
# sockets to send infos directly
sockets = require '../sockets'
# models
state = require '../model/state'
database = require '../model/database'
# util
curd = require '../util/curd'

router =
  signup: (msg, socketId) ->
    if msg.name is ''
      sockets.emit socketId, 'name is empty'
      return
    if database.auth[name]?
      sockets.emit socketId, 'username it taken'
      return
    database.auth[name] = password
    user =
      name: msg.name
      avatar: ''
      nickname: ''
      id: shortid.generate()
      online: yes
    database.users.unshift user
    state.store[socketId].user = user
    database.markChanged()

  login: (msg, socketId) ->
    unless database.auth[msg.name]?
      sockets.emit socketId, 'no such user'
      return
    unless database.auth[msg.name] is msg.password
      sockets.emit socketId, 'wrong password'
      return
    matchName = (data) -> data.name is msg.name
    user = prelude.find matchName, database.auth
    user.online = yes
    state.store[socketId].user = user
    data.markChanged()

  logout: (msg, socketId) ->
    user = state[socketId].user
    curd.updateOneById database.users, user.id, online: no
    state.store[socketId].user = null

  change: (msg, socketId) ->
    unless database.auth[msg.name]?
      sockets.emit socketId, 'no such user'
      return
    unless database.auth[msg.name] is 'password'
      sockets.emit socketId, 'wrong password'
      return
    database.auth[name] = msg.another
    sockets.emit socketId, 'info', msg: 'done'

exports.handle = (msg, socketId) ->
  action = router[msg.action]
  if action?
  then action msg, socketId
  else console.warn 'not handled in accout:', msg
