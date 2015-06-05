_ = require 'lodash'
Framer = require '../framer'


class Left
  constructor: (dependencies={})->
    @X_PIXELS=2
    @NUMBER_OF_FRAMES=10
    @FRAME_LENGTH=10
    @framer = dependencies.framer ? new Framer @NUMBER_OF_FRAMES, @FRAME_LENGTH

  start: (state={}, callback=->)=>
    @framer.start =>
      state.x -= @X_PIXELS if state.x > 0
      state.x = 0 if state.x < 0
      callback state

module.exports = Left
