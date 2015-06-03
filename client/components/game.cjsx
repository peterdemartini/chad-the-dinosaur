React      = require 'react'
GameRunner = require '../game/game-runner'
_          = require 'lodash'

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
    _.delay =>
      @gameRunner.jump()
    , 500
    setInterval =>
      @setState gameState: @gameRunner.getCurrentState()
    , 10

  componentWillUpdate: ->
    width = React.findDOMNode(@).offsetWidth;
    height = React.findDOMNode(@).offsetHeight;
    @gameRunner.screenSize = width: width, height: height

  render: ->
    dinosaurTag = '<image xlink:href="/assets/dinosaur.svg" width="50" height="50" x="'+@state.gameState.dinosaur.x+'" y="'+@state.gameState.dinosaur.y+'">'

    <div className="game-container">
      <h1 className="title">{@gameName}</h1>
      <svg width="100%" height="100%" className="game">
        <rect width="100%" height="100%" style={{fill:'rgb(245,245,245)'}} />
        <g>
          <svg dangerouslySetInnerHTML={__html: dinosaurTag}></svg>
        </g>
      </svg>
    </div>

module.exports = Game
