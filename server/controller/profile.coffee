
# model
states = require '../model/states'
db = require '../model/db'
# util
curd = require '../util/curd'

exports.avatar = (sid, data) ->
  {user} = states[sid]
  curd.updateOneById db.users, user.id, avatar: data.avatar
  db.changed = yes

exports.nickname = (sid, data) ->
  {user} = states[sid]
  curd.updateOneById db.users, user.id, nickname: data.nickname
  db.changed = yes
