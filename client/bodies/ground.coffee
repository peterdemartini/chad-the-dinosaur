_ = require 'lodash'
{Bodies, World} = require 'matter-js'

class Ground
  constructor: ({@width, @height}) ->

  add: (callback) =>
    width = @width / 2
    height = @height - 30
    x = @width
    y = 60
    @body = Bodies.rectangle width, height, x, y, {isStatic: true}
    callback null, @body

module.exports = Ground
