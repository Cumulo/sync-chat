
React = require 'react'

AppMessage = require './message'
orders = require '../util/orders'
preview = require '../store/preview'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'message-list'

  propTypes:
    data: React.PropTypes.array

  getInitialState: ->
    preview: store.get()

  componentWillUpdate: ->
    @_atBottom = @isScrollAtBottom()

  componentDidUpdate: ->
    if @_atBottom then @scrollToBottom()
    @_atBottom = null

  componentDidMount: ->
    @scrollToBottom()
    preview.on @onPreviewUpdate

  componentWillUnmount: ->
    preview.off @onPreviewUpdate

  # custom methed

  scrollToBottom: ->
    node = @refs.root.getDOMNode()
    node.scrollTop = node.scrollHeight

  isScrollAtBottom: ->
    node = @refs.root.getDOMNode()
    h = node.clientHeight
    a = node.scrollHeight
    b = node.scrollTop
    (b + h + 20) > a

  # event listener

  onPreviewUpdate: ->
    @setState preview: preview.get()

  # render methods

  renderMessages: ->
    @props.data
    .sort orders.time
    .map (message) =>
      AppMessage key: message.id, data: message

  renderPreview: ->
    @state.preview
    .sort orders.time

  render: ->

    $.div ref: 'root', className: 'message-list',
      @renderMessages()
      @renderPreview()