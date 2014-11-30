
React = require 'react'

tips = require '../store/tips'

ModuleTip = require '../module/tip'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'tip-manager'

  getInitialState: ->
    data: tips.get()

  componentDidMount: ->
    tips.on @onChange

  componentWillUnmount: ->
    tips.off @onChange

  onChange: ->
    @setState data: tips.get()

  render: ->

    $.div className: 'tip-manager',
      ModuleTip