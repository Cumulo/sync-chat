
lodash = require 'lodash'
flux = require 'flux'

store = []

module.exports = new flux.Dispatcher

lodash.merge module.exports,

  add: (info) ->
    store.unshift info
    @dispatch()

  remove: (id) ->
    store = store.filter (tip) -> tip.id isnt id
    @dispatch()

  get: ->
    store