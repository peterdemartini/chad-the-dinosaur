_            = require 'lodash'
{Svg,Vertices,Bodies} = require 'matter-js'

class SvgElement
  constructor: ({@name,@color,@x,@y,@options,@scale}) ->

  getOptions: =>
    bodyOptions =
      render:
        fillStyle: @color
        strokeStyle: @color
    _.extend {}, bodyOptions, @options

  get: (callback) =>
    $.get("./assets/#{@name}.svg").done (data) => callback null, data

  getVertexSets: (data) =>
    vertexSets = []
    $(data).find('path').each (i, path) =>
      points = Svg.pathToVertices path, 30
      vertexSets.push Vertices.scale points, @scale, @scale, 0
    return vertexSets

  build: (callback) =>
    @get (error, data) =>
      return callback error if error?
      body = Bodies.fromVertices @x, @y, @getVertexSets(data), @getOptions(), true
      console.log 'body', body
      return callback new Error 'Invalid Body' unless body?
      callback null, body

module.exports = SvgElement
