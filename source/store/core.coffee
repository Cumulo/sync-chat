
lodash = require 'lodash'
jsondiffpatch = require 'jsondiffpatch'
# report
report = require '../report'
emitter = require '../util/emitter'

store = {}
window.store = store

lodash.assign exports, emitter,

  patch: (diff) ->
    store = jsondiffpatch.patch store, diff
    @emit()

  sync: (data) ->
    store = data
    @emit()

  get: ->
    store or null