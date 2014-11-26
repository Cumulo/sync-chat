
state = require '../model/state'
message = require '../model/message'
userModel = require '../model/user'

router =
  create: (msg, socketId) ->
    userState = state.withSocketId socketId
    message.create msg.content, userState.thread, userState.userId

  setThread: (msg, socketId) ->
    message.setThread msg.messageId

  setAvatar: (msg, socketId) ->
    user = (state.withSocketId socketId).user
    userModel.updateUser user.id, avatar: msg.avatar

  setNickname: (msg, socketId) ->
    user = (state.withSocketId socketId).user
    userModel.updateUser user.id, nickname: msg.nickname

exports.handle = (msg, socketId) ->
  action = router[msg.action]
  if action?
  then action msg, socketId
  else console.warn 'not handled in store:', msg
