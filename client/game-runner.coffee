RealPhysicsJS = require './PhysicsJS/'

class GameRunner
  constructor: (dependencies={}) ->
    @PhysicsJS = dependencies.PhysicsJS ? RealPhysicsJS
    @world = @PhysicsJS()

  onTick: =>
    @PhysicsJS.util.ticker.on (time) =>
      @world.step time

  start: =>
    @addDinosaur()
    @PhysicsJS.util.ticker.start()

  addDinosaur: =>
    properties =
      x: 50,
      y: 100,
      radius: 20
    dinosaur = @PhysicsJS.body 'circle', properties
    @world.add dinosaur

module.exports = GameRunner
