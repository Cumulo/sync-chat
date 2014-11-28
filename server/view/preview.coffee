
lodash = require 'lodash'
prelude = require 'prelude-ls'
jiff = require 'jiff'
# model
states = require './model/states'
# util
time = require './util/time'
# browser
sender = require '../sender'

collection =
  previews: {}

  render: ->

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