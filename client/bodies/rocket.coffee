DefaultBody = require './default-body'
config      = require '../config'

class RobotChicken extends DefaultBody
  constructor: (uid, screen, dependencies={}) ->
    super screen, dependencies
    @uid = uid
    @width = config.ROCKET.WIDTH
    @height = config.ROCKET.HEIGHT

  add: (startPos={}) =>
    @object = @PhysicsJS.body 'rectangle', @getProperties(startPos)
    @object

  getImage: =>
    image = new Image
    image.src = '/assets/rocket.svg'
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
      vx: config.ROCKET.VX
      vy: config.ROCKET.VY
      restitution: 0
      cof: 1
      treatment: 'kinematic'
      typeObj: config.ROCKET.TYPE
    return properties

module.exports = RobotChicken
