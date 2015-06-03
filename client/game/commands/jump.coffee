_ = require 'lodash'

JUMP_DELAY=50
JUMP_REPEAT=10
JUMP_Y_CHANGE=10
JUMP_X_CHANGE=1

class Jump
  constructor: ->
    @jumping = false

  run: (startingState={}, callback=->)=>
    return if @jumping
    @jumping = true
    @state = startingState
    @callback = callback
    bothDirections = (JUMP_REPEAT * 2)
    _.times bothDirections + 1, (n) =>
      console.log 'jump', n
      _.delay =>
        return @up() if n < JUMP_REPEAT
        return @down() if n < bothDirections
        @end()
      , JUMP_DELAY * n

  end: =>
    @jumping = false
    @startingState = {}
    @callback = null

  down: =>
    console.log 'going down'
    @state =
      x : @state.x + JUMP_X_CHANGE
      y : @state.y + JUMP_Y_CHANGE
    @callback @state

  up: =>
    console.log 'going up'
    @state =
      x : @state.x + JUMP_X_CHANGE
      y : @state.y - JUMP_Y_CHANGE
    @callback @state

module.exports = Jump
