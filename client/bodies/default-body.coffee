RealPhysicsJS = require '../../PhysicsJS/'

class DefaultBody
  constructor: (dependencies={}) ->
    @PhysicsJS = dependencies.PhysicsJS ? RealPhysicsJS

module.exports = DefaultBody
