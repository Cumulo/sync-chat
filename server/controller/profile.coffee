
# model
states = require '../model/states'
db = require '../model/db'
# util
curd = require '../util/curd'

exports.update = (sid, obj) ->
  state = states[sid]
  data =
    nickname: obj.nickname
    avatar: obj.avatar
  curd.updateOneById db.users, state.userId, data
  db.changed = yes

exports.setThread = (sid, data) ->
  state = states[sid]
  curd.updateOneById db.users, state.userId, thread: data.thread
  db.changed = yes