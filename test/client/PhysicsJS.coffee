class PhysicsJS
  constructor: () ->
    @world =
      step: sinon.spy()
      add: sinon.spy()
      on: sinon.stub().yields()
      render: sinon.spy()
    return @world

  @body = sinon.spy()
  @renderer = sinon.spy()
  @behavior = sinon.spy()
  @aabb = sinon.spy()
  @util =
    ticker:
      on: sinon.stub().yields(new Date())
      start: sinon.spy()

module.exports = PhysicsJS
