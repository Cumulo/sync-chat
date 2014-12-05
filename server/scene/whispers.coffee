
prelude = require 'prelude-ls'
lodash = require 'lodash'
# model
whispers = require '../model/whispers'
states = require '../model/states'
db = require '../model/db'
# util
time = require '../util/time'
filters = require '../util/filters'
# view
preview = require '../view/preview'

world = {}

# methods
byThread = (data) -> data.thread
getText = (whisper) -> whisper.text
byTime = (p) -> (new Date p.time).valueOf()

render = ->
  users = lodash.cloneDeep db.users
  # preview is like {thread, time, text, sid, textTime}
  typing = {}
  lodash.each whispers.typing, (typingState, sid) ->
    state = states[sid]
    if state?
      typing[sid] = obj = lodash.cloneDeep typingState
      obj.id = sid
      {userId} = state
      obj.user = prelude.find (filters.matchId userId), users

  world = lodash.groupBy typing, byThread
  lodash.each world, (list, thread) ->
    world[thread] = prelude.sortBy byTime, list

time.interval 400, ->
  unless whispers.changed
    return
  render()
  whispers.changed = no
  for sid, state of states
    preview.patch sid if state?

exports.get = ->
  world