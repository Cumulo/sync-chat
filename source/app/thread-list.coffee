
React = require 'react'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'thread-list'

  render: ->

    $.div className: 'thread-list',
      'thread-list'