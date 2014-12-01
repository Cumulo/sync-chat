
lodash = require 'lodash'
jiff = require 'jiff'
# util
dispatcher = require '../util/dispatcher'
# report
report = require '../report'

store = {}

lodash.merge exports, dispatcher

exports.patch = (diff) ->
  try
    store = jiff.patch diff, store
    exports.trigger()
  catch err
    console.warn 'store patch error'
    report.syncPreview()

exports.sync = (data) ->
  store = data
  exports.trigger()

exports.get = ->
  store or null