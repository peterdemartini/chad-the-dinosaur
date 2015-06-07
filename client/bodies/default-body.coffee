RealPhysicsJS = require '../../PhysicsJS/'

class DefaultBody
  constructor: (screen, dependencies={}) ->
    @screen = screen
    @PhysicsJS = dependencies.PhysicsJS ? RealPhysicsJS

module.exports = DefaultBody
