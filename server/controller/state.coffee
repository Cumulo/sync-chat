
state = require '../model/state'

exports.handle = (msg, socketId) ->
  state.update socketId, msg