
React = require 'react'
# server interface
deliver = require './deliver'
report = require './report'

# start websocket
ws = new WebSocket 'ws://localhost:3000'
report.register ws

ws.onmessage = (event) ->
  try
    data = JSON.parse event.data
    deliver.handle data
  unless data?
    console.log 'parsing failed', data
