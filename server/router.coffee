
# controller
message = require './controller/message'
account = require './controller/account'
profile = require './controller/profile'
alter = require './controller/alter'
hear = require './controller/hear'
# state is special to be operated directly
states = require './model/states'

exports.handle = (sid, data) ->
  switch data.scope
    # user account
    when 'account' then switch data.action
      when 'signup'   then account.signup   sid, data
      when 'login'    then account.login    sid, data
      when 'change'   then account.change   sid, data
      else console.warn 'not handled in account', data
    # message
    when 'message' then switch data.action
      when 'create'     then message.create       sid, data
      when 'setThread'  then message.setThread    sid, data
      else console.warn 'not handled in message', data
    # profile
    when 'profile' then switch data.action
      when 'avatar'     then profile.avatar     sid, data
      when 'nickname'   then profile.nickname   sid, data
      else console.warn 'not handled in profile', data
    # states that are not in db
    when 'state' then switch data.action
      when 'update'       then alter.merge sid, data
      when 'moreMessage'  then alter.moreMessage sid, data
      when 'moreThread'   then alter.moreThread sid, data
      else console.warn 'not handled in alter', data
    # preview whispers
    when 'whisper' then switch data.action
      when 'preview'  then hear.preview sid, data
      else console.warn 'not handled in whisper', data
    else console.warn 'not handled in router', data

# above are the scope allowed from clients
# also might be a special one reporting errors