{EventEmitter} = require 'events'
_              = require 'lodash'
Jump           = require './commands/jump'

class GameRunner extends EventEmitter
  constructor: (dependencies={}) ->
    @screenSize = width: 1000, height: 1000
    @commands =
      jump: new Jump
    @setIninitialState()

  setIninitialState: =>
    @state =
      dinosaur:
        x: @screenSize.width / 2
        y: @screenSize.height / 2

  setDinosaurState: (state) =>
    @state.dinosaur = state

  getDinosaurState: =>
    @state.dinosaur

  jump: =>
    @commands.jump.run @getDinosaurState(), @setDinosaurState

  getCurrentState: =>
    @state

module.exports = GameRunner
