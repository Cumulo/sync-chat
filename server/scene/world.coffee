
prelude = require 'prelude-ls'
lodash = require 'lodash'
# model
db = require '../model/db'
# util
time = require '../util/time'

# the structure of all data
world =
  topics: [] # just messages
  threas: {} # by roomId

render = ->
  isThread = (msg) -> msg.isThread
  getThread = (msg) -> msg.thread
  world.threads = prelude.filter isThread, db.messages
  world.messages = prelude.groupBy getThread, db.messages

time.interval 1000, ->
  unless db.changed
    return
  render()
  # unmark change but notify clients the changes
  db.changed = no
  for sid, state of states
    state?.changed = yes

exports.get = ->
  world
