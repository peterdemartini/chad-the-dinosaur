_           = require 'lodash'
DefaultBody = require './default-body'
config      = require '../config'

class ChadTheDinosaur extends DefaultBody
  constructor: (screen, dependencies={}) ->
    super screen, dependencies
    @config = config.CHAD
    @width = @config.WIDTH
    @height = @config.HEIGHT
    @jumping = false
    @movingLeft = false
    @movingRight = false
    @TYPE = @config.TYPE

  getImage: =>
    image = new Image
    image.src = @config.IMAGE_PATH
    image.width = @width
    image.height = @height
    return image

  getProperties: =>
    properties =
      uid: @config.UID
      view: @getImage()
      x: @config.START_X
      y: @screen.height - config.GRASS.HEIGHT
      width: @width
      height: @height
      vx: @config.VX
      vy: @config.VY
      restitution: @config.RESTITUTION
      cof: @config.COF
      typeObj: @config.TYPE
      # treatment: 'kinematic'
    return properties

  add: =>
    @object = @PhysicsJS.body 'rectangle', @getProperties()
    @object.sleep true
    @object

  jump: =>
    return if @jumping
    @object.state.vel.set(0.2, -0.2)
    @object.sleep false
    @jumping = true

  move: (direction, x, y, callback=->) =>
    return callback new Error('already moving') if @isMoving()
    @movingLeft = true if direction == 'left'
    @movingRight = true if direction == 'right'
    @object.state.vel.set x, y
    @object.sleep false
    done = =>
      @movingLeft = false if direction == 'left'
      @movingRight = false if direction == 'right'
      @object.sleep true
      callback()
    _.delay done, @config.MOVE_DELAY

  left: (callback=->) =>
    @move 'left', -@config.VELOCITY_X, @config.VELOCITY_Y, callback

  right: (callback=->) =>
    @move 'right', @config.VELOCITY_X, @config.VELOCITY_Y, callback

  isMoving: =>
    @jumping || @movingRight || @movingLeft

  onCollision: (impact) =>
    {bodyA, bodyB} = impact
    if @jumping &&  bodyA.typeObj == @TYPE && impact.pos.y == 25
      @jumping = false
      @object.sleep true
    if bodyB.typeObj == config.ROBOT_CHICKEN.TYPE
      console.log 'chicken impact', impact

module.exports = ChadTheDinosaur
