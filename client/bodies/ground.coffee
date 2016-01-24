_ = require 'lodash'
{Bodies, World} = require 'matter-js'

class Ground
  constructor: (@engine, {@width, @height}) ->

  add: =>
    @body = Bodies.rectangle @width / 2, @height - 30, @width, 60, isStatic: true
    World.addBody @engine.world, @body

module.exports = Ground
