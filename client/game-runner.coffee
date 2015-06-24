RealPhysicsJS   = require '../PhysicsJS/'
ChadTheDinosaur = require './bodies/chad-the-dinosaur'
Rocket          = require './bodies/rocket'
RobotChicken    = require './bodies/robot-chicken'
Backdrop        = require './bodies/backdrop'
config          = require './config'
_               = require 'lodash'

class GameRunner
  constructor: (@element, dependencies={}) ->
    @PhysicsJS = dependencies.PhysicsJS ? RealPhysicsJS
    @world = @PhysicsJS()
    @screen = width: 0, height: 0
    @chickens = {}
    @rockets = {}
    @running = false
    @asyncEvents = []

  setScreen: (@screen) =>

  resume: =>
    console.log 'resume'
    _.each @asyncEvents, (async) =>
      async.event() unless async.id

  pause: =>
    console.log 'pause'
    _.each @asyncEvents, (async) =>
      clearInterval async.id
      clearTimeout async.id
      async.id = null

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
    @running = true
    @addRender()
    @addChad()
    @addChickens()
    @addBackdrop()
    @addBehaviors()
    @onTick()
    @onStep()
    @onCollision()
    @PhysicsJS.util.ticker.start()

  addChad: =>
    @dinosaur = new ChadTheDinosaur @screen, PhysicsJS: @PhysicsJS
    @world.add @dinosaur.add()

  addChickens: =>
    @addChicken()
    async = {}
    async.id = setInterval @addChicken, _.random(1000, 4000)
    async.event = @addChickens
    @asyncEvents.push async

  addChicken: =>
    uid = _.random(1000, 1200)
    chicken = new RobotChicken uid, @screen, PhysicsJS: @PhysicsJS
    @world.add chicken.add()
    @chickens[uid] = chicken

  addBackdrop: =>
    @backdrop = new Backdrop @screen, PhysicsJS: @PhysicsJS
    @world.add @backdrop.add()

  up: =>
    @dinosaur.jump()

  left: =>
    @dinosaur.left()

  right: =>
    @dinosaur.right()

  fire: =>
    uid = _.random(1200, 1500)
    rocket = new Rocket uid, @screen, PhysicsJS: @PhysicsJS
    @world.add rocket.add(@dinosaur.object.state.pos)
    @rockets[uid] = rocket

  addRender: =>
    renderConfig =
      el: @element
      width: @screen.width
      height: @screen.height
      meta: false
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
