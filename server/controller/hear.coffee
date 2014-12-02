
# model
whispers = require '../model/whispers'
states = require '../model/states'

exports.preview = (sid, data) ->
  user = states[sid].user
  whispers.typing[sid] =
    thread: user.thread
    userId: user.id
    text: data.text
  whispers.changed = yes