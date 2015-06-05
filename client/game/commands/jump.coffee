Framer = require '../framer'
JUMP_LENGTH=25
JUMP_REPEAT=10
JUMP_Y_CHANGE=10
JUMP_X_CHANGE=1

class Jump
  constructor: (dependencies={})->
    @jumping = false
    @bothDirections = JUMP_REPEAT * 2
    @framer = dependencies.framer ? new Framer @bothDirections + 1, JUMP_LENGTH

  start: (startingState={}, callback=->)=>
    return if @jumping
    @jumping = true
    @state = startingState
    @callback = callback

    @framer.start (n) =>
      return @up() if n < JUMP_REPEAT
      return @down() if n < @bothDirections
      @end()

  end: =>
    @jumping = false
    @startingState = {}
    @callback = null

  down: =>
    @state =
      x : @state.x + JUMP_X_CHANGE
      y : @state.y + JUMP_Y_CHANGE
    @callback @state

  up: =>
    @state =
      x : @state.x + JUMP_X_CHANGE
      y : @state.y - JUMP_Y_CHANGE
    @callback @state

module.exports = Jump
