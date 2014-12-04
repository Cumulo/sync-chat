
React = require 'react'

AppAvatar = require './avatar'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'app-message'

  propTypes:
    data: React.PropTypes.object

  render: ->

    $.div className: 'app-message',
      AppAvatar
        data: @props.data.user
        size: 32, onClick: ->
      $.div className: 'body',
        $.div className: 'line',
          @props.data.user.nickname
          @props.data.time
        $.div className: 'content',
          @props.data.text