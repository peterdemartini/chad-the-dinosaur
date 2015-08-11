DefaultBody = require './default-body'
config      = require '../config'

class RobotChicken extends DefaultBody
  constructor: (uid, screen, dependencies={}) ->
    super screen, dependencies
    @config = config.ROCKET
    @uid = uid
    @width = @config.WIDTH
    @height = @config.HEIGHT

  add: (startPos={}) =>
    @object = @PhysicsJS.body 'rectangle', @getProperties(startPos)
    @object

  go: =>
    @object.state.vel.set @config.VELOCITY_X, @config.VELOCITY_Y

  getImage: =>
    image = new Image
    image.src = @config.IMAGE_PATH
    image.width = @width
    image.height = @height
    return image

  getProperties: (startPos={}) =>
    properties =
      uid: @uid
      view: @getImage()
      x: startPos.x
      y: startPos.y - 10
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
