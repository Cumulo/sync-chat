
React = require 'react'

$ = React.DOM
T = React.PropTypes

module.exports = React.createFactory React.createClass
  displayName: 'app-avatar'

  propTypes:
    size: T.number
    url: T.string
    onClick: T.func

  onClick: ->
    @props.onClick()

  render: ->
    style =
      width: "#{@props.size}px"
      height: "#{@props.size}px"
      backgroundImage: "url('#{@props.url}')"
    $.div
      className: 'app-avatar'
      style: style
      onClick: @onClick