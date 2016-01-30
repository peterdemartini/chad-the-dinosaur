
_                = require 'lodash'
config           = require './config'
changingInterval = require 'changing-interval'
BodiesFactory    = require './bodies-factory'
async            = require 'async'

{
  Engine,
  World,
  Bodies,
  Render
} = require 'matter-js'

class GameRunner
  constructor: (@element) ->
    @renderOptions = config.RENDER_OPTIONS

  start: =>
    @engine = Engine.create
      render:
        element: @element
        options: @renderOptions
    @bodies = new BodiesFactory @renderOptions
    @_setup (error) =>
      return console.error 'Error', error if error?
      Engine.run @engine

  setRenderOptions: (@renderOptions) =>
    {@width, @height} = @renderOptions
    return unless @engine?
    @renderOptions = _.extend {}, @engine.render.options, @renderOptions
    @engine.render.options = @renderOptions

  left: =>
  right: =>
  up: =>
  down: =>
  pause: =>
  resume: =>

  _setup: (callback) =>
    async.map ['Ground', 'Chad'], @bodies.add, (error, bodies) =>
      return callback error if error?
      _.each bodies, (body) =>
        World.addBody @engine.world, body
      callback()

module.exports = GameRunner
