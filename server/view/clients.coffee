
prelude = require 'prelude-ls'
lodash = require 'lodash'
jiff = require 'jiff'
# store
db = require '../store/db'
states = require '../store/states'
# util
time = require '../util/time'

# the structure of all data
world =
  topics: [] # just messages
  messages: {} # by roomId

  render: ->
    isThread = (msg) -> msg.isThread
    getThread = (msg) -> msg.thread
    @topics = prelude.filter isThread, db.messages
    @messages = prelude.groupBy getThread, db.messages

time.interval 1000, ->
  if store.changed
    world.render()
  for sid, state of states
    if state?.changed
      updateClient sid
    db.changed = no

exports.syncClient = (sid) ->
  updateClient sid

updateClient = (sid) ->
