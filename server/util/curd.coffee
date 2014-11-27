
prelude = require 'prelude-ls'

exports.updateOneById = (collection, id, pairs) ->
  matchId = (data) -> data.id is id
  updatePairs = (data) -> data[key] = value for key, value of pairs
  prelude.map updatePairs,
    prelude.take 1,
      prelude.filter matchId, collection

exports.updateById = (collection, id, pairs) ->
  updatePairs = (data) -> data[key] = value for key, value of pairs
  matchId = (data) -> data.id is id
  prelude.map updatePairs,
    prelude.filter matchId, collection

exports.updateObject = (object, id, pairs) ->
  object[key] = value for key, value of pairs