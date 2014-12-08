
React = require 'react'

AppMessage = require './message'
orders = require '../util/orders'
report = require '../report'
addons = require '../util/addons'

$ = React.DOM
cx = addons.cx

module.exports = React.createFactory React.createClass
  displayName: 'thread-list'

  propTypes:
    user: React.PropTypes.object

  onMessageClick: (messageId) ->
    report.alterThread messageId

  renderMessages: ->
    @props.data.concat()
    .sort orders.timeReverse
    .map (message) =>
      onClick = => @onMessageClick message.id
      $.div
        key: message.id
        className: cx
          'outline': yes
          'is-inside': message.id is @props.user.thread
        onClick: onClick,
        AppMessage key: message.id, data: message

  render: ->

    $.div className: 'thread-list',
      @renderMessages()