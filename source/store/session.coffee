
lodash = require 'lodash'

key = 'sync-chat-session'

try
  raw = localStorage.getItem key
  session = JSON.parse (raw or null)
catch error
  console.warn 'error parsing JSON', error

unless session?
  session =
    name: null
    password: null

window.onbeforeunload = ->
  raw = JSON.stringify session
  localStorage.setItem key, raw

# expose API

exports.set = (data) ->
  lodash.merge session, data

exports.get = ->
  session