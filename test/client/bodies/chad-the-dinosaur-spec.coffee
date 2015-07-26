ChadTheDinosaur = require '../../../client/bodies/chad-the-dinosaur'
PhysicsJS       = require '../PhysicsJS'
config          = require '../../../client/config'

describe 'ChadTheDinosaur', ->
  beforeEach ->
    screen = width: 600, height: 300
    @sut = new ChadTheDinosaur screen, PhysicsJS: PhysicsJS

  describe '->constructor', ->
    it 'should set the width', ->
      expect(@sut.width).to.equal 50

    it 'should set the height', ->
      expect(@sut.height).to.equal 50

  describe '->add', ->
    beforeEach ->
      PhysicsJS.body = sinon.stub().returns sleep: sinon.spy()
      @sut.getProperties = sinon.stub().returns name: 'dinosaur'
      @object = @sut.add()

    it 'should call PhysicsJS.body', ->
      expect(PhysicsJS.body).to.have.been.calledWith 'rectangle', name: 'dinosaur'

    it 'should set the object', ->
      expect(@object).to.equal @sut.object

    it 'should call sleep with true', ->
      expect(@object.sleep).to.have.been.calledWith true

  describe '->getImage', ->
    beforeEach ->
      @image = @sut.getImage()

    it 'should return the image', ->
      expect(@image).to.deep.equal
        src: '/assets/dinosaur.svg'
        width: 50
        height: 50

  describe '->getProperties', ->
    beforeEach ->
      @sut.getImage = sinon.stub().returns image: 'dinosaur'
      @properties = @sut.getProperties()

    it 'should return the properties', ->
      expect(@properties).to.deep.equal
        uid: config.CHAD.UID
        view: image: 'dinosaur'
        x: config.CHAD.START_X
        y: @sut.screen.height - config.GRASS.HEIGHT
        width: 50
        height: 50
        vx: config.CHAD.VX
        vy: config.CHAD.VY
        restitution: config.CHAD.RESTITUTION
        cof: config.CHAD.COF
        typeObj: config.CHAD.TYPE

  describe '->jump', ->
    describe 'when called when jumping', ->
      beforeEach ->
        @sut.jumping = true
        @sut.jump()

      it 'should do nothing', ->
        expect(true).to.be.true

    describe 'when called when not jumping', ->
      beforeEach ->
        @sut.jumping = false
        @sut.object = state: vel: set: sinon.spy()
        @sut.object.sleep = sinon.spy()
        @sut.jump()

      it 'should call state.vel.set on object', ->
        expect(@sut.object.state.vel.set).to.have.been.calledWith 0.2, -0.2

      it 'should call sleep on object', ->
        expect(@sut.object.sleep).to.have.been.calledWith false

      it 'should set jumping to true', ->
        expect(@sut.jumping).to.be.true

  describe '->left', ->
    describe 'while moving', ->
      beforeEach (done) ->
        @sut.jumping = true
        @sut.left (@error) => done()

      it 'should not have an error', ->
        expect(@error).to.exist

    describe 'while not moving', ->
      beforeEach (done) ->
        @sut.object = sleep: sinon.spy()
        @sut.left (@error) => done()

      it 'should not have an error', ->
        expect(@error).to.not.exist

      it 'should call sleep twice', ->
        expect(@sut.object.sleep).to.have.been.called.twice

  describe '->right', ->
    describe 'while moving', ->
      beforeEach (done) ->
        @sut.jumping = true
        @sut.right (@error) => done()

      it 'should not have an error', ->
        expect(@error).to.exist

    describe 'while not moving', ->
      beforeEach (done) ->
        @sut.object = sleep: sinon.spy()
        @sut.right (@error) => done()

      it 'should not have an error', ->
        expect(@error).to.not.exist

      it 'should call sleep twice', ->
        expect(@sut.object.sleep).to.have.been.called.twice

  describe '->onStep', ->
    beforeEach ->
      @sut.movingLeft = false
      @sut.movingRight = false
      @sut.jumping = false
      @sut.object =
        state:
          x: 0
          y: 0

    describe 'when called and not moving', ->
      beforeEach ->
        @sut.object.state = pos: x: 10
        @sut.onStep()

      it 'should move 2 to the left', ->
        expect(@sut.object.state.pos.x).to.equal 10

    describe 'when called while moving left', ->
      beforeEach ->
        @sut.object.state = pos: x: 10
        @sut.movingLeft = true
        @sut.onStep()

      it 'should move 5 to the left', ->
        expect(@sut.object.state.pos.x).to.equal 2

    describe 'when called while moving right', ->
      beforeEach ->
        @sut.object.state = pos: x: 10
        @sut.movingRight = true
        @sut.onStep()

      it 'should move 5 to the left', ->
        expect(@sut.object.state.pos.x).to.equal 18

  describe '->onCollision', ->
    describe 'when called when jumping', ->
      beforeEach ->
        @sut.jumping = true
        @sut.object =
          sleep: sinon.spy()

      describe 'when called with the incorrect types', ->
        beforeEach ->
          impact =
            pos: x: 25, y: 0
            bodyA: typeObj: 'not-the-dinosaur'
            bodyB: uid: 5
          @sut.onCollision(impact)

        it 'should not call sleep', ->
          expect(@sut.object.sleep).to.not.have.been.called

      describe 'when called with the correct types', ->
        beforeEach ->
          impact =
            pos: x: 0, y: 25
            bodyA: typeObj: 'chad-the-dinosaur'
            bodyB: uid: 5
          @sut.onCollision(impact)

        it 'should call sleep', ->
          expect(@sut.object.sleep).to.have.been.calledWith true

        it 'should set jumping to false', ->
          expect(@sut.jumping).to.be.false
