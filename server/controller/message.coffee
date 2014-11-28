
shortid = require 'shortid'
# model
states = require '../model/states'
db = require '../model/db'
# utils
time = require '../util/time'
curd = require '../util/curd'

exports.create = (sid, data) ->
  state = states[sid]
  {user, thread} = state
  msg =
    id: shortid.generate()
    time: time.now()
    userId: user.id
    content: data.content
    thread: thread
    isThread: no
  db.messages.unshift msg
  db.changed = yes

exports.setThread = (sid, data) ->
  curd.updateOneById db.messages, data.id, isThread: yes
  db.changed = yes
