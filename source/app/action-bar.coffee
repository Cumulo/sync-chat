
React = require 'react'

AppAvatar = require './avatar'
ModuleModal = require '../module/modal'
AvatarConfig = require './avatar-config'

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

  # render methods

  renderAvatarConfig: ->
    ModuleModal onClose: @onConfigClose,
      AvatarConfig data: @props.user, onClose: @onConfigClose

  render: ->

    $.div className: 'action-bar',
      AppAvatar url: @props.user.avatar, size: 64, onClick: @onAvatarClick

      # mount modals
      if @state.showConfig
        @renderAvatarConfig()