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

  left: (callback=->) =>
    return callback new Error('already moving') if @isMoving()
    @movingLeft = true
    @object.sleep false
    done = =>
      @movingLeft = false
      @object.sleep true
      callback()
    _.delay done, @config.MOVE_DELAY

  right: (callback=->) =>
    return callback new Error('already moving') if @isMoving()
    @movingRight = true
    @object.sleep false
    done = =>
      @movingRight = false
      @object.sleep true
      callback()
    _.delay done, @config.MOVE_DELAY

  isMoving: =>
    @jumping || @movingRight || @movingLeft

  onStep: =>
    @object.state.pos.x -= @config.MOVE_X if @movingLeft
    @object.state.pos.x += @config.MOVE_X if @movingRight

  onCollision: (impact) =>
    {bodyA, bodyB} = impact
    if @jumping &&  bodyA.typeObj == @TYPE && impact.pos.y == 25
      @jumping = false
      @object.sleep true
    if bodyB.typeObj == config.ROBOT_CHICKEN.TYPE
      console.log 'chicken impact', impact

module.exports = ChadTheDinosaur
