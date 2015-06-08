Backdrop = require '../../../client/bodies/backdrop'
PhysicsJS = require '../PhysicsJS'

describe 'Backdrop', ->
  beforeEach ->
    screen = width: 1000, height: 600
    @sut = new Backdrop screen, PhysicsJS: PhysicsJS

  describe '->add', ->
    beforeEach ->
      @sut.addGround = sinon.stub().returns body: 'ground'
      @sut.addSky    = sinon.stub().returns body: 'sky'
      @sut.addSun    = sinon.stub().returns body: 'sun'
      @bodies = @sut.add()

    it 'should return an array of bodies', ->
      ground = body: 'ground'
      sky    = body: 'sky'
      sun    = body: 'sun'
      expect(@bodies).to.deep.equal [ground, sky, sun]

  describe '->addGround', ->
    beforeEach ->
      PhysicsJS.body = sinon.stub().returns body: 'ground'
      @body = @sut.addGround()

    it 'should call PhysicsJS.body', ->
      properties =
        uid: 50
        styles:
          fillStyle: '#4F9400'
        x: 0
        y: 550
        width: 2000
        height: 100
        typeObj: 'ground'
        treatment: 'static'
      expect(PhysicsJS.body).to.have.been.calledWith 'rectangle', properties

    it 'should return the correct body', ->
      expect(@body).to.deep.equal body: 'ground'
