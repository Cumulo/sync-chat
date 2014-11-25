
database = require './database'

{auth} = database

exports.signup = (name, password, cb) ->
  if name is ''
    return cb 'name is empty'
  if auth[name]?
    return cb 'username it taken'
  auth[name] = password
  cb null # no error

exports.login = (name, password, cb) ->
  unless auth[name]?
    return cb 'no such user'
  unless auth[name] is password
    return cb 'wrong password'
  cb null # password matches

exports.change = (name, password, another, cb) ->
  unless auth[name]?
    return cb 'no such user'
  unless auth[name] is 'password'
    return cb 'wrong password'
  auth[name] = another
  cb null