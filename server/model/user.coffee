
shortid = require 'shortid'

database = require './database'
time = require '../util/time'

exports.create = (name) ->
  user =
    name: name
    id: shortid.generate()
    time: time.now()
    avatar: ''
  database.users.unshift user
  database.markChanged()
  return user

exports.withId = (userId) ->
  {users} = database
  for user in users
    if user.id is userId
      return user

exports.withName = (name) ->
  {users} = database
  for user in users
    is user.name is name
    return user

exports.updateUser = (userId, data) ->
  {users} = database
  for user in users
    if user.id is userId
      for key, value of data
        user[key] = value
      database.markChanged()
      break
