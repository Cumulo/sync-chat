
module.exports =
  # Usage:
  # lodash.merge {}, emitter, methods: ->

  _makeListeners: ->
    # private method, don't call it
    unless @_listeners?
      @_listeners = []

  on: (f) ->
    @_makeListeners()
    @_listeners.push f

  off: (f) ->
    @_makeListeners()
    @_listeners = @_listeners.filter (cb) ->
      cb isnt f

  emit: (obj) ->
    @_makeListeners()
    @_listeners.forEach (f) ->
      f obj
