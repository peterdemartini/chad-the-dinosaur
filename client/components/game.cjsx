React = require 'react'
GameRunner = require '../game/game-runner'

Game = React.createClass
  displayName: 'GameWindow'
  gameName: 'Chad the Dinosaur'

  getInitialState: ->
    loading: true
    gameState:
      dinosaur:
        x: 0
        y: 0

  componentWillMount: ->
    console.log 'Will Mount...'
    @gameRunner = new GameRunner

  componentDidMount: ->
    console.log 'Did Mount'
    setInterval =>
      @setState gameState: @gameRunner.getCurrentState()
    , 100

  render: ->
    dinosaurTag = React.createElement 'image',
      'xlink:href': '/assets/dinosaur.svg'
      width: 50
      height: 50
      x: @state.gameState.dinosaur.x
      y: @state.gameState.dinosaur.y

    <div className="game">
      <h1 className="title">{@gameName}</h1>
      <svg width="100%" height="100%" dangerouslySetInnerHTML={__html: dinosaurTag}>
        <rect width="100%" height="100%" style={{fill:'rgb(245,245,245)'}} />
        {dinosaurTag}
      </svg>
    </div>

module.exports = Game
