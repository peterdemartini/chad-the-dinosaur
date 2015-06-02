React = require 'react'

Game = React.createClass
  displayName: 'GameWindow'
  gameName: 'Chad the Dinosaur'

  getInitialState: ->
    loading: true

  componentWillMount: ->
    console.log 'Will Mount...'

  componentDidMount: ->
    console.log 'Did Mount'

  render: ->
    <div className="game">
      <h1 className="title">{@gameName}</h1>
    </div>

module.exports = Game
