
# model
states = require '../model/states'
db = require '../model/db'
# util
curd = require '../util/curd'

exports.update = (sid, obj) ->
  state = states[sid]
  data = {}
  for key in ['nickname', 'avatar']
    if obj[key]?
      data[key] = obj[key]
  curd.updateOneById db.users, state.userId, data
  db.changed = yes

exports.setThread = (sid, data) ->
  state = states[sid]
  state.messagePage = 1
  curd.updateOneById db.users, state.userId, thread: data.thread
  db.changed = yes