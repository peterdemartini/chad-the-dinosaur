DefaultBody = require './default-body'
config      = require '../config'

class Backdrop extends DefaultBody
  constructor: (screen, dependencies={}) ->
    super screen, dependencies
    @grassConfig = config.GRASS
    @skyConfig = config.SKY
    @sunConfig = config.SUN

  add: =>
    return [@addGround(), @addSky(), @addSun()]

  addGround: =>
    properties =
      uid: @grassConfig.UID
      styles:
        fillStyle: @grassConfig.FILL_STYLE
      x: @grassConfig.START_X
      y: @screen.height - @grassConfig.HEIGHT + @grassConfig.START_Y
      width: @screen.width * 2
      height: @grassConfig.HEIGHT
      typeObj: @grassConfig.TYPE
      treatment: @grassConfig.TREATMENT
    @PhysicsJS.body @grassConfig.BODY_TYPE, properties

  addSky: =>
    @PhysicsJS.body @skyConfig.BODY_TYPE

  addSun: =>
    @PhysicsJS.body @sunConfig.BODY_TYPE

module.exports = Backdrop
