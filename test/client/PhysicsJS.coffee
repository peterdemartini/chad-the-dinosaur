class PhysicsJS
  constructor: () ->
    @world =
      step: sinon.spy()
      add: sinon.spy()
    return @world

  @body = sinon.spy()
  @util =
    ticker:
      on: sinon.stub().yields(new Date())
      start: sinon.spy()

module.exports = PhysicsJS
