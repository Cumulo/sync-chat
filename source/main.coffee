
React = require 'react'
# server interface
deliver = require './deliver'
report = require './report'

# start websocket
ws = new WebSocket 'ws://localhost:3000'

ws.onmessage = (event) ->
  data = JSON.parse event.data
  deliver.handle data

ws.onopen = ->
  report.register ws
