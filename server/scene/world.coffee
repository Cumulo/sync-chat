
prelude = require 'prelude-ls'
lodash = require 'lodash'
# model
db = require '../model/db'
states = require '../model/states'
# util
time = require '../util/time'
orders = require '../util/orders'
filters = require '../util/filters'
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
  users = lodash.cloneDeep db.users
  messages = lodash.cloneDeep db.messages
  threads = lodash.cloneDeep (prelude.filter isThread, db.messages)
  fillUser = (msg) ->
    msg.user = prelude.find (filters.matchId msg.userId), users
    msg
  groups = prelude.groupBy getThread, messages
  for thread, list of groups
    list.forEach fillUser
    groups[thread] = list.sort(orders.timeReverse)

  world.threads = threads.map(fillUser).sort(orders.timeReverse)
  world.messages = groups
  world.users = lodash.cloneDeep db.users

# start time loop
time.interval 200, ->
  unless db.changed
    return
  console.info 'render world'
  render()
  # unmark change but notify clients the changes
  db.changed = no
  for sid, state of states
    clients.patch sid if state?
