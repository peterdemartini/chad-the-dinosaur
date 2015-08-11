DefaultBody = require './default-body'
config      = require '../config'

class RobotChicken extends DefaultBody
  constructor: (uid, screen, dependencies={}) ->
    super screen, dependencies
    @config = config.ROBOT_CHICKEN
    @uid = uid
    @width = @config.WIDTH
    @height = @config.HEIGHT

  add: =>
    @object = @PhysicsJS.body 'rectangle', @getProperties()
    @object

  go: =>
    @object.state.vel.set @config.VELOCITY_X, @config.VELOCITY_Y

  getImage: =>
    image = new Image
    image.src = @config.IMAGE_PATH
    image.width = @width
    image.height = @height
    return image

  getProperties: =>
    x = @screen.width - @config.START_X
    y = @screen.height - config.GRASS.HEIGHT - @config.START_Y
    y += @_.random -20, 20
    properties =
      uid: @uid
      view: @getImage()
      x: x
      y: y
      width: @width
      height: @height
      vx: @config.VX
      vy: @config.VY
      restitution: @config.RESTITUTION
      cof: @config.COF
      treatment: @config.TREATMENT
      typeObj: @config.TYPE
      mass: @config.MASS
    return properties

module.exports = RobotChicken
