
React = require 'react'

AppMessage = require './message'
orders = require '../util/orders'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'message-list'

  propTypes:
    data: React.PropTypes.array
    preview: React.PropTypes.array

  componentWillUpdate: ->
    node = @refs.root.getDOMNode()
    h = node.clientHeight
    a = node.scrollHeight
    b = node.scrollTop
    @_atBottom = (b + h + 20) > a

  componentDidUpdate: ->
    if @_atBottom
      node = @refs.root.getDOMNode()
      node.scrollTop = node.scrollHeight
    @_atBottom = null

  renderMessages: ->
    @props.data
    .sort orders.time
    .map (message) =>
      AppMessage key: message.id, data: message

  render: ->

    $.div ref: 'root', className: 'message-list',
      @renderMessages()