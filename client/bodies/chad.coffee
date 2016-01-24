_ = require 'lodash'
{Bodies, World} = require 'matter-js'

class Chad
  constructor: (@engine, {@width, @height}) ->

  add: =>
    @body = Bodies.rectangle 100, 40, 40, 40
    World.addBody @engine.world, @body

module.exports = Chad
