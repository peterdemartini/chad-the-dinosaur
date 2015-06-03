_ = require 'lodash'

JUMP_DELAY=5
JUMP_REPEAT=100
JUMP_Y_CHANGE=100
JUMP_X_CHANGE=1

class Jump
  constructor: ->
    @jumping = false

  run: (@startingState, @callback=->)=>
    return if @jumping
    @jumping = true
    @up()
    _.delay @down, JUMP_REPEAT * JUMP_DELAY

  down: () =>
    _.times JUMP_REPEAT, (n) =>
      _.delay =>
        newState =
          x : @startingState.x + JUMP_X_CHANGE
          y : @startingState.y + JUMP_Y_CHANGE
        @callback newState
      , JUMP_DELAY * n

  up: () =>
    _.times JUMP_REPEAT, (n) =>
      _.delay =>
        newState =
          x : @startingState.x + JUMP_X_CHANGE
          y : @startingState.y - JUMP_Y_CHANGE
        @callback newState
      , JUMP_DELAY * n

module.exports = Jump
