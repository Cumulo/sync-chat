
React = require 'react'
report = require '../report'

$ = React.DOM
T = React.PropTypes

module.exports = React.createFactory React.createClass
  displayName: 'avatar-config'

  propTypes:
    data: T.object
    onClose: T.func

  getInitialState: ->
    nickname: @props.data.nickname
    avatar: @props.data.avatar

  onAvatarChange: (event) ->    @setState avatar: event.target.value
  onNicknameChange: (event) ->  @setState nickname: event.target.value

  onSubmit: ->
    data =
      nickname: @state.nickname
      avatar: @state.avatar
    report.updateProfile data
    @props.onClose()

  render: ->

    $.div className: 'avatar-config paragraph',
      $.div className: 'line',
        $.input
          value: @state.nickname, type: 'text'
          onChange: @onNicknameChange
          placeholder: '昵称'
      $.div className: 'line',
        $.input
          value: @state.avatar, type: 'url'
          onChange: @onAvatarChange
          placeholder: '头像链接'
      $.div className: 'line',
        $.div className: 'button', onClick: @onSubmit, "保存"