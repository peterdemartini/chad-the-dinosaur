DefaultBody = require '../../../client/bodies/default-body'
PhysicsJS = require '../PhysicsJS'

describe 'DefaultBody', ->
  beforeEach ->
    screen = width: 100, height: 100
    @sut = new DefaultBody screen, PhysicsJS: PhysicsJS

  it 'should have property PhysicsJS', ->
    expect(@sut.PhysicsJS).to.equal PhysicsJS
