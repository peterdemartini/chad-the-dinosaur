_            = require 'lodash'
{Common,Svg,Vertices,Bodies} = require 'matter-js'

DEFAULT_COLORS = [
  '#556270'
  '#4ECDC4'
  '#C7F464'
  '#FF6B6B'
  '#C44D58'
]

class SvgElement
  constructor: ({@name,@colors,@x,@y,@options,@scale}) ->

  getOptions: =>
    color = Common.choose(@colors ? DEFAULT_COLORS)
    bodyOptions =
      render:
        fillStyle: color
        strokeStyle: color
    _.extend {}, bodyOptions, @options

  get: (callback) =>
    $.get("./assets/#{@name}.svg").done (data) => callback null, data

  getVertexSets: (data) =>
    vertexSets = []
    $(data).find('path').each (i, path) =>
      points = Svg.pathToVertices path, 30
      vertexSets.push Vertices.scale points, @scale
    return vertexSets

  build: (callback) =>
    @get (error, data) =>
      return callback error if error?
      body = Bodies.fromVertices @x, @y, @getVertexSets(data), @getOptions(), true
      return callback new Error 'Invalid Body' unless body?
      callback null, body

module.exports = SvgElement
