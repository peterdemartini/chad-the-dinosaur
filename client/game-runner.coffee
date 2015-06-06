RealPhysicsJS = require '../PhysicsJS/'
ChadTheDinosaur = require './bodies/chad-the-dinosaur.coffee'

class GameRunner
  constructor: (@element, dependencies={}) ->
    @PhysicsJS = dependencies.PhysicsJS ? RealPhysicsJS
    @world = @PhysicsJS()
    @screen = width: 0, height: 0

  setScreen: (@screen) =>

  onTick: =>
    @PhysicsJS.util.ticker.on (time) =>
      @world.step time

  onStep: =>
    @world.on 'step', =>
      @world.render()

  start: =>
    @addRender()
    @addChad()
    @addBehaviors()
    @onTick()
    @onStep()
    @PhysicsJS.util.ticker.start()

  addChad: =>
    dinosaur = new ChadTheDinosaur PhysicsJS: @PhysicsJS
    @world.add dinosaur.add()

  addRender: =>
    config =
      el: @element
      width: @screen.width
      height: @screen.height
      meta: false
      styles:
        circle:
          strokeStyle: '#000',
          lineWidth: 1,
          fillStyle: '#000'
    renderer = @PhysicsJS.renderer 'canvas', config
    @world.add renderer

  addBehaviors: =>
    gravity = @PhysicsJS.behavior 'body-impulse-response'
    @world.add gravity
    collision = @PhysicsJS.behavior 'constant-acceleration'
    @world.add collision

    viewportBounds = @PhysicsJS.aabb 0, 0, @screen.width, @screen.height - 100
    edgeConfig =
      aabb: viewportBounds,
      restitution: 0.99,
      cof: 0.99
    edgeDetection = @PhysicsJS.behavior 'edge-collision-detection', edgeConfig
    @world.add edgeDetection


module.exports = GameRunner
