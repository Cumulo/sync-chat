
fs = require 'fs'

persistent = '/tmp/sync-chat-persistent.json'

newDatabase = ->
  users: []
  messages: []
  auth: {}

if fs.existsSync persistent
  raw = fs.readFileSync persistent
  try
    database = JSON.parse raw

unless database?
  console.warn 'Server: no database yet'
  database = newDatabase

process.on 'exit', ->
  raw = JSON.stringify database
  fs.writeFileSync

exports.get = ->
  database

# maintain state whether changed

databaseChanged = no

exports.markChanged = ->
  unless databaseChanged
    databaseChanged = yes

exports.nextTick = ->
  databaseChanged = no

exports.isChanged = ->
  databaseChanged = yes
