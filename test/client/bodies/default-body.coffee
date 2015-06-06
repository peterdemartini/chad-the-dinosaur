DefaultBody = require '../../../client/bodies/default-body'
PhysicsJS = require '../PhysicsJS'

describe 'DefaultBody', ->
  beforeEach ->
    @sut = new DefaultBody PhysicsJS: PhysicsJS

  it 'should have property PhysicsJS', ->
    expect(@sut.PhysicsJS).to.equal PhysicsJS
