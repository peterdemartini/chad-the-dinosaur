ChadTheDinosaur = require '../../../client/bodies/chad-the-dinosaur'
PhysicsJS = require '../PhysicsJS'

describe 'ChadTheDinosaur', ->
  beforeEach ->
    @sut = new ChadTheDinosaur PhysicsJS: PhysicsJS

  describe '->constructor', ->
    it 'should set the width', ->
      expect(@sut.width).to.equal 50

    it 'should set the height', ->
      expect(@sut.height).to.equal 50

  describe '->add', ->
    beforeEach ->
      @sut.getProperties = sinon.stub().returns name: 'dinosaur'
      @sut.add()

    it 'should call PhysicsJS.body', ->
      expect(PhysicsJS.body).to.have.been.calledWith 'rectangle', name: 'dinosaur'

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
        y: 100
        width: 50
        height: 50
        vx: 0.2
        vy: 0.01
