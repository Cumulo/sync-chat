
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

render = ->
  isThread = (msg) -> msg.isThread
  getThread = (msg) -> msg.thread
  world.threads = prelude.filter isThread, db.messages
  world.messages = prelude.groupBy getThread, db.messages

time.interval 1000, ->
  unless db.changed
    return
  console.info 'render world'
  render()
  # unmark change but notify clients the changes
  db.changed = no
  for sid, state of states
    clients.patch sid

exports.get = ->
  world
