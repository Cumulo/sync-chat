
lodash = require 'lodash'
jiff = require 'jiff'
# util
dispatcher = require '../util/dispatcher'
# report
report = require '../report'

store = {}

lodash.merge exports, dispatcher

exports.patch = (diff) ->
  store = jiff.patch diff, (store or {})
  exports.trigger()

exports.sync = (data) ->
  store = data
  exports.trigger()

exports.get = ->
  store