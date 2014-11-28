
prelude = require 'prelude-js'
lodash = require 'lodash'
# model
whispers = require '../model/whispers'
# util
time = require '../util/time'

render = ->
  byThread = (msg) -> msg.thread
  getText = (whisper) -> whisper.text
  byTime = (preview) -> new Date preview.time
  # preview is like {thread, time, text, sid}
  data = prelude.groupBy byThread,
    lodash.map whispers, getPreview
  for thread, list of data
    data[thread] = prelude.sortBy byTime
  @previews = data

time.interval 400, ->
  isChanged = (sid, whisper) -> whisper.changed
  clearChange = (sid, whisper) -> whisper.changed = no
  if lodash.some whispers, isChanged
    render()
    lodash.each whispers, clearChange
