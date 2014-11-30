
React = require 'react'

report = require '../report'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'app-login'

  getInitialState: ->
    name: ''
    password: ''

  onNameChange: (event) ->
    @setState name: event.target.value

  onPasswordChange: (event) ->
    @setState password: event.target.value

  onSubmit: ->
    report.login @state.name, @state.password

  render: ->

    $.div className: 'app-login',
      $.input
        className: 'name', type: 'text'
        value: @state.name, placeholder: '用户名'
        onChange: @onNameChange
      $.input
        className: 'password', type: 'password'
        onChange: @onPasswordChange
        value: @state.password, placeholder: '密码'
      $.div className: 'actions',
        $.div className: 'button', onClick: @onSubmit, '登录'