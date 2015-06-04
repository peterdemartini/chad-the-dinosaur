_ = require 'lodash'

X_PIXELS=10
NUMBER_OF_FRAMES=5
FRAME_LENGTH=5

class Left
  constructor: ->

  start: (state={}, callback=->)=>
    _.times NUMBER_OF_FRAMES, (n) =>
      _.delay =>
        state.x -= X_PIXELS
        callback state
      , FRAME_LENGTH * n

module.exports = Left
