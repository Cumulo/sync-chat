
React = require 'react'

AppLogin = require './login'
AppSignup = require './signup'
ChangePassword = require './change-password'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'account-action'

  getInitialState: ->
    tab: 'login' # signup, change

  onLoginClick: ->
    @setState tab: 'login'

  onSignupClick: ->
    @setState tab: 'signup'

  onChangeClick: ->
    @setState tab: 'change'

  render: ->

    $.div className: 'account-action',
      $.div className: 'tabs',
        $.span className: 'login', onClick: @onLoginClick, '登录'
        $.span className: 'signup', onClick: @onSignupClick, '注册'
        $.span className: 'change', onClick: @onChangeClick, '修改密码'
      switch @state.tab
        when 'login' then AppLogin()
        when 'signup' then AppSignup()
        when 'change' then ChangePassword()