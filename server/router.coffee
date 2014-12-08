
# controller
message = require './controller/message'
account = require './controller/account'
profile = require './controller/profile'
alter = require './controller/alter'
hear = require './controller/hear'
# state is special to be operated directly
states = require './model/states'
# view
clients = require './view/clients'
preview = require './view/preview'

exports.handle = (sid, data) ->
  switch data.scope
    # user account
    when 'account' then switch data.action
      when 'signup'   then account.signup   sid, data
      when 'login'    then account.login    sid, data
      when 'logout'   then account.logout   sid, data
      when 'change'   then account.change   sid, data
      else console.warn 'not handled in account', data
    # message
    when 'message' then switch data.action
      when 'create'     then message.create       sid, data
      when 'setThread'  then message.setThread    sid, data
      else console.warn 'not handled in message', data
    # profile
    when 'profile' then switch data.action
      when 'update'     then profile.update     sid, data
      when 'setThread'  then profile.setThread  sid, data
      else console.warn 'not handled in profile', data
    # states that are not in db
    when 'state' then switch data.action
      when 'update'       then alter.merge    sid, data
      when 'morePage'     then alter.morePage sid, data
      else console.warn 'not handled in alter', data
    # preview whispers
    when 'whisper' then switch data.action
      when 'preview'  then hear.preview sid, data
      else console.warn 'not handled in whisper', data
    # report clients failure
    when 'clients' then switch data.action
      when 'sync' then clients.sync sid
      else console.warn 'not handled in clients', data
    # report preview failure
    when 'preview' then switch data.action
      when 'sync' then preview.sync sid
    else console.warn 'not handled in router', data

# above are the scope allowed from clients
# also might be a special one reporting errors