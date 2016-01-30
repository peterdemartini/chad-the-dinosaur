_ = require 'lodash'
SvgElement = require '../elements/svg'

class Chad
  constructor: ({@width, @height}) ->

  add: (callback) =>
    @svg = new SvgElement
      name: 'dinosaur2'
      x: 100
      y: 40
      scale: 0.3
      color: '#fff'
    @svg.build (error, @body) =>
      callback null, @body

module.exports = Chad
