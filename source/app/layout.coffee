
React = require 'react'

$ = React.DOM

# components
ThreadList = require './thread-list'
MessageList = require './message-list'
ActionBar = require './action-bar'
TipManager = require './tip-manager'
AccountAction = require './account-action'
MessageBox = require './message-box'

module.exports = React.createFactory React.createClass
  displayName: 'app-layout'

  propTypes:
    store: React.PropTypes.object.isRequired

  renderAccountAction: ->
    $.div className: 'guest-page',
      AccountAction()

  renderMessage: ->
    $.div className: 'main-page',
      $.div className: 'thread-wrap',
        $.div className: 'default-thread',
          '欢迎来到聊天室, 这是一个测试版的聊天室'
        ThreadList data: @props.store.threads
      $.div className: 'message-wrap',
        MessageList data: @props.store.messages
        MessageBox()
      ActionBar user: @props.store.user

  render: ->
    $.div className: 'app-layout',
      if @props.store?.user?
      then @renderMessage()
      else @renderAccountAction()
      TipManager()