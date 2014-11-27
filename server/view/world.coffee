
prelude = require 'prelude-ls'
db = require '../store/db'

world =
  topics: [] # just messages
  messages: {} # by roomId

exports.get = ->
  world

exports.render = ->
  isThread = (msg) -> msg.isThread
  getThread = (msg) -> msg.thread
  world.topics = prelude.filter isThread, db.messages
  world.messages = prelude.groupBy getThread, db.messages
  db.changed = no