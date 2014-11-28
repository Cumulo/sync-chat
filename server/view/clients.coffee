
jiff = require 'jiff'
# util
time = require '../util/time'
# model
states = require '../model/states'

# world provides data that is pre-rendered
world = require('./world').get()

render = (sid) ->

exports.syncClient = (sid) ->
  updateClient sid

