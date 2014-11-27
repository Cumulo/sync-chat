
shortid = require 'shortid'
# sockets to send infos directly
sender = require '../sender'
# store
state = require '../store/state'
db = require '../store/db'
# util
curd = require '../util/curd'

exports.signup = (sid, data) ->
  if data.name is ''
    sender.error sid, 'name is empty'
    return
  if db.auth[name]?
    sender.error sid, 'username it taken'
    return
  db.auth[name] = password
  user =
    name: data.name
    avatar: ''
    nickname: ''
    id: shortid.generate()
    online: yes
  db.users.unshift user
  states[sid].user = user
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
  states[sid].user = user
  data.changed = yes

exports.logout = (sid, data) ->
  user = states[sid].user
  curd.updateOneById db.users, user.id, online: no
  states[sid].user = null

exports.change = (sid, data) ->
  unless db.auth[data.name]?
    sender.error sid, 'no such user'
    return
  unless db.auth[data.name] is 'password'
    sender.error sid, 'wrong password'
    return
  db.auth[name] = data.another
  sender.ok sid, 'info', data: 'done'
