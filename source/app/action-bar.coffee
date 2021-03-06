
React = require 'react'

AppAvatar = require './avatar'
ModuleModal = require '../module/modal'
AvatarConfig = require './avatar-config'

report = require '../report'

$ = React.DOM
T = React.PropTypes

module.exports = React.createFactory React.createClass
  displayName: 'action-bar'

  propTypes:
    user: T.object

  getInitialState: ->
    showConfig: no

  onAvatarClick: -> @setState showConfig: yes
  onConfigClose: -> @setState showConfig: false

  onLogoutClick: ->
    report.logout()

  # render methods

  renderAvatarConfig: ->
    ModuleModal onClose: @onConfigClose,
      AvatarConfig data: @props.user, onClose: @onConfigClose

  render: ->

    $.div className: 'action-bar',
      AppAvatar
        data: @props.user, size: 64
        onClick: @onAvatarClick

      $.div className: 'button', onClick: @onLogoutClick,
        '注销'

      # mount modals
      if @state.showConfig
        @renderAvatarConfig()