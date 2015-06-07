RealPhysicsJS   = require '../PhysicsJS/'
ChadTheDinosaur = require './bodies/chad-the-dinosaur'
_               = require 'lodash'

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
      @dinosaur.onStep()

  onCollision: =>
    @world.on 'collisions:detected', (data) =>
      _.each data.collisions, (impact) =>
        @dinosaur.onCollision impact

  start: =>
    @addRender()
    @addChad()
    @addBehaviors()
    @onTick()
    @onStep()
    @onCollision()
    @PhysicsJS.util.ticker.start()

  addChad: =>
    @dinosaur = new ChadTheDinosaur @screen, PhysicsJS: @PhysicsJS
    @world.add @dinosaur.add()

  up: =>
    @dinosaur.jump()

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
    collisions = @PhysicsJS.behavior 'body-impulse-response'
    @world.add collisions
    gravity = @PhysicsJS.behavior 'constant-acceleration'
    @world.add gravity
    sweepPrune = @PhysicsJS.behavior 'sweep-prune'
    @world.add sweepPrune

    viewportBounds = @PhysicsJS.aabb 0, 0, @screen.width, @screen.height - 100
    edgeConfig =
      aabb: viewportBounds,
      restitution: 0.99,
      cof: 0.99
    edgeDetection = @PhysicsJS.behavior 'edge-collision-detection', edgeConfig
    @world.add edgeDetection


module.exports = GameRunner
