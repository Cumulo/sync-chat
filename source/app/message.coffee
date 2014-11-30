
React = require 'react'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'app-message'

  render: ->

    $.div className: 'app-message',
      'app-message'