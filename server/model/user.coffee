
shortid = require 'shortid'

database = require './database'
time = require '../util/time'

exports.create = (name) ->
  user =
    name: name
    time: time.now()
    avatar: ''
  database.users.unshift user
  database.markChanged()

exports.withId = (userId) ->
  {users} = database
  for user in users
    if user.id is userId
      return user

exports.updateUser = (userId, data) ->
  {users} = database
  for user in users
    if user.id is userId
      for key, value of data
        user[key] = value
      database.markChanged()
      break
