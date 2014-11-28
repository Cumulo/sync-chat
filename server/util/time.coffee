
exports.now = ->
  (new Date).toString()

exports.interval = (f, t) -> setInterval t, f
exports.timeout = (f, t) -> setTimeout t, f