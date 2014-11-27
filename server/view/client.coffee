
prelude = require 'prelude-ls'
database = require '../model/database'

world =
  topics: [] # just messages
  messages: {} # by roomId

exports.get = ->
  world

exports.render = ->
  isThread = (msg) -> msg.isThread
  getThread = (msg) -> msg.thread
  world.topics = prelude.filter isThread, database.messages
  world.messages = prelude.groupBy getThread, database.messages
  database.nextTick()