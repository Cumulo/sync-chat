
fs = require 'fs'

persistent = '/tmp/sync-chat-persistent.json'

emptydb = ->
  users: []
  messages: []
  auth: {}

if fs.existsSync persistent
  raw = fs.readFileSync persistent
  try db = JSON.parse raw
unless db?
  db = emptydb()

writeData = ->
  raw = JSON.stringify db, null, 2
  fs.writeFileSync persistent, raw

process.on 'exit', writeData
# ctrl + c, not ready
# process.on 'SIGINT', ->

# expose the whole db

module.exports = db
db.changed = no