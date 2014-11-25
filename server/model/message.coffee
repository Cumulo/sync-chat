
shortid = require 'shortid'

time = require '../util/time'
database = require './database'

exports.create = (content, thread, userId) ->
  msg =
    userId: userId
    content: content
    thread: thread
    time: time.now()
    isThread: no

  database.messages.unshift msg
  database.markChanged()

exports.withThreadId = (thread) ->
  database.messages.filter (msg) ->
    msg.thread is thread

exports.setThread = (messageId) ->
  for msg in database.messages
    if msg.id is messageId
      msg.isThread = yes
      database.markChanged()
      break