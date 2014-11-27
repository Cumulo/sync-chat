
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
  console.warn 'Server: no db yet'
  db = emptydb

process.on 'exit', ->
  raw = JSON.stringify db
  fs.writeFileSync

# expose the whole db

module.exports = db
db.changed = no