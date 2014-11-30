
React = require 'react'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'message-list'

  render: ->

    $.div className: 'message-list',
      'message-list'