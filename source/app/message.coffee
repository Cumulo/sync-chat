
React = require 'react'

AppAvatar = require './avatar'
report = require '../report'
addons = require '../util/addons'

$ = React.DOM
cx = addons.cx

module.exports = React.createFactory React.createClass
  displayName: 'app-message'

  propTypes:
    data: React.PropTypes.object
    onClick: React.PropTypes.func

  onPromote: ->
    report.setThread @props.data.id

  onClick: ->
    @props.onClick?()

  render: ->

    $.div className: 'app-message', onClick: @onClick,
      AppAvatar
        data: @props.data.user
        size: 32, onClick: ->
      $.div className: 'body',
        $.div className: 'line',
          @props.data.user.nickname
          $.span className: 'time', @props.data.time
        $.div className: 'content',
          @props.data.text
        $.div
          className: cx
            'thread': yes
            'is-thread': @props.data.isThread
          onClick: @onPromote,
          '⑃'