
React = require 'react'

$ = React.DOM

# components
AppLogin = require './login'
ThreadList = require './thread-list'
MessageList = require './message-list'
ActionBar = require './action-bar'
TipManager = require './tip-manager'

module.exports = React.createFactory React.createClass
  displayName: 'app-layout'

  propTypes:
    store: React.PropTypes.object.isRequired

  renderLogin: ->
    $.div className: 'guest-page',
      AppLogin()

  renderMessage: ->
    $.div className: 'main-page',
      ThreadList data: store.threads
      MessageList data: store.messages
      ActionBar data: store.user

  render: ->
    $.div className: 'app-layout',
      if @props.store?.user?
      then @renderMessage()
      else @renderLogin()
      TipManager()