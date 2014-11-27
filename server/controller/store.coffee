
# model
state = require '../model/state'
database = require '../model/database'
# utils
time = require '../util/time'
curd = require '../util/curd'

router =
  create: (msg, socketId) ->
    userState = database.state[socketId]
    msg =
      userId: userId.user.id
      content: msg.content
      thread: userState.thread
      time: time.now()
      isThread: no
    database.message.unshift msg
    database.markChanged()

  setThread: (msg, socketId) ->
    curd.updateOneById database.messages, msg.id, isThread: yes
    database.markChanged()

  setAvatar: (msg, socketId) ->
    user = database.state[socketId].user
    curd.updateOneById database.users, user.id, avatar: msg.avatar
    database.markChanged()

  setNickname: (msg, socketId) ->
    user = database.state[socketId].user
    curd.updateOneById database.users, user.id, nickname: msg.nickname
    database.markChanged()

exports.handle = (msg, socketId) ->
  action = router[msg.action]
  if action?
  then action msg, socketId
  else console.warn 'not handled in store:', msg
