
exports.cx = (x) ->
  coll = []
  for key, value of x
    if value then coll.push key
  coll.join(' ')