
prelude = require 'prelude-ls'
# model
whispers = require '../model/whispers'
states = require '../model/states'
db = require '../model/db'
# utils
filters = require '../util/filters'
time = require '../util/time'

exports.preview = (sid, data) ->
  userId = states[sid].userId
  user = prelude.find (filters.matchId userId), db.users
  whispers.typing[sid] =
    thread: user.thread
    userId: userId
    text: data.text
    textTime: time.now()
  whispers.changed = yes