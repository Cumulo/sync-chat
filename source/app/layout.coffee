
React = require 'react'

$ = React.DOM

# components
ThreadList = require './thread-list'
MessageList = require './message-list'
ActionBar = require './action-bar'
TipManager = require './tip-manager'
AccountAction = require './account-action'

module.exports = React.createFactory React.createClass
  displayName: 'app-layout'

  propTypes:
    store: React.PropTypes.object.isRequired

  renderAccountAction: ->
    $.div className: 'guest-page',
      AccountAction()

  renderMessage: ->
    $.div className: 'main-page',
      ThreadList data: @props.store.threads
      MessageList data: @props.store.messages
      ActionBar data: @props.store.user

  render: ->
    $.div className: 'app-layout',
      if @props.store?.user?
      then @renderMessage()
      else @renderAccountAction()
      TipManager()