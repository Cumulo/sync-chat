
prelude = require 'prelude-ls'
lodash = require 'lodash'
# model
whispers = require '../model/whispers'
states = require '../model/states'
# util
time = require '../util/time'
# view
preview = require '../view/preview'

world = {}

render = ->
  byThread = (data) -> data.thread
  getText = (whisper) -> whisper.text
  byTime = (p) -> (new Date p.time).valueOf()
  # preview is like {thread, time, text, sid}
  data = lodash.groupBy whispers.typing, byThread
  for thread, list of data
    data[thread] = prelude.sortBy byTime, list
  world = data

time.interval 400, ->
  unless whispers.changed
    return
  render()
  whispers.changed = no
  for sid, state of states
    preview.patch sid if state?

exports.get = ->
  world