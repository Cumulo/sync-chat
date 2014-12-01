
lodash = require 'lodash'

dispatcher = require '../util/dispatcher'

lodash.merge exports, dispatcher

store = []

exports.add = (info) ->
  store.unshift info
  @emit()

exports.remove = (id) ->
  store = store.filter (tip) -> tip.id isnt id
  @emit()

exports.get = ->
  store