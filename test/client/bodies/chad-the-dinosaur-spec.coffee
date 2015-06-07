ChadTheDinosaur = require '../../../client/bodies/chad-the-dinosaur'
PhysicsJS = require '../PhysicsJS'

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
        uid: 1
        view:
          image: 'dinosaur'
        x: 50
        y: 200
        width: 50
        height: 50
        vx: 0.2
        vy: 0.01
        restitution: 1
        cof: 0
        typeObj: 'chad-the-dinosaur'

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

  describe '->onStep', ->
    it 'should be a function', ->
      expect(@sut.onStep).to.be.a 'function'

  describe '->onCollision', ->
    describe 'when called when jumping', ->
      beforeEach ->
        @sut.jumping = true
        @sut.object =
          sleep: sinon.spy()

      describe 'when called with the incorrect types', ->
        beforeEach ->
          @sut.onCollision(bodyA: {typeObj: 'not-the-dinosaur'}, bodyB: {uid: 3})

        it 'should not call sleep', ->
          expect(@sut.object.sleep).to.not.have.been.called

      describe 'when called with the correct types', ->
        beforeEach ->
          @sut.onCollision(bodyA: {typeObj: @sut.TYPE}, bodyB: {uid: 2})

        it 'should call sleep', ->
          expect(@sut.object.sleep).to.have.been.calledWith true

        it 'should set jumping to false', ->
          expect(@sut.jumping).to.be.false
