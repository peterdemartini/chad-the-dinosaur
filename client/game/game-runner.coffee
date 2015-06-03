{EventEmitter} = require 'events'
_              = require 'lodash'
Jump           = require './commands/jump'

class GameRunner extends EventEmitter
  constructor: (dependencies={}) ->
    @screenSize = width: 1000, height: 1000
    jump = dependencies.jump ? new Jump
    @commands =
      jump: jump
    @state = {}
    @setDefaultState()

  setDefaultState: =>
    @setDinosaurState
      x: @screenSize.width / 2
      y: @screenSize.height / 2

  setDinosaurState: (state) =>
    @state.dinosaur = state

  getDinosaurState: =>
    @state.dinosaur

  up: =>
    console.log 'move up'
    @commands.jump.run @getDinosaurState(), @setDinosaurState

  left: =>
    console.log 'move left'

  right: =>
    console.log 'move right'

  down: =>
    console.log 'move down'

  getCurrentState: =>
    @state

module.exports = GameRunner
