React = require 'react'

Game = React.createClass
  displayName: 'GameWindow'
  name: 'Chad the Dinosaur'

  getInitialState: =>
    null

  componentWillMount: =>
    console.log 'Will Mount...'

  componentDidMount: =>
    console.log 'Did Mount'

  render: =>
    <div className="game">
      <h1 className="loading">{@name} is loading...</h1>
    </div>

module.exports = Game
