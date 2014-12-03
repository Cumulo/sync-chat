
prelude = require 'prelude-ls'
lodash = require 'lodash'
# model
db = require '../model/db'
states = require '../model/states'
# util
time = require '../util/time'
# view
clients = require '../view/clients'

# the structure of all data
world =
  threads: [] # just messages
  messages: {} # by roomId

exports.get = ->
  world

# render threads and messages
isThread = (msg) -> msg.isThread
getThread = (msg) -> msg.thread

render = ->
  fillUser = (msg) ->
    matchUser = (user) -> user.id is msg.userId
    msg.user = lodash.find db.users, matchUser
    msg
  threads = lodash.cloneDeep (prelude.filter isThread, db.messages)
  groups = prelude.groupBy getThread, db.messages
  for thread, messages of groups
    groups[thread] = lodash.cloneDeep(messages).map fillUser

  world.threads = threads.map fillUser
  world.messages = groups

# start time loop
time.interval 800, ->
  unless db.changed
    return
  console.info 'render world'
  render()
  # unmark change but notify clients the changes
  db.changed = no
  for sid, state of states
    clients.patch sid if state?
