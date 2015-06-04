_ = require 'lodash'

X_PIXELS=5
NUMBER_OF_FRAMES=5
FRAME_LENGTH=25

class Right
  constructor: ->

  start: (state, callback=->)=>
    _.times NUMBER_OF_FRAMES, (n) =>
      _.delay =>
        state.x += X_PIXELS
        callback state
      , FRAME_LENGTH * n

module.exports = Right
