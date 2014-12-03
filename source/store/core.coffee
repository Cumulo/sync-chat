
lodash = require 'lodash'
jiff = require 'jiff'
flux = require 'flux'
# report
report = require '../report'

store = {}

module.exports = new flux.Dispatcher
lodash.merge module.exports,

  patch: (diff) ->
    store = jiff.patch diff, store
    @dispatch()

  sync: (data) ->
    store = data
    @dispatch()

  get: ->
    store or null