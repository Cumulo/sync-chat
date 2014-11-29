
# model
whispers = require '../model/whispers'
states = require '../model/states'

exports.preview = (sid, data) ->
  state = states[sid]
  thread = state.thread
  userId = state.user.id
  whispers.typing[sid] =
    thread: thread
    userId: userId
    text: data.text
    changed: yes