
React = require 'react'
AppMessage = require './message'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'message-list'

  propTypes:
    data: React.PropTypes.array
    preview: React.PropTypes.array

  renderMessages: ->
    @props.data.map (message) =>
      AppMessage key: message.id, data: message

  render: ->

    $.div className: 'message-list',
      @renderMessages()