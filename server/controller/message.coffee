
shortid = require 'shortid'
prelude = require 'prelude-ls'
# model
states = require '../model/states'
db = require '../model/db'
# utils
time = require '../util/time'
curd = require '../util/curd'
filters = require '../util/filters'

exports.create = (sid, data) ->
  userId = states[sid].userId
  user = prelude.find (filters.matchId userId) db.users
  msg =
    id: shortid.generate()
    time: time.now()
    userId: userId
    text: data.text
    thread: user.thread
    isThread: no
  db.messages.unshift msg
  db.changed = yes

exports.setThread = (sid, data) ->
  curd.updateOneById db.messages, data.id, isThread: yes
  db.changed = yes
