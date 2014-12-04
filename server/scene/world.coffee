
prelude = require 'prelude-ls'
lodash = require 'lodash'
# model
db = require '../model/db'
states = require '../model/states'
# util
time = require '../util/time'
orders = require '../util/orders'
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
    msg.user = lodash.cloneDeep (lodash.find db.users, matchUser)
    msg
  threads = lodash.cloneDeep (prelude.filter isThread, db.messages)
  groups = prelude.groupBy getThread, db.messages
  for thread, messages of groups
    groups[thread] = lodash.cloneDeep(messages).map(fillUser).sort(orders)

  world.threads = threads.map(fillUser).sort(orders.time)
  world.messages = groups
  world.users = lodash.cloneDeep db.users

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
