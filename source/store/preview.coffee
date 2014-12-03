
lodash = require 'lodash'
jsondiffpatch = require 'jsondiffpatch'
flux = require 'flux'
# report
report = require '../report'

store = {}

module.exports = new flux.Dispatcher
lodash.merge module.exports,

  patch: (diff) ->
    store = jsondiffpatch.patch (store or {}), diff
    @dispatch()

  sync: (data) ->
    store = data
    @dispatch()

  get: ->
    store