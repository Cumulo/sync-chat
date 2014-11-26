
auth = require '../model/auth'
sockets = require '../sockets'
userModel = require '../model/user'
state = require '../model/state'

router =
  signup: (msg, socketId) ->
    auth.signup msg.name, msg.password, (err) ->
      if err?
        sockets.emit socketId, 'info', msg: err
        return
      user = userModel.create msg.name
      userModel.updateUser user.id, online: yes
      state.update socketId, user: user

  login: (msg, socketId) ->
    auth.login msg.name, msg.password, (err) ->
      if err?
        sockets.emit sockets, 'info', msg: err
        return
      user = userModel.withName msg.name
      userModel.updateUser user.id, online: yes
      state.update socketId, user: user

  logout: (msg, socketId) ->
    user = (state.withSocketId socketId).user
    userModel.updateUser user.id, online: no
    sockets.emit socketId, msg: 'logout..'
    state.clearWithSocketId socketId

  change: (msg, socketId) ->
    auth.change msg.name, msg.password, msg.newOne, (err) ->
      if err?
        sockets.emit socketId, 'info', msg: err
      else
        sockets.emit socketId, 'info', msg: 'done'

exports.handle = (msg, socketId) ->
  action = router[msg.action]
  if action?
  then action msg, socketId
  else console.warn 'not handled in accout:', msg
