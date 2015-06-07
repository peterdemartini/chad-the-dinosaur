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
        backgroundColor: 'green'
      x: 0
      y: @screen.height - config.GRASS.HEIGHT
      width: @screen.width
      height: config.GRASS.HEIGHT
      typeObj: config.GRASS.TYPE
      treatment: 'static'
    @PhysicsJS.body 'rectangle', properties

  addSky: =>
    @PhysicsJS.body 'rectangle'

  addSun: =>
    @PhysicsJS.body 'rectangle'

module.exports = Backdrop
