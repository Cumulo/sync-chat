
module.exports =
  on: (cb) ->
    unless @listeners?
      @listeners = []
    @listeners.push cb

  off: (b) ->
    unless @listeners?
      @listeners = []
    @listeners = @listeners.filter (cb) ->
      cb isnt f

  trigger: ->
    @listeners.forEach (cb) -> cb()