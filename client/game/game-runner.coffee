_              = require 'lodash'
Jump           = require './commands/jump'
Left           = require './commands/left'
Right          = require './commands/right'

class GameRunner
  constructor: (dependencies={}) ->
    @screenSize = width: 1000, height: 1000
    jump = dependencies.jump ? new Jump
    left = dependencies.left ? new Left
    right = dependencies.right ? new Right
    @commands =
      jump: jump
      left: left
      right: right
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
    @commands.jump.start @getDinosaurState(), @setDinosaurState

  left: =>
    @commands.left.start @getDinosaurState(), @setDinosaurState

  right: =>
    @commands.right.start @getDinosaurState(), @setDinosaurState

  down: =>
    console.log 'move down'

  getCurrentState: =>
    @state

module.exports = GameRunner
