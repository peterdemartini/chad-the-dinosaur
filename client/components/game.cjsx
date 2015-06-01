React = require 'react'

Game = React.createClass
  displayName: 'GameWindow'

  getInitialState: =>
    name: 'Chad the Dinosaur'

  componentWillMount: =>
    console.log 'Will Mount...'

  componentDidMount: =>
    console.log 'Did Mount'

  render: =>
    <div className="game">
      <h1 className="loading">Chad the Dinosaur is loading...</h1>
    </div>

module.exports = Game
