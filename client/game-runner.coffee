RealPhysicsJS   = require '../PhysicsJS/'
ChadTheDinosaur = require './bodies/chad-the-dinosaur'
Backdrop        = require './bodies/backdrop'
config          = require './config'
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
    @addBackdrop()
    @addBehaviors()
    @onTick()
    @onStep()
    @onCollision()
    @PhysicsJS.util.ticker.start()

  addChad: =>
    @dinosaur = new ChadTheDinosaur @screen, PhysicsJS: @PhysicsJS
    @world.add @dinosaur.add()

  addBackdrop: =>
    @backdrop = new Backdrop @screen, PhysicsJS: @PhysicsJS
    @world.add @backdrop.add()

  up: =>
    @dinosaur.jump()

  left: =>
    @dinosaur.left()

  right: =>
    @dinosaur.right()

  addRender: =>
    renderConfig =
      el: @element
      width: @screen.width
      height: @screen.height
      meta: false
      styles:
        circle:
          strokeStyle: '#000',
          lineWidth: 1,
          fillStyle: '#000'
    renderer = @PhysicsJS.renderer 'canvas', renderConfig
    @world.add renderer

  addBehaviors: =>
    collisions = @PhysicsJS.behavior 'body-impulse-response'
    @world.add collisions
    gravity = @PhysicsJS.behavior 'constant-acceleration'
    @world.add gravity
    sweepPrune = @PhysicsJS.behavior 'sweep-prune'
    @world.add sweepPrune

    viewportBounds = @PhysicsJS.aabb 0, 0, @screen.width, @screen.height - config.GRASS.HEIGHT
    edgeConfig =
      aabb: viewportBounds,
      restitution: config.GAME.RESTITUTION,
      cof: config.GAME.COF
    edgeDetection = @PhysicsJS.behavior 'edge-collision-detection', edgeConfig
    @world.add edgeDetection

module.exports = GameRunner
