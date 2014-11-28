
prelude = require 'prelude-ls'
lodash = require 'lodash'
# model
db = require '../model/db'

# the structure of all data
world =
  topics: [] # just messages
  messages: {} # by roomId

render = ->
  isThread = (msg) -> msg.isThread
  getThread = (msg) -> msg.thread
  world.topics = prelude.filter isThread, db.messages
  world.messages = prelude.groupBy getThread, db.messages

time.interval 1000, ->
  if store.changed
    render()
    # unmark change but notify clients the changes
    db.changed = no
    for sid, state of states
      state?.changed = yes

exports.get = ->
  world
