
React = require 'react'

tipsStore = require '../store/tips'

ModuleTip = require '../module/tip'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'tip-manager'

  getInitialState: ->
    data: tipsStore.get()

  componentDidMount: ->
    tipsStore.on @onChange

  componentWillUnmount: ->
    tipsStore.off @onChange

  onChange: ->
    @setState data: tipsStore.get()

  onTipClick: (id) ->
    tipsStore.remove id

  render: ->

    $.div className: 'tip-manager paragraph',
      @state.data.map (tipData) =>
        ModuleTip key: tipData.id, data: tipData, onClick: @onTipClick
