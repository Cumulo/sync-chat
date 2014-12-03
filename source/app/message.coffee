
React = require 'react'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'app-message'

  propTypes:
    data: React.PropTypes.object

  render: ->

    $.div className: 'app-message',
      @props.data.text