
lodash = require 'lodash'
prelude = require 'prelude-ls'
jiff = require 'jiff'
# store
states = require './store/states'
# util
time = require './util/time'
# browser
sender = require '../sender'

collection =
  previews: {}

  render: ->
    byThread = (msg) -> msg.thread
    getPreview = (state) -> state.preview
    byTime = (preview) -> new Date preview.time
    # preview is like {thread, time, text, sid}
    data = prelude.groupBy byThread,
      lodash.map states, getPreview
    for thread, list of data
      data[thread] = prelude.sortBy byTime
    @previews = data

time.interval 400, ->
  isChanged = (sid, state) -> state?.changed
  unless lodash.some states, isChanged
    return
  collection.render()
  for sid, state of states
    data = collection.previews[thread]
    sender.patchPreview (jiff state.cachePreview, data)
    state.cachePreview = data

exports.syncClient = (sid) ->
  state = states[sid]
  data = collection.previews[thread]
  sender.syncPreview data
  state.cachePreview = data