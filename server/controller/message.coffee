
shortid = require 'shortid'
# model
states = require '../model/states'
db = require '../model/db'
# utils
time = require '../util/time'
curd = require '../util/curd'

exports.create = (sid, data) ->
  state = states[sid]
  {user} = state
  msg =
    id: shortid.generate()
    time: time.now()
    userId: user.id
    text: data.text
    thread: user.thread
    isThread: no
  db.messages.unshift msg
  db.changed = yes

exports.setThread = (sid, data) ->
  curd.updateOneById db.messages, data.id, isThread: yes
  db.changed = yes
