DefaultBody = require './default-body'
config      = require '../config'

class RobotChicken extends DefaultBody
  constructor: (uid, screen, dependencies={}) ->
    super screen, dependencies
    @uid = uid
    @width = config.ROBOT_CHICKEN.WIDTH
    @height = config.ROBOT_CHICKEN.HEIGHT

  add: =>
    @object = @PhysicsJS.body 'rectangle', @getProperties()
    @object

  getImage: =>
    image = new Image
    image.src = '/assets/robot-chicken.svg'
    image.width = @width
    image.height = @height
    return image

  getProperties: =>
    properties =
      uid: @uid
      view: @getImage()
      x: @screen.width - config.ROBOT_CHICKEN.START_X
      y: @screen.height - config.GRASS.HEIGHT - config.ROBOT_CHICKEN.START_Y
      width: @width
      height: @height
      vx: config.ROBOT_CHICKEN.VX
      vy: config.ROBOT_CHICKEN.VY
      restitution: 0
      cof: 1
      treatment: 'kinematic'
      typeObj: 'robot-chicken'
    return properties

module.exports = RobotChicken
