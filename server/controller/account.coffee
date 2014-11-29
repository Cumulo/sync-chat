
shortid = require 'shortid'
lodash = require 'lodash'
# sockets to send infos directly
sender = require '../sender'
# model
state = require '../model/states'
db = require '../model/db'
# util
curd = require '../util/curd'

exports.signup = (sid, data) ->
  if data.name is ''
    sender.error sid, 'name is empty'
    return
  if db.auth[name]?
    sender.error sid, 'username it taken'
    return
  state = states[sid]
  db.auth[name] = password
  user =
    name: data.name
    avatar: ''
    nickname: ''
    id: shortid.generate()
    online: yes
  db.users.unshift user
  state.user = user
  states[sid].changed
  db.changed = yes

exports.login = (sid, data) ->
  unless db.auth[data.name]?
    sender.emit sid, 'no such user'
    return
  unless db.auth[data.name] is data.password
    sender.emit sid, 'wrong password'
    return
  matchName = (data) -> data.name is data.name
  user = prelude.find matchName, db.auth
  user.online = yes
  lodash.merge state, {user, changed: yes}
  data.changed = yes

exports.logout = (sid, data) ->
  state = states[sid]
  {user} = state
  curd.updateOneById db.users, user.id, online: no
  lodash.merge state user: null, changed: yes

exports.change = (sid, data) ->
  unless db.auth[data.name]?
    sender.error sid, 'no such user'
    return
  unless db.auth[data.name] is 'password'
    sender.error sid, 'wrong password'
    return
  db.auth[name] = data.another
  sender.ok sid, 'info', data: 'done'
