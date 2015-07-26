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
    return properties

module.exports = RobotChicken
