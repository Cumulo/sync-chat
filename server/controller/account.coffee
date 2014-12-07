
shortid = require 'shortid'
lodash = require 'lodash'
prelude = require 'prelude-ls'
# sockets to send infos directly
sender = require '../sender'
# model
states = require '../model/states'
db = require '../model/db'
# util
curd = require '../util/curd'

exports.signup = (sid, data) ->
  if data.name is ''
    sender.error sid, 'name is empty'
    return
  if db.auth[data.name]?
    sender.error sid, 'username it taken'
    return
  db.auth[data.name] = data.password
  user =
    name: data.name
    avatar: ''
    nickname: ''
    id: shortid.generate()
    thread: 'default'
    online: yes
  db.users.unshift user
  state = states[sid]
  lodash.assign state, userId: user.id, changed: yes
  db.changed = yes

exports.login = (sid, data) ->
  unless db.auth[data.name]?
    sender.error sid, 'no such user'
    return
  unless db.auth[data.name] is data.password
    sender.error sid, 'wrong password'
    return
  matchName = (user) -> user.name is data.name
  user = prelude.find matchName, db.users
  user.online = yes
  state = states[sid]
  lodash.assign state, {userId: user.id, changed: yes}
  db.changed = yes

exports.logout = (sid, data) ->
  state = states[sid]
  {user} = state
  curd.updateOneById db.users, user.id, online: no
  lodash.assign state, userId: null, changed: yes
  db.changed = yes

exports.change = (sid, data) ->
  unless db.auth[data.name]?
    sender.error sid, 'no such user'
    return
  unless db.auth[data.name] is data.password
    sender.error sid, 'wrong password'
    return
  db.auth[data.name] = data.another
  sender.ok sid, 'info', data: 'done'
