
lodash = require 'lodash'
# util
emitter = require '../util/emitter'

store = []

lodash.merge exports, emitter,

  add: (info) ->
    store.unshift info
    @emit()

  remove: (id) ->
    store = store.filter (tip) -> tip.id isnt id
    @emit()

  get: ->
    store