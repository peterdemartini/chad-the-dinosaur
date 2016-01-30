_ = require 'lodash'
SvgElement = require '../elements/svg'

class RobotChicken
  constructor: ({@width, @height}) ->

  add: (callback) =>
    @svg = new SvgElement
      name: 'robot-chicken'
      x: 1
      y: 1
      scale: 0.1
    @svg.build (error, @body) =>
      callback null, @body

module.exports = RobotChicken
