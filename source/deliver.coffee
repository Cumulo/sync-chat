
# store
store = require './store/core'
preview = require './store/preview'

exports.handle = (data) ->
  switch data.scope
    when 'preview' then switch data.action
      when 'patch'  then preview.patch  data.data
      when 'sync'   then preview.sync   data.data
      else console.warn 'not handled in preview', data
    when 'store' then switch data.action
      when 'patch'  then preview.patch  data.data
      when 'sync'   then preview.sync   data.data
      else console.warn 'not handled in store', data
    else console.warn 'not handled', data