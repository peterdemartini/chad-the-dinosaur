GameRunner = require '../../client/game-runner'
PhysicsJS = require './PhysicsJS'

describe 'GameRunner', ->
  beforeEach ->
    @sut = new GameRunner 'the-game', PhysicsJS: PhysicsJS

  describe '->constructor', ->
    it 'should have a world', ->
      expect(@sut.world).to.exist

  describe '->onTick', ->
    beforeEach ->
      @sut.onTick()

    it 'should listen for ticks', ->
      expect(PhysicsJS.util.ticker.on).to.have.been.called

    it 'should call world.step', ->
      expect(@sut.world.step).to.have.been.called

  describe '->start', ->
    beforeEach ->
      @sut.addChad = sinon.spy()
      @sut.addBackdrop = sinon.spy()
      @sut.addRender = sinon.spy()
      @sut.addBehaviors = sinon.spy()
      @sut.onTick = sinon.spy()
      @sut.onStep = sinon.spy()
      @sut.onCollision = sinon.spy()
      @sut.start()

    it 'should start listening for ticks', ->
      expect(PhysicsJS.util.ticker.start).to.have.been.called

    it 'should call addChad', ->
      expect(@sut.addChad).to.have.been.called

    it 'should call addBackdrop', ->
      expect(@sut.addBackdrop).to.have.been.called

    it 'should call addBehaviors', ->
      expect(@sut.addBehaviors).to.have.been.called

    it 'should call addRender', ->
      expect(@sut.addRender).to.have.been.called

    it 'should call onTick', ->
      expect(@sut.onTick).to.have.been.called

    it 'should call onStep', ->
      expect(@sut.onStep).to.have.been.called

    it 'should call onCollision', ->
      expect(@sut.onCollision).to.have.been.called

  describe '->addRender', ->
    beforeEach ->
      @sut.setScreen width: 1000, height: 600
      @sut.PhysicsJS.renderer = sinon.stub().returns el: 'game'
      @sut.addRender()

    it 'should call PhysicsJS.render pixi', ->
      config =
        el: 'the-game'
        width: 1000
        height: 600
        meta: false
        styles:
          circle:
            strokeStyle: '#000',
            lineWidth: 1,
            fillStyle: '#000'

      expect(PhysicsJS.renderer).to.have.been.calledWith 'canvas', config

    it 'should add it to the world', ->
      expect(@sut.world.add).to.have.been.calledWith el: 'game'

  describe '->onStep', ->
    beforeEach ->
      @sut.dinosaur =
        onStep: sinon.spy()
      @sut.onStep()

    it 'should listen for steps', ->
      expect(@sut.world.on).to.have.been.calledWith 'step'

    it 'should call world.step', ->
      expect(@sut.world.render).to.have.been.called

    it 'should call dinosaur.onStep', ->
      expect(@sut.dinosaur.onStep).to.have.been.called

  describe '->addBehaviors', ->
    beforeEach ->
      PhysicsJS.behavior = (type, config) => behavior: type
      PhysicsJS.aabb = sinon.stub().returns type: 'view-port'
      @sut.addBehaviors()

    it 'should should add gravity to the world', ->
      expect(@sut.world.add).to.have.been.calledWith behavior: 'body-impulse-response'

    it 'should should add collision detection to the world', ->
      expect(@sut.world.add).to.have.been.calledWith behavior: 'constant-acceleration'

    it 'should should add edge detection to the world', ->
      expect(@sut.world.add).to.have.been.calledWith behavior: 'edge-collision-detection'

    it 'should should add edge detection to the world', ->
      expect(@sut.world.add).to.have.been.calledWith behavior: 'sweep-prune'

  describe '->setScreen', =>
    beforeEach ->
      @sut.setScreen width: 2, height: 3

    it 'should set the screen size', ->
      expect(@sut.screen).to.deep.equal width: 2, height: 3

  describe '->up', ->
    beforeEach ->
      @sut.dinosaur =
        jump: sinon.spy()
      @sut.up()

    it 'should call dinosaur.jump', ->
      expect(@sut.dinosaur.jump).to.have.been.called

  describe '->left', ->
    beforeEach ->
      @sut.dinosaur =
        left: sinon.spy()
      @sut.left()

    it 'should call dinosaur.left', ->
      expect(@sut.dinosaur.left).to.have.been.called

  describe '->right', ->
    beforeEach ->
      @sut.dinosaur =
        right: sinon.spy()
      @sut.right()

    it 'should call dinosaur.right', ->
      expect(@sut.dinosaur.right).to.have.been.called

  describe '->onCollision', ->
    beforeEach ->
      @sut.world.on = sinon.stub().yields collisions: []
      @sut.dinosaur =
        onCollision: sinon.spy()
      @sut.onCollision()

    it 'should call world.on collision', ->
      expect(@sut.world.on).to.have.been.calledWith 'collisions:detected'
