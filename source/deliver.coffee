
React = require 'react'
# store
store = require './store/core'
preview = require './store/preview'
tips = require './store/tips'
# components
AppLayout = require './app/layout'

exports.handle = (data) ->
  switch data.scope
    when 'preview' then switch data.action
      when 'patch'  then preview.patch  data.data
      when 'sync'   then preview.sync   data.data
      else console.warn 'not handled in preview', data
    when 'store' then switch data.action
      when 'patch'  then store.patch  data.data
      when 'sync'   then store.sync   data.data
      else console.warn 'not handled in store', data
    when 'info' then tips.add data
    else console.warn 'not handled', data

# mount components

render = ->
  component = AppLayout store: store.get()
  React.render component, document.body

store.on render
render()