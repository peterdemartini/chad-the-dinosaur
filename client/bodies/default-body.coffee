RealPhysicsJS = require '../../PhysicsJS/'

class DefaultBody
  constructor: (screen, dependencies={}) ->
    @screen = screen
    @PhysicsJS = dependencies.PhysicsJS ? RealPhysicsJS
    @_ = dependencies._ ? require 'lodash'

module.exports = DefaultBody
