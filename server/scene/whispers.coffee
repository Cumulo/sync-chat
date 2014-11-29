
prelude = require 'prelude-ls'
lodash = require 'lodash'
# model
whispers = require '../model/whispers'
# util
time = require '../util/time'
# view
preview = require '../view/preview'

world = {}

render = ->
  byThread = (msg) -> msg.thread
  getText = (whisper) -> whisper.text
  byTime = (p) -> new Date p.time
  # preview is like {thread, time, text, sid}
  data = prelude.groupBy byThread,
    lodash.map whispers, getText
  for thread, list of data
    data[thread] = prelude.sortBy byTime
  world = data

time.interval 400, ->
  unless whispers.changed
    return
  render()
  whispers.changed = no
  for sid, state of states
    preview.patchClient sid

exports.get = ->
  world