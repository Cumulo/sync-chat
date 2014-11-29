
# server interface
deliver = require './deliver'
report = require './report'

ws = new WebSocket 'ws://localhost:3000'

report.register ws

ws.onmessage = (raw) ->
  try
    data = JSON.parse raw
    deliver.handle data
  unless data?
    console.log 'parsing failed', data
