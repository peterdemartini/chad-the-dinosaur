GameRunner = require '../../client/game-runner'
PhysicsJS = require './PhysicsJS'

describe 'GameRunner', ->
  beforeEach ->
    @sut = new GameRunner PhysicsJS: PhysicsJS

  describe '->constructor', ->
    it 'should have a world', ->
      expect(@sut.world).to.exist

  describe '->on', ->
    beforeEach ->
      @sut.onTick()

    it 'should listen for ticks', ->
      expect(PhysicsJS.util.ticker.on).to.have.been.called

    it 'should call world.step', ->
      expect(@sut.world.step).to.have.been.called

  describe '->start', ->
    beforeEach ->
      @sut.addDinosaur = sinon.spy()
      @sut.start()

    it 'should start listening for ticks', ->
      expect(PhysicsJS.util.ticker.start).to.have.been.called

    it 'should call addDinosaur', ->
      expect(@sut.addDinosaur).to.have.been.called

  describe '->addDinosaur', ->
    beforeEach ->
      @sut.PhysicsJS.body = sinon.stub().returns name: 'dinosaur'
      @sut.addDinosaur()

    it 'should call PhysicsJS.body', ->
      properties =
        x: 50,
        y: 100,
        radius: 20
      expect(PhysicsJS.body).to.have.been.calledWith 'circle', properties

    it 'should add it to the world', ->
      expect(@sut.world.add).to.have.been.calledWith name: 'dinosaur'
