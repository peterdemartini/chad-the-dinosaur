
_                = require 'lodash'
config           = require './config'
changingInterval = require 'changing-interval'
BodiesFactory    = require './bodies-factory'

{
  Engine,
  World,
  Bodies,
  Render
} = require 'matter-js'

class GameRunner
  constructor: (@element) ->
    @renderOptions = config.RENDER_OPTIONS
    console.log '@renderOptions', @renderOptions

  start: =>
    @engine = Engine.create
      render:
        element: @element
        options: @renderOptions
    @bodies = new BodiesFactory @engine, @renderOptions
    @_setup()
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

  _setup: =>
    @bodies.add 'Ground'
    @bodies.add 'Chad'

module.exports = GameRunner
