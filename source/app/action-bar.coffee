
React = require 'react'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'action-bar'

  render: ->

    $.div className: 'action-bar',
      'action-bar'