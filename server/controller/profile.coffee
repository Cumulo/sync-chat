
# model
states = require '../model/states'
db = require '../model/db'
# util
curd = require '../util/curd'

exports.update = (sid, obj) ->
  {user} = states[sid]
  data =
    nickname: obj.nickname
    avatar: obj.avatar
  curd.updateOneById db.users, user.id, data
  db.changed = yes

exports.setThread = (sid, data) ->
  {user} = states[sid]
  curd.updateOneById db.users, user.id, thread: data.thread
  db.changed = yes