DefaultBody = require './default-body'
config      = require '../config'

class Backdrop extends DefaultBody
  constructor: (screen, dependencies={}) ->
    super screen, dependencies

  add: =>
    return [@addGround(), @addSky(), @addSun()]

  addGround: =>
    properties =
      uid: config.GRASS.UID
      styles:
        fillStyle: '#4F9400'
      x: 0
      y: @screen.height - config.GRASS.HEIGHT + 50
      width: @screen.width * 2
      height: config.GRASS.HEIGHT
      typeObj: config.GRASS.TYPE
      treatment: 'static'
    @PhysicsJS.body 'rectangle', properties

  addSky: =>
    @PhysicsJS.body 'rectangle'

  addSun: =>
    @PhysicsJS.body 'rectangle'

module.exports = Backdrop
